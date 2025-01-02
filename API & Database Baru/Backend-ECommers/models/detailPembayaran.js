const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const DetailPembayaran = sequelize.define(
  "DetailPembayaran",
  {
    id_detail_pembayaran: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    id_pembayaran: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    id_barang: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    jumlah_barang: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    harga_satuan: {
      type: DataTypes.FLOAT,
      allowNull: false,
    },
  },
  {
    tableName: "detail_pembayaran",
  }
);

module.exports = DetailPembayaran;
