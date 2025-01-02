const express = require("express");
const router = express.Router();
const keranjangController = require("../controllers/keranjangController");
const { route } = require("./authPembeli");

router.post("/tambah-barang", keranjangController.tambahBarangKeKeranjang);
router.get("/:id_pembeli", keranjangController.getKeranjangByIdPembeli);
module.exports = router;
