const sequelize = require("../config/database");
const Admin = require("./admin.model");
const Pembeli = require("./pembeli");
const Penjual = require("./penjual");
const Barang = require("./barang");
const Keranjang = require("./keranjang");
const Pembayaran = require("./pembayaran");
const DetailPembayaran = require("./detailPembayaran");

// RELATION
// Relasi antara Pembeli dan Keranjang (1:N)
Pembeli.hasMany(Keranjang, { foreignKey: "id_pembeli" });
Keranjang.belongsTo(Pembeli, { foreignKey: "id_pembeli" });

// Relasi antara Keranjang dan Barang (N:1)
Keranjang.belongsTo(Barang, { foreignKey: "id_barang" });
Barang.hasMany(Keranjang, { foreignKey: "id_barang" });

// Relasi antara Pembeli dan Pembayaran (1:N)
Pembeli.hasMany(Pembayaran, { foreignKey: "id_pembeli" });
Pembayaran.belongsTo(Pembeli, { foreignKey: "id_pembeli" });

// Relasi antara Barang dan DetailPembayaran (1:N)
Barang.hasMany(DetailPembayaran, { foreignKey: "id_barang" });
DetailPembayaran.belongsTo(Barang, { foreignKey: "id_barang" });

// Relasi antara Pembayaran dan DetailPembayaran (1:N)
Pembayaran.hasMany(DetailPembayaran, { foreignKey: "id_pembayaran" });
DetailPembayaran.belongsTo(Pembayaran, { foreignKey: "id_pembayaran" });

// Relasi antara Penjual dan Barang (1:N)
Penjual.hasMany(Barang, { foreignKey: "id_penjual" });
Barang.belongsTo(Penjual, { foreignKey: "id_penjual" });

// Relasi Penjual ke DetailPembayaran (melalui Barang) dihilangkan
// Penjual bisa mengetahui barang yang telah dibeli melalui Barang dan DetailPembayaran

module.exports = {
  sequelize,
  Admin,
  Pembeli,
  Penjual,
  Barang,
  Keranjang,
  Pembayaran,
  DetailPembayaran,
};
