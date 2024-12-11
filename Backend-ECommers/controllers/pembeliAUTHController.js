const Pembeli = require('../models/pembeli');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { Op } = require('sequelize');

//Register pembeli

exports.registerPembeli = async (req, res) => {
    try {
        const { username, email, password, alamat,role } = req.body;

        //Validasi cek apakah email sudah di daftarkan 
        const isUserExsist = await Pembeli.findOne({ where: { email } });
        if (isUserExsist) {
            return res.status(400).json({ status: 'error', message: 'Email sudah digunakan' })
        }

        //Hash passwordnya 
        const hashPassword = await bcrypt.hash(password, 10);
        //buat Pembeli baru
        const newPembeli = await Pembeli.create({ username, email, password: hashPassword, alamat,role });
        res.status(201).json({ status: 'success', data: newPembeli })
    } catch (error) {
        res.status(400).json({ status: 'error', message: error.message });
    }
};

//Login Pembeli

exports.loginPembeli = async (req, res) => {
    try {
        const { username, email, password } = req.body;

        //menemukan pembeli berdasarkan email atau username
        const pembeli = await Pembeli.findOne({ where: { [Op.or]: [{ email: email }, { username: username }] } });
        if (!pembeli) {
            return res.status(400).json({ status: 'error', message: 'Email atau password salah' });
        }
        // Verifikasi password menggunakan bcrypt 
        const isPWMatch = await bcrypt.compare(password, pembeli.password);
        if (!isPWMatch) {
            return res.status(400).json({ status: 'error', message: 'Email atau password salah' });
        }


        const dataPembeli = {
            pemebeliID: pembeli.id_pembeli,
            username: pembeli.username,
            email: pembeli.email,
            alamat: pembeli.alamat,
            password: pembeli.password,
            foto: pembeli.foto,
            role: pembeli.role,
        }
        const token = jwt.sign({ dataPembeli }, process.env.JWT_SECRET, {
            expiresIn: '1h'

        })
        res.status(200).json({ status: 'success', token });
    } catch (error) {
        res.status(400).json({ status: 'error', message: error.message });
    }
}