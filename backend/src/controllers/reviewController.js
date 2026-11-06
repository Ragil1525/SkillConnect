const db = require('../config/db');

// 1. Menambahkan Ulasan & Rating Baru untuk Layanan
exports.createReview = (req, res) => {
    const { service_id, user_id, rating, comment } = req.body;

    // Validasi input wajib
    if (!service_id || !user_id || !rating) {
        return res.status(400).json({ message: 'service_id, user_id, dan rating wajib diisi!' });
    }

    // Validasi rentang rating 1 - 5
    if (rating < 1 || rating > 5) {
        return res.status(400).json({ message: 'Rating harus bernilai antara 1 sampai 5!' });
    }

    const query = `
        INSERT INTO reviews (service_id, user_id, rating, comment) 
        VALUES (?, ?, ?, ?)
    `;

    db.query(query, [service_id, user_id, rating, comment || ''], (err, result) => {
        if (err) return res.status(500).json({ error: err.message });
        res.status(201).json({
            message: 'Ulasan berhasil ditambahkan!',
            reviewId: result.insertId
        });
    });
};

// 2. Mendapatkan Daftar Ulasan Berdasarkan Layanan Tertentu
exports.getReviewsByService = (req, res) => {
    const { service_id } = req.params;
    const query = `
        SELECT reviews.*, users.name as user_name 
        FROM reviews 
        JOIN users ON reviews.user_id = users.id 
        WHERE reviews.service_id = ?
        ORDER BY reviews.created_at DESC
    `;

    db.query(query, [service_id], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
};