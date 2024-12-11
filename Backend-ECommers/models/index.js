const sequelize = require('../config/database');
const Admin = require('./admin.model');
const Pembeli = require('./pembeli');
const Penjual = require('./penjual');
const Barang = require('./barang');
const Keranjang = require('./keranjang');
const Pembayaran = require('./pembayaran');

//RELATION
Admin.hasMany(Pembeli, { foreignKey: 'id_admin' });
Admin.hasMany(Penjual, { foreignKey: 'id_admin' });
Admin.hasMany(Pembayaran, { foreignKey: 'id_admin' });

Pembeli.hasMany(Keranjang,{foreignKey:'id_pembeli'});
Keranjang.belongsTo(Pembeli, { foreignKey: 'id_pembeli' });

Pembeli.hasMany(Pembayaran, { foreignKey: 'id_pembeli' });
Penjual.hasMany(Pembayaran, { foreignKey: 'id_penjual' });
Pembayaran.belongsTo(Keranjang, { foreignKey: 'id_keranjang' });

Penjual.hasMany(Barang, { foreignKey: 'id_penjual' });
Keranjang.belongsToMany(Barang, { through: 'KeranjangBarang', foreignKey: 'id_keranjang' });
Barang.belongsToMany(Keranjang, { through: 'KeranjangBarang', foreignKey: 'id_barang' });

module.exports = {sequelize, Admin, Pembeli,Penjual, Barang,Keranjang, Pembayaran};