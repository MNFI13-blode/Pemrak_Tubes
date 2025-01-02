const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Barang = sequelize.define('Barang', {
    id_barang: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
    },
    nama_barang: DataTypes.STRING,
    jenis_barang: DataTypes.STRING,
    harga: DataTypes.FLOAT,
    jumlah_barang: DataTypes.INTEGER,
    foto: DataTypes.STRING,
}, {
    tableName: 'barang',
});

module.exports = Barang;
