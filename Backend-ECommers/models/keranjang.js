const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Keranjang = sequelize.define('Keranjang', {
    id_keranjang: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
    },
}, {
    tableName: 'keranjang',
});

module.exports = Keranjang;
