const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");

const Keranjang = sequelize.define(
  "Keranjang",
  {
    id_pembeli: {
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
    createdAt: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: DataTypes.NOW,
    },
    updatedAt: {
      type: DataTypes.DATE,
      allowNull: false,
      defaultValue: DataTypes.NOW,
    },
  },
  { primaryKey: false, freezeTableName: true }
);

module.exports = Keranjang;
