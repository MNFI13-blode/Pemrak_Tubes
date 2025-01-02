const { DataTypes } = require("sequelize");
const sequelize = require("../config/database");
const bcrypt = require("bcrypt");

const Pembeli = sequelize.define(
  "Pembeli",
  {
    id_pembeli: {
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
      // set(value) {
      //     const hashedPassword = bcrypt.hashSync(value, 10);
      //     this.setDataValue('password', hashedPassword);
      // }
    },

    alamat: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    email: {
      type: DataTypes.STRING,
      allowNull: false,
    },
    role: {
      type: DataTypes.STRING,
    },
    foto: DataTypes.STRING,
    saldo: {
      type: DataTypes.FLOAT,
    },
  },
  {
    tableName: "pembeli",
  }
);

module.exports = Pembeli;
