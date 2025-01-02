const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const Pembayaran = sequelize.define(
  "Pembayaran",
  {
    id_pembayaran: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
    },
    id_pembeli: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    id_penjual: {
      type: DataTypes.INTEGER,
      allowNull: false,
    },
    tanggal_pembayaran: {
      type: DataTypes.DATE,
      allowNull: false,
    },
    waktu_pembayaran: {
      type: DataTypes.TIME,
      allowNull: false,
    },
    total: {
      type: DataTypes.DECIMAL,
      allowNull: false,
    },
    metode_pembayaran: {
      type: DataTypes.STRING,
      allowNull: false,
    },
  },
  {
    freezeTableName: true,
    tableName: "Pembayaran",
  }
);

module.exports = Pembayaran;
