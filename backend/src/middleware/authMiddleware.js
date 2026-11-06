const jwt = require('jsonwebtoken');

exports.verifyToken = (req, res, next) => {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1]; // Format: Bearer TOKEN

    if (!token) {
        return res.status(401).json({ message: 'Akses ditolak, token tidak ditemukan!' });
    }

    jwt.verify(token, process.env.JWT_SECRET || 'rahasia_skillconnect_2026', (err, user) => {
        if (err) return res.status(403).json({ message: 'Token tidak valid atau kedaluwarsa!' });
        req.user = user; // Menyimpan data user ke request
        next();
    });
};