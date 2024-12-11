const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Pembayaran = sequelize.define('Pembayaran', {
    id_pembayaran: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
    },
    metode_pembayaran: DataTypes.STRING,
    tanggal_pembayaran: DataTypes.DATE,
    waktu_pembayaran: DataTypes.TIME,
    total: DataTypes.FLOAT,
}, {
    tableName: 'pembayaran',
});

module.exports = Pembayaran;
