const express = require('express');
const router = express.Router();
const orderController = require('../controllers/orderController');

// Endpoint membuat pesanan baru
router.post('/', orderController.createOrder);

// Endpoint melihat daftar pesanan berdasarkan ID pembeli
router.get('/buyer/:buyer_id', orderController.getOrdersByBuyer);

module.exports = router;