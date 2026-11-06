const db = require('../config/db');

// Ambil semua notifikasi milik user tertentu
exports.getUserNotifications = (req, res) => {
    const { user_id } = req.params;
    const query = `SELECT * FROM notifications WHERE user_id = ? ORDER BY created_at DESC`;

    db.query(query, [user_id], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
};

// Kirim / Buat notifikasi baru (bisa dipanggil internal/admin)
exports.createNotification = (req, res) => {
    const { user_id, title, message } = req.body;

    if (!user_id || !title || !message) {
        return res.status(400).json({ message: 'user_id, title, dan message wajib diisi!' });
    }

    const query = `INSERT INTO notifications (user_id, title, message) VALUES (?, ?, ?)`;
    db.query(query, [user_id, title, message], (err, result) => {
        if (err) return res.status(500).json({ error: err.message });
        res.status(201).json({ message: 'Notifikasi berhasil dikirim!' });
    });
};

// Tandai notifikasi sudah dibaca
exports.markAsRead = (req, res) => {
    const { id } = req.params;
    const query = `UPDATE notifications SET is_read = 1 WHERE id = ?`;

    db.query(query, [id], (err, result) => {
        if (err) return res.status(500).json({ error: err.message });
        if (result.affectedRows === 0) return res.status(404).json({ message: 'Notifikasi tidak ditemukan!' });
        res.json({ message: 'Notifikasi ditandai telah dibaca.' });
    });
};