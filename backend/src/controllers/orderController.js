const db = require('../config/db');

// 1. Membuat Pesanan Baru (Checkout / Pesan Jasa)
exports.createOrder = (req, res) => {
    const { service_id, buyer_id, notes } = req.body;

    // Validasi input sederhana
    if (!service_id || !buyer_id) {
        return res.status(400).json({ message: 'service_id dan buyer_id wajib diisi!' });
    }

    // Ambil harga layanan terlebih dahulu untuk memastikan harganya sesuai
    const checkServiceQuery = 'SELECT price FROM services WHERE id = ?';
    db.query(checkServiceQuery, [service_id], (err, serviceResults) => {
        if (err) return res.status(500).json({ error: err.message });
        if (serviceResults.length === 0) {
            return res.status(404).json({ message: 'Layanan tidak ditemukan!' });
        }

        const totalPrice = serviceResults[0].price;

        // Insert pesanan ke database
        const insertOrderQuery = `
            INSERT INTO orders (service_id, buyer_id, total_price, notes, status) 
            VALUES (?, ?, ?, ?, 'pending')
        `;
        db.query(insertOrderQuery, [service_id, buyer_id, totalPrice, notes || ''], (err, result) => {
            if (err) return res.status(500).json({ error: err.message });
            res.status(201).json({
                message: 'Pesanan berhasil dibuat!',
                orderId: result.insertId,
                total_price: totalPrice
            });
        });
    });
};

// 2. Mendapatkan Daftar Pesanan Berdasarkan Pembeli (Buyer)
exports.getOrdersByBuyer = (req, res) => {
    const { buyer_id } = req.params;
    
    // Perhatikan penambahan kata SELECT di baris bawah ini:
    const query = `
        SELECT orders.*, services.title as service_title, users.name as provider_name 
        FROM orders 
        JOIN services ON orders.service_id = services.id 
        JOIN users ON services.provider_id = users.id 
        WHERE orders.buyer_id = ?
        ORDER BY orders.created_at DESC
    `;

    db.query(query, [buyer_id], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
};