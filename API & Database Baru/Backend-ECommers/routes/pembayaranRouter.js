const express = require("express");
const router = express.Router();
const pembayaranController = require("../controllers/pembayaranController");
router.post("/", pembayaranController.createPembayaran);

module.exports = router;
