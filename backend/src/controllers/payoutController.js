const db = require('../config/db');

// 1. Memproses Perhitungan Komisi (10% & 90%) saat Pesanan Selesai (Fitur 16)
exports.calculateCommission = (req, res, next) => {
    const { order_id } = req.params;

    // Ambil total harga dari pesanan
    const getOrderQuery = `SELECT total_price FROM orders WHERE id = ?`;
    db.query(getOrderQuery, [order_id], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        if (results.length === 0) return res.status(404).json({ message: 'Pesanan tidak ditemukan!' });

        const totalPrice = parseFloat(results[0].total_price);
        const platformFee = totalPrice * 0.10; // Komisi 10%
        const providerIncome = totalPrice * 0.90; // Pendapatan 90%

        const updateFeeQuery = `
            UPDATE orders 
            SET platform_fee = ?, provider_income = ? 
            WHERE id = ?
        `;
        db.query(updateFeeQuery, [platformFee, providerIncome, order_id], (err2) => {
            if (err2) return res.status(500).json({ error: err2.message });
            res.json({
                message: 'Perhitungan komisi berhasil dilakukan!',
                details: {
                    total_price: totalPrice,
                    platform_fee_10pct: platformFee,
                    provider_income_90pct: providerIncome
                }
            });
        });
    });
};

// 2. Mengambil Total Saldo Pendapatan Provider (Fitur 16 & 17)
exports.getProviderBalance = (req, res) => {
    const { provider_id } = req.params;

    const query = `
        SELECT 
            COALESCE(SUM(provider_income), 0) AS total_income,
            COALESCE((
                SELECT SUM(amount) FROM payouts WHERE provider_id = ? AND status != 'rejected'
            ), 0) AS total_withdrawn
        FROM orders 
        WHERE provider_id = ? AND status = 'finished'
    `;

    db.query(query, [provider_id, provider_id], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });

        const totalIncome = parseFloat(results[0].total_income);
        const totalWithdrawn = parseFloat(results[0].total_withdrawn);
        const availableBalance = totalIncome - totalWithdrawn;

        res.json({
            provider_id,
            total_income: totalIncome,
            total_withdrawn: totalWithdrawn,
            available_balance: availableBalance
        });
    });
};

// 3. Pengajuan Pencairan Dana / Payout (Fitur 17)
exports.requestPayout = (req, res) => {
    const { provider_id, amount, bank_name, account_number } = req.body;

    if (!provider_id || !amount || !bank_name || !account_number) {
        return res.status(400).json({ message: 'Semua field pengajuan payout wajib diisi!' });
    }

    // Cek kecukupan saldo provider
    const balanceQuery = `
        SELECT 
            COALESCE(SUM(provider_income), 0) AS total_income,
            COALESCE((
                SELECT SUM(amount) FROM payouts WHERE provider_id = ? AND status != 'rejected'
            ), 0) AS total_withdrawn
        FROM orders 
        WHERE provider_id = ? AND status = 'finished'
    `;

    db.query(balanceQuery, [provider_id, provider_id], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });

        const availableBalance = parseFloat(results[0].total_income) - parseFloat(results[0].total_withdrawn);

        if (amount > availableBalance) {
            return res.status(400).json({ 
                message: 'Saldo tidak mencukupi untuk melakukan pencairan dana!',
                available_balance: availableBalance 
            });
        }

        // Simpan pengajuan payout
        const insertQuery = `
            INSERT INTO payouts (provider_id, amount, bank_name, account_number) 
            VALUES (?, ?, ?, ?)
        `;
        db.query(insertQuery, [provider_id, amount, bank_name, account_number], (err2, result) => {
            if (err2) return res.status(500).json({ error: err2.message });
            res.status(201).json({ 
                message: 'Pengajuan pencairan dana berhasil dibuat dan menunggu persetujuan admin!' 
            });
        });
    });
};