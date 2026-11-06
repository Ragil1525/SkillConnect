const express = require('express');
const router = express.Router();
const reviewController = require('../controllers/reviewController');

// Endpoint menambahkan ulasan baru
router.post('/', reviewController.createReview);

// Endpoint melihat daftar ulasan berdasarkan ID layanan
router.get('/service/:service_id', reviewController.getReviewsByService);

module.exports = router;