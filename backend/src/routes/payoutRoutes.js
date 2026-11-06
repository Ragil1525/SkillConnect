const express = require('express');
const router = express.Router();
const payoutController = require('../controllers/payoutController');

// Hitung komisi 10% & 90% pesanan (Fitur 16)
router.post('/calculate/:order_id', payoutController.calculateCommission);

// Cek saldo & ringkasan pendapatan provider (Fitur 16 & 17)
router.get('/balance/:provider_id', payoutController.getProviderBalance);

// Pengajuan pencairan dana / payout (Fitur 17)
router.post('/request', payoutController.requestPayout);

module.exports = router;