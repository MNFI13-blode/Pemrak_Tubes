const Pembeli = require('../models/pembeli');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { Op } = require('sequelize');

//Register pembeli

exports.registerPembeli = async (req, res) => {
    try {
        const { username, email, alamat, password,role } = req.body;

        //Validasi cek apakah email sudah di daftarkan 
        const isUserExsist = await Pembeli.findOne({ where: { email } });
        if (isUserExsist) {
            return res.status(400).json({ status: 'error', message: 'Email sudah digunakan' })
        }

        //Hash passwordnya 
        const hashPassword = await bcrypt.hash(password, 10);
        //buat Pembeli baru
        const newPembeli = await Pembeli.create({ username, email, password:hashPassword, alamat,role });
        res.status(201).json({ status: 'success', data: newPembeli })
    } catch (error) {
        res.status(400).json({ status: 'error', message: error.message });
    }
};

//Login Pembeli

exports.loginPembeli = async (req, res) => {
    try {

        const { username, password } = req.body;
        console.log('Input username:', username);
        console.log('Input password:', password);
        // ({ where: { [Op.or]: [{ email: email }, { username: username }] } });
        //menemukan pembeli berdasarkan email atau username
        const pembeli = await Pembeli.findOne({ where: { username: username } });
        if (!pembeli) {
            return res.status(400).json({ status: 'error1', message: 'Username atau password salah dongo' });
        }
        console.log('Database password:', pembeli.password);
        // Verifikasi password menggunakan bcrypt 
        const isPWMatch = await bcrypt.compare(password, pembeli.password);
        if (!isPWMatch) {
            return res.status(400).json({ status: 'error2', message: 'Passowrd tidak cocok' });
        }


        const dataPembeli = {
            id_pembeli: pembeli.id_pembeli,
            username: pembeli.username,
            email: pembeli.email,
            alamat: pembeli.alamat,
            password: pembeli.password,
            foto: pembeli.foto || null,
            role: pembeli.role || null,
            saldo: pembeli.saldo || 0,
        }
        const token = jwt.sign({ dataPembeli }, process.env.JWT_SECRET, {
            expiresIn: '1h'

        })
        res.status(200).json({ status: 'success login', token:token,   dataPembeli: dataPembeli});
    } catch (error) {
        res.status(400).json({ status: 'error', message: error.message });
    }
}

//update pembeli

exports.updatetPembeli = async (req, res) => {
    try {
        const { id_pembeli, username, email, alamat, saldo, isIncrement } = req.body;

        if (!id_pembeli) {
            return res.status(400).json({ status: 'error', message: 'ID pembeli tidak ditemukan' });
        }

        const pembeli = await Pembeli.findOne({ where: { id_pembeli } });

        if (!pembeli) {
            return res.status(404).json({ status: 'error', message: 'Pengguna tidak ditemukan' });
        }

        // Validasi saldo dan update
        if (saldo !== undefined) {
            if (isNaN(saldo) || saldo < 0) {
                return res.status(400).json({ status: 'error', message: 'Saldo harus berupa angka positif' });
            }

            if (saldo > 1_000_000_000) { // Batas maksimal saldo
                return res.status(400).json({ status: 'error', message: 'Saldo terlalu besar' });
            }

            if (isIncrement) {
                pembeli.saldo += saldo; // Tambahkan saldo
            } else {
                pembeli.saldo = saldo; // Ganti saldo
            }
        }

        // Update data pembeli
        const updatedPembeli = await pembeli.update({
            username: username || pembeli.username,
            email: email || pembeli.email,
            alamat: alamat || pembeli.alamat,
            saldo: pembeli.saldo,
        });

        res.status(200).json({
            status: 'success',
            message: 'Profil berhasil diperbarui',
            data: updatedPembeli,
        });
    } catch (error) {
        res.status(400).json({ status: 'error', message: error.message });
    }
};
