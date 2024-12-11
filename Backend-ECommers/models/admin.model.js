const {DataTypes } = require('sequelize');
const sequelize = require('../config/database');

const Admin = sequelize.define('Admin',{
    id_admin: {
        type: DataTypes.INTEGER,
        primaryKey: true,
        autoIncrement: true,
    },
    username: DataTypes.STRING,
    password: DataTypes.STRING,
},{
    tableName: 'admin',
});

module.exports = Admin;


