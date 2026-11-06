const express = require('express');
const router = express.Router();
const notifController = require('../controllers/notificationController');

router.get('/:user_id', notifController.getUserNotifications);
router.post('/', notifController.createNotification);
router.put('/:id/read', notifController.markAsRead);

module.exports = router;