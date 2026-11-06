const db = require('../config/db');

// --- FITUR 20: Pengelolaan Pengguna & Kategori ---

// 1. Ambil daftar semua pengguna
exports.getAllUsers = (req, res) => {
    db.query(`SELECT id, name, email, role, phone, address, created_at FROM users`, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
};

// 2. Hapus atau ubah status pengguna
exports.deleteUser = (req, res) => {
    const { id } = req.params;
    db.query(`DELETE FROM users WHERE id = ?`, [id], (err, result) => {
        if (err) return res.status(500).json({ error: err.message });
        if (result.affectedRows === 0) return res.status(404).json({ message: 'Pengguna tidak ditemukan!' });
        res.json({ message: 'Pengguna berhasil dihapus oleh admin.' });
    });
};

// 3. Tambah Kategori Jasa
exports.addCategory = (req, res) => {
    const { name, description } = req.body;
    db.query(`INSERT INTO categories (name, description) VALUES (?, ?)`, [name, description], (err, result) => {
        if (err) return res.status(500).json({ error: err.message });
        res.status(201).json({ message: 'Kategori baru berhasil ditambahkan!' });
    });
};


// --- FITUR 21: Pengelolaan Transaksi, Pengaduan, & Refund ---

// 1. Lihat Semua Transaksi / Pesanan
exports.getAllTransactions = (req, res) => {
    db.query(`SELECT * FROM orders ORDER BY created_at DESC`, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
};

// 2. Lihat Daftar Pengaduan (Dispute)
exports.getAllDisputes = (req, res) => {
    db.query(`SELECT * FROM disputes ORDER BY created_at DESC`, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
};

// 3. Proses Pengaduan & Refund
exports.resolveDispute = (req, res) => {
    const { dispute_id } = req.params;
    const { action } = req.body; // 'resolved' (selesai tanpa refund) atau 'refunded' (kembalikan dana)

    const newStatus = action === 'refunded' ? 'refunded' : 'resolved';

    db.query(`UPDATE disputes SET status = ? WHERE id = ?`, [newStatus, dispute_id], (err, result) => {
        if (err) return res.status(500).json({ error: err.message });
        
        if (action === 'refunded') {
            // Ubah status order terkait menjadi cancelled / refunded
            db.query(`UPDATE orders SET status = 'cancelled' WHERE id = (SELECT order_id FROM disputes WHERE id = ?)`, [dispute_id]);
        }

        res.json({ message: `Pengaduan berhasil diselesaikan dengan status: ${newStatus}` });
    });
};