const express = require('express');
const router = express.Router();
const categoryController = require('../controllers/categoryController');

// Endpoint publik untuk mengambil daftar kategori
router.get('/', categoryController.getAllCategories);

module.exports = router;