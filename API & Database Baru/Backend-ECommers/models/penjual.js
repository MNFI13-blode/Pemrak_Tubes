const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");
const bcrypt = require("bcrypt");

const Penjual = sequelize.define(
  "Penjual",
  {
    id_penjual: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true,
      allowNull: false,
    },
    username: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    password: {
      type: DataTypes.STRING,
      allowNull: false,
      set(value) {
        const hashedPassword = bcrypt.hashSync(value, 10);
        this.setDataValue("password", hashedPassword);
      },
    },

    nama_toko: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    email: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    lokasi: {
      type: DataTypes.STRING,
      allowNull: false,
    },

    foto: DataTypes.STRING,
    saldo: {
      type: DataTypes.FLOAT,
      defaultValue: 0.0,
    },
  },
  {
    tableName: "penjual",
  }
);

module.exports = Penjual;
