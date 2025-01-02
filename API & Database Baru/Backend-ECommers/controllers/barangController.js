const { Barang } = require("../models");

// Fungsi untuk mendapatkan semua barang
const getAllBarang = async (req, res) => {
  try {
    const barang = await Barang.findAll(); // Mengambil semua barang dari tabel
    res.status(200).json(barang);
  } catch (err) {
    console.error("Error saat mengambil data barang:", err);
    res.status(500).json({ error: "Terjadi kesalahan pada server" });
  }
};

// Fungsi untuk menambahkan barang baru
const addBarang = async (req, res) => {
  const { nama_barang, jenis_barang, harga, jumlah_barang, foto, id_penjual } =
    req.body;

  try {
    const barangBaru = await Barang.create({
      nama_barang,
      jenis_barang,
      harga,
      jumlah_barang,
      foto,
      id_penjual,
      createdAt: new Date(),
      updatedAt: new Date(),
    });
    res
      .status(201)
      .json({ message: "Barang berhasil ditambahkan", data: barangBaru });
  } catch (err) {
    console.error("Error saat menambahkan barang:", err);
    res.status(500).json({ error: "Terjadi kesalahan pada server" });
  }
};

// Fungsi untuk menghapus barang berdasarkan id
const deleteBarang = async (req, res) => {
  const { id } = req.params;

  try {
    const result = await Barang.destroy({ where: { id_barang: id } });
    if (result) {
      res.status(200).json({ message: "Barang berhasil dihapus" });
    } else {
      res.status(404).json({ error: "Barang tidak ditemukan" });
    }
  } catch (err) {
    console.error("Error saat menghapus barang:", err);
    res.status(500).json({ error: "Terjadi kesalahan pada server" });
  }
};

module.exports = {
  getAllBarang,
  addBarang,
  deleteBarang,
};
