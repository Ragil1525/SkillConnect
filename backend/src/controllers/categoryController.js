const db = require('../config/db');

// Mendapatkan Semua Daftar Kategori
exports.getAllCategories = (req, res) => {
    const query = 'SELECT * FROM categories ORDER BY name ASC';
    db.query(query, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
};