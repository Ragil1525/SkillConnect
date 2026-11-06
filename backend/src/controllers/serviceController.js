const db = require('../config/db');

// 1. Mendapatkan Semua Daftar Layanan (Dilengkapi Fitur Pencarian & Filter Kategori)
exports.getAllServices = (req, res) => {
    const { search, category_id } = req.query;
    let query = `
        SELECT services.*, users.name as provider_name, categories.name as category_name 
        FROM services 
        JOIN users ON services.provider_id = users.id 
        JOIN categories ON services.category_id = categories.id
        WHERE 1=1
    `;
    
    const queryParams = [];

    // Jika ada parameter pencarian judul/deskripsi
    if (search) {
        query += ` AND (services.title LIKE ? OR services.description LIKE ?)`;
        queryParams.push(`%${search}%`, `%${search}%`);
    }

    // Jika ada filter berdasarkan kategori
    if (category_id) {
        query += ` AND services.category_id = ?`;
        queryParams.push(category_id);
    }

    db.query(query, queryParams, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
};

// 2. Menambahkan Layanan Baru (Khusus Service Provider)
exports.createService = (req, res) => {
    const { category_id, title, description, price, location_type, delivery_type } = req.body;
    const provider_id = req.user.id; // Diambil dari token JWT saat login

    if (!category_id || !title || !price) {
        return res.status(400).json({ message: 'Kategori, judul layanan, dan harga wajib diisi!' });
    }

    const query = 'INSERT INTO services (provider_id, category_id, title, description, price, location_type, delivery_type) VALUES (?, ?, ?, ?, ?, ?, ?)';
    db.query(query, [provider_id, category_id, title, description || null, price, location_type || 'online', delivery_type || 'digital_file'], (err, result) => {
        if (err) return res.status(500).json({ error: err.message });
        res.status(201).json({
            message: 'Layanan berhasil ditambahkan!',
            serviceId: result.insertId
        });
    });
};

// Mendapatkan Detail Layanan Berdasarkan ID
exports.getServiceById = (req, res) => {
    const { id } = req.params;
    const query = `
        SELECT services.*, users.name as provider_name, users.email as provider_email, categories.name as category_name 
        FROM services 
        JOIN users ON services.provider_id = users.id 
        JOIN categories ON services.category_id = categories.id
        WHERE services.id = ?
    `;

    db.query(query, [id], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        if (results.length === 0) {
            return res.status(404).json({ message: 'Layanan tidak ditemukan!' });
        }
        res.json(results[0]);
    });
};

// Mendapatkan Daftar Layanan Terbaru untuk Beranda (Dibatasi misal 6 atau 8 data)
exports.getLatestServices = (req, res) => {
    const query = `
        SELECT services.*, users.name as provider_name, categories.name as category_name 
        FROM services 
        JOIN users ON services.provider_id = users.id 
        JOIN categories ON services.category_id = categories.id
        ORDER BY services.created_at DESC
        LIMIT 6
    `;

    db.query(query, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results);
    });
};