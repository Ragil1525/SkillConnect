const express = require('express');
const router = express.Router();
const adminController = require('../controllers/adminController');

// Fitur 20: Pengelolaan Pengguna & Kategori
router.get('/users', adminController.getAllUsers);
router.delete('/users/:id', adminController.deleteUser);
router.post('/categories', adminController.addCategory);

// Fitur 21: Transaksi, Pengaduan, & Refund
router.get('/transactions', adminController.getAllTransactions);
router.get('/disputes', adminController.getAllDisputes);
router.put('/disputes/:dispute_id/resolve', adminController.resolveDispute);

module.exports = router;