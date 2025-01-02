const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const TransaksiPembelian = sequelize.define(
  "TransaksiPembelian",
  {
    id_transaksi: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    id_pembeli: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    total_harga: {
      type: DataTypes.FLOAT,
      allowNull: false,
    },
    tanggal_transaksi: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW,
    },
  },
  {
    tableName: "transaksipembelian",
    timestamps: false,
  }
);

module.exports = TransaksiPembelian;
