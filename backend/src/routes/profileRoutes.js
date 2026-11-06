const express = require('express');
const router = express.Router();
const profileController = require('../controllers/profileController');

// Endpoint Mengambil & Update Profil Pengguna (Fitur 3)
router.get('/:id', profileController.getProfile);
router.put('/:id', profileController.updateProfile);

// Endpoint Aktivasi Profil Penyedia Jasa (Fitur 4)
router.post('/activate-provider', profileController.activateProviderProfile);

module.exports = router;