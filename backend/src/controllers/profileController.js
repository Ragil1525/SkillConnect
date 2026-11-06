const db = require('../config/db');

// 1. Mengambil Profil Pengguna Berdasarkan ID (Fitur 3)
exports.getProfile = (req, res) => {
    const { id } = req.params;
    const query = `
        SELECT users.id, users.name, users.email, users.role, users.phone, users.address, users.created_at,
               provider_profiles.bio, provider_profiles.skills, provider_profiles.portfolio_url, provider_profiles.service_radius_km, provider_profiles.is_active
        FROM users 
        LEFT JOIN provider_profiles ON users.id = provider_profiles.user_id
        WHERE users.id = ?
    `;

    db.query(query, [id], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        if (results.length === 0) return res.status(404).json({ message: 'Pengguna tidak ditemukan!' });
        res.json(results[0]);
    });
};

// 2. Memperbarui Profil Pengguna (Fitur 3)
exports.updateProfile = (req, res) => {
    const { id } = req.params;
    const { name, phone, address } = req.body;

    const query = `UPDATE users SET name = ?, phone = ?, address = ? WHERE id = ?`;

    db.query(query, [name, phone, address, id], (err, result) => {
        if (err) return res.status(500).json({ error: err.message });
        if (result.affectedRows === 0) return res.status(404).json({ message: 'Pengguna tidak ditemukan!' });
        res.json({ message: 'Profil berhasil diperbarui!' });
    });
};

// 3. Mengajukan / Aktivasi Profil Penyedia Jasa (Fitur 4)
exports.activateProviderProfile = (req, res) => {
    const { user_id, bio, skills, portfolio_url, service_radius_km } = req.body;

    if (!user_id || !bio) {
        return res.status(400).json({ message: 'user_id dan bio wajib diisi untuk aktivasi provider!' });
    }

    // Cek apakah user sudah punya profil provider
    const checkQuery = `SELECT * FROM provider_profiles WHERE user_id = ?`;
    db.query(checkQuery, [user_id], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });

        if (results.length > 0) {
            // Update jika sudah ada
            const updateQuery = `
                UPDATE provider_profiles 
                SET bio = ?, skills = ?, portfolio_url = ?, service_radius_km = ?, is_active = 1 
                WHERE user_id = ?
            `;
            db.query(updateQuery, [bio, skills || '', portfolio_url || '', service_radius_km || 10, user_id], (err2) => {
                if (err2) return res.status(500).json({ error: err2.message });
                res.json({ message: 'Profil penyedia jasa berhasil diperbarui!' });
            });
        } else {
            // Insert baru jika belum ada
            const insertQuery = `
                INSERT INTO provider_profiles (user_id, bio, skills, portfolio_url, service_radius_km, is_active) 
                VALUES (?, ?, ?, ?, ?, 1)
            `;
            db.query(insertQuery, [user_id, bio, skills || '', portfolio_url || '', service_radius_km || 10], (err2) => {
                if (err2) return res.status(500).json({ error: err2.message });
                
                // Ubah role user menjadi provider
                const updateRoleQuery = `UPDATE users SET role = 'provider' WHERE id = ?`;
                db.query(updateRoleQuery, [user_id]);

                res.status(201).json({ message: 'Aktivasi profil penyedia jasa berhasil diajukan!' });
            });
        }
    });
};