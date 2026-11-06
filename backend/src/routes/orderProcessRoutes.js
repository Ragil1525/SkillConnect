const express = require('express');
const router = express.Router();
const orderProcessController = require('../controllers/orderProcessController');

// Fitur 11: Pembayaran Jasa
router.put('/:order_id/pay', orderProcessController.payOrder);

// Fitur 12: Terima / Tolak Pesanan oleh Provider
router.put('/:order_id/respond', orderProcessController.respondOrder);

// Fitur 13: Kelola Status Pekerjaan (In Progress, dll)
router.put('/:order_id/work-status', orderProcessController.updateWorkStatus);

// Fitur 14: Kirim / Serahkan Hasil Pekerjaan
router.put('/:order_id/submit-result', orderProcessController.submitWorkResult);

// Fitur 15: Konfirmasi Penyelesaian Pekerjaan oleh Customer
router.put('/:order_id/confirm', orderProcessController.confirmCompletion);

module.exports = router;