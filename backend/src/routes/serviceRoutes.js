const express = require('express');
const router = express.Router();
const serviceController = require('../controllers/serviceController');
const { verifyToken } = require('../middleware/authMiddleware');

router.get('/', serviceController.getAllServices);
router.get('/latest', serviceController.getLatestServices);
router.get('/:id', serviceController.getServiceById);
router.post('/', verifyToken, serviceController.createService);

module.exports = router;