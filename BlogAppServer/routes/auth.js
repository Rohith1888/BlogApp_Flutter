const express = require('express');
const router = express.Router();
const auth = require('../middleware/auth');
const { register, login, getUserProfile } = require('../controller/authController');

// Register route
router.post('/register', register);

// Login route
router.post('/login', login);
router.get('/profile', auth, getUserProfile);
module.exports = router;