const Keranjang = require("../models/keranjang");
const Barang = require("../models/barang");

exports.tambahBarangKeKeranjang = async (req, res) => {
  const { id_pembeli, id_barang, jumlah_barang } = req.body;

  try {
    const barang = await Barang.findByPk(id_barang);
    if (!barang) {
      return res.status(404).json({ message: "barang tidak ditemukan" });
    }

    const keranjangPembeli = await Keranjang.findOne({
      where: {
        id_pembeli,
        id_barang,
      },
    });
    if (keranjangPembeli) {
      keranjangPembeli.jumlah_barang += jumlah_barang;
      await keranjangPembeli.save();
      return res.status(200).json({
        message: "Barang Sudah ada, jumlah ditambahkan",
        data: keranjangPembeli,
      });
    }

    const keranjang = await Keranjang.create({
      id_pembeli: id_pembeli,
      id_barang: id_barang,
      jumlah_barang: jumlah_barang,
    });

    res.status(200).json({
      message: "Barang Berhasil ditambahkan ke keranjang",
      data: keranjang,
    });
  } catch (error) {
    console.error("Error fetching keranjang:", error);
    res.status(500).json({ message: "Terjadi kesalahan pada server" });
  }
};

exports.getKeranjangByIdPembeli = async (req, res) => {
  const { id_pembeli } = req.params;

  try {
    const keranjang = await Keranjang.findAll({
      where: { id_pembeli },
      include: [
        {
          model: Barang,
          attributes: [
            "id_barang",
            "nama_barang",
            "jenis_barang",
            "harga",
            "jumlah_barang",
            "foto",
            "id_penjual",
          ],
        },
      ],
    });
    if (keranjang.length == 0) {
      return res.status(404).json({ message: "keranjang kosong" });
    }

    res.status(200).json({
      message: "Barang Berhasil ditambahkan ke keranjang",
      data: keranjang,
    });
  } catch (error) {
    console.error("Error fetching keranjang:", error);
    res.status(500).json({ message: "Terjadi kesalahan pada server" });
  }
};
