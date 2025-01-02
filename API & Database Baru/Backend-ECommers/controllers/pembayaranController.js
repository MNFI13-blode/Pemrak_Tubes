const { sequelize } = require("../models");
const Pembayaran = require("../models/pembayaran");
const DetailPembayaran = require("../models/detailPembayaran");
const Barang = require("../models/barang");
const Pembeli = require("../models/pembeli");
const Penjual = require("../models/penjual");
const Keranjang = require("../models/keranjang");

async function createPembayaran(req, res) {
  const transaction = await sequelize.transaction();

  try {
    const { idPembeli, idPenjual, barang, metodePembayaran } = req.body;

    const pembeli = await Pembeli.findByPk(idPembeli, { transaction });
    const penjual = await Penjual.findByPk(idPenjual, { transaction });

    if (!pembeli) {
      return res.status(404).json({ message: "Pembeli tidak ditemukan" });
    }
    if (!penjual) {
      return res.status(404).json({ message: "Penjual tidak ditemukan" });
    }

    let totalHarga = 0;
    const detailPembayaran = [];

    for (let item of barang) {
      const produk = await Barang.findByPk(item.idBarang, { transaction });
      if (!produk) {
        return res.status(404).json({
          message: `Barang dengan ID ${item.idBarang} tidak ditemukan`,
        });
      }

      if (produk.stok < item.jumlah) {
        return res
          .status(400)
          .json({ message: `Stok barang ${produk.nama_barang} tidak cukup` });
      }

      produk.stok -= item.jumlah;
      await produk.save({ transaction });

      totalHarga += produk.harga * item.jumlah;

      detailPembayaran.push({
        id_barang: item.idBarang,
        nama_barang: produk.nama_barang,
        jumlah_barang: item.jumlah,
        harga_satuan: produk.harga,
      });

      await Keranjang.destroy({
        where: {
          id_pembeli: idPembeli,
          id_barang: item.idBarang,
        },
        transaction,
      });
    }

    if (pembeli.saldo < totalHarga) {
      return res.status(400).json({ message: "Saldo pembeli tidak mencukupi" });
    }

    pembeli.saldo -= totalHarga;
    await pembeli.save({ transaction });

    penjual.saldo += totalHarga;
    await penjual.save({ transaction });

    const pembayaran = await Pembayaran.create(
      {
        id_pembeli: idPembeli,
        id_penjual: idPenjual,
        tanggal_pembayaran: new Date(),
        waktu_pembayaran: new Date().toLocaleTimeString(),
        total: totalHarga,
        metode_pembayaran: metodePembayaran,
      },
      { transaction }
    );

    for (let detail of detailPembayaran) {
      await DetailPembayaran.create(
        {
          id_pembayaran: pembayaran.id_pembayaran,
          id_barang: detail.id_barang,
          jumlah_barang: detail.jumlah_barang,
          harga_satuan: detail.harga_satuan,
        },
        { transaction }
      );
    }

    await transaction.commit();

    return res.status(201).json({
      message: "Pembayaran berhasil",
      data: {
        id_pembayaran: pembayaran.id_pembayaran,
        total: pembayaran.total,
        tanggal_pembayaran: pembayaran.tanggal_pembayaran,
        waktu_pembayaran: pembayaran.waktu_pembayaran,
        metode_pembayaran: pembayaran.metode_pembayaran,
        detail_pembayaran: detailPembayaran,
      },
    });
  } catch (error) {
    await transaction.rollback();
    return res
      .status(500)
      .json({ message: "Terjadi kesalahan", error: error.message });
  }
}

module.exports = {
  createPembayaran,
};
