const db = require('../config/db');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

// 1. Fungsi Registrasi Pengguna Baru
exports.register = async (req, res) => {
    try {
        const { name, email, password, phone, role } = req.body;

        // Validasi input sederhana
        if (!name || !email || !password) {
            return res.status(400).json({ message: 'Nama, email, dan password wajib diisi!' });
        }

        // Cek apakah email sudah terdaftar
        db.query('SELECT * FROM users WHERE email = ?', [email], async (err, results) => {
            if (err) return res.status(500).json({ error: err.message });
            if (results.length > 0) {
                return res.status(400).json({ message: 'Email sudah terdaftar!' });
            }

            // Enkripsi password (hashing) agar aman
            const hashedPassword = await bcrypt.hash(password, 10);

            // Normalisasi role input (mendukung 'provider' maupun 'service_provider')
            let dbRole = role || 'customer';
            if (dbRole === 'provider') {
                dbRole = 'service_provider';
            }

            // Simpan user baru ke database
            const query = 'INSERT INTO users (name, email, password, phone, role) VALUES (?, ?, ?, ?, ?)';
            db.query(query, [name, email, hashedPassword, phone || null, dbRole], (err, result) => {
                if (err) return res.status(500).json({ error: err.message });

                // Jika role adalah service_provider, buatkan juga data di tabel provider_profiles
                if (dbRole === 'service_provider') {
                    const userId = result.insertId;
                    db.query('INSERT INTO provider_profiles (user_id) VALUES (?)', [userId]);
                }

                res.status(201).json({
                    message: 'Registrasi berhasil!',
                    userId: result.insertId
                });
            });
        });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

// 2. Fungsi Login Pengguna
exports.login = (req, res) => {
    const { email, password } = req.body;

    if (!email || !password) {
        return res.status(400).json({ message: 'Email dan password wajib diisi!' });
    }

    // Cari user berdasarkan email
    db.query('SELECT * FROM users WHERE email = ?', [email], async (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        if (results.length === 0) {
            return res.status(401).json({ message: 'Email atau password salah!' });
        }

        const user = results[0];

        // Periksa kecocokan password
        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(401).json({ message: 'Email atau password salah!' });
        }

        // --- LOGIKA ROLE & ADMIN ---
        let assignedRole = user.role; // Ambil role asli dari database (misal: 'service_provider' atau 'customer')

        // Daftar email yang secara eksklusif berhak menjadi Admin
        const adminEmails = ['ragilichsan33@gmail.com', 'ultraman10@gmail.com'];

        if (adminEmails.includes(email.trim().toLowerCase())) {
            assignedRole = 'admin'; // Paksa role menjadi admin jika emailnya sesuai
        } else if (assignedRole === 'service_provider') {
            // Normalisasi agar Flutter mendeteksinya dengan mudah sebagai 'provider'
            assignedRole = 'provider'; 
        }
        // ---------------------------

        // Buat token JWT untuk sesi login dengan role yang sudah divalidasi
        const token = jwt.sign(
            { id: user.id, email: user.email, role: assignedRole },
            process.env.JWT_SECRET || 'rahasia_skillconnect_2026',
            { expiresIn: '1d' }
        );

        res.json({
            message: 'Login berhasil!',
            token,
            user: {
                id: user.id,
                name: user.name,
                email: user.email,
                role: assignedRole, // Mengirim role 'provider' ke Flutter
                phone: user.phone
            }
        });
    });
};