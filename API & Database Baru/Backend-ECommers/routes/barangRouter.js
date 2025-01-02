const express = require("express");
const router = express.Router();
const barangController = require("../controllers/barangController");

// Rute untuk mendapatkan semua barang
router.get("/", barangController.getAllBarang);

// Rute untuk menambahkan barang baru
router.post("/", barangController.addBarang);

// Rute untuk menghapus barang berdasarkan id
router.delete("/:id", barangController.deleteBarang);

module.exports = router;
