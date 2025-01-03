const express = require('express');
const router = express.Router();
const pembeliController = require('../controllers/pembeliAUTHController');

// Route untuk Reg dan Login Pembeli
router.post('/register',pembeliController.registerPembeli );  // Register Pembeli
router.post('/login', pembeliController.loginPembeli);  // Login Pembeli
router.put('/update-profile', pembeliController.updatetPembeli); // update-Pembeli
module.exports = router;