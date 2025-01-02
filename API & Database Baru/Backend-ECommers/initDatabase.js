const { sequelize } = require("./models");
const Pembeli = require("./models/pembeli");
const Penjual = require("./models/penjual");
const Barang = require("./models/barang");
const Keranjang = require("./models/keranjang");
const Pembayaran = require("./models/pembayaran");
const DetailPembayaran = require("./models/detailPembayaran");

const bcrypt = require("bcrypt");

const initializeDatabase = async () => {
  try {
    // Hapus tabel jika ada
    console.log("Dropping all tables...");

    // Drop the child tables first
    await sequelize.query("SET foreign_key_checks = 0");
    await sequelize.query("DROP TABLE IF EXISTS `detail_pembayaran`");
    await sequelize.query("DROP TABLE IF EXISTS `pembayaran`");
    await sequelize.query("DROP TABLE IF EXISTS `keranjang`");
    await sequelize.query("DROP TABLE IF EXISTS `barang`");
    await sequelize.query("DROP TABLE IF EXISTS `penjual`");
    await sequelize.query("DROP TABLE IF EXISTS `pembeli`");
    await sequelize.query("SET foreign_key_checks = 1");

    console.log("All tables dropped successfully!");

    // Sinkronisasi ulang semua tabel
    console.log("Synchronizing all tables...");
    await sequelize.sync({ force: true });
    console.log("All tables synchronized!");

    // Seed untuk tabel Pembeli
    console.log("Seeding Pembeli...");
    await Pembeli.bulkCreate([
      {
        username: "pembeli1",
        password: bcrypt.hashSync("password123", 10),
        alamat: "Jl. Mawar No. 1",
        email: "pembeli1@example.com",
        role: "user",
        foto: "pembeli1.jpg",
        saldo: 50000,
      },
      {
        username: "pembeli2",
        password: bcrypt.hashSync("password456", 10),
        alamat: "Jl. Melati No. 2",
        email: "pembeli2@example.com",
        role: "user",
        foto: "pembeli2.jpg",
        saldo: 100000,
      },
    ]);

    // Seed untuk tabel Penjual
    console.log("Seeding Penjual...");
    await Penjual.bulkCreate([
      {
        username: "penjual1",
        password: "penjual123", // Password akan otomatis di-hash oleh model
        nama_toko: "Toko Elektronik",
        email: "penjual1@example.com",
        lokasi: "Jl. Anggrek No. 3",
        foto: "penjual1.jpg",
        saldo: 0, // Saldo awal penjual
      },
      {
        username: "penjual2",
        password: "penjual456",
        nama_toko: "Toko Pakaian",
        email: "penjual2@example.com",
        lokasi: "Jl. Dahlia No. 4",
        foto: "penjual2.jpg",
        saldo: 0, // Saldo awal penjual
      },
    ]);

    // Seed untuk tabel Barang
    console.log("Seeding Barang...");
    await Barang.bulkCreate([
      {
        nama_barang: "Laptop Gaming",
        jenis_barang: "Elektronik",
        harga: 15000000,
        jumlah_barang: 10,
        foto: "laptop_gaming.jpg",
        id_penjual: 1,
      },
      {
        nama_barang: "Kemeja Putih",
        jenis_barang: "Pakaian",
        harga: 150000,
        jumlah_barang: 50,
        foto: "kemeja_putih.jpg",
        id_penjual: 2,
      },
    ]);

    // Seed untuk tabel Keranjang
    console.log("Seeding Keranjang...");
    await Keranjang.bulkCreate([
      {
        id_pembeli: 1,
        id_barang: 1,
        jumlah_barang: 2,
      },
      {
        id_pembeli: 2,
        id_barang: 2,
        jumlah_barang: 1,
      },
    ]);

    // Seed untuk tabel Pembayaran
    console.log("Seeding Pembayaran...");
    const pembayaran1 = await Pembayaran.create({
      id_pembeli: 1,
      id_penjual: 1, // Add this line to specify the seller
      total: 30000000, // Ensure 'total' is provided
      tanggal_pembayaran: new Date(), // Set a valid date for 'tanggal_pembayaran'
      waktu_pembayaran: new Date(), // Set a valid date for 'waktu_pembayaran'
      metode_pembayaran: "Saldo",
    });

    // Seed untuk tabel DetailPembayaran
    console.log("Seeding DetailPembayaran...");
    await DetailPembayaran.bulkCreate([
      {
        id_pembayaran: pembayaran1.id_pembayaran, // Use the 'id_pembayaran' from the 'Pembayaran' record
        id_barang: 1,
        jumlah_barang: 2,
        harga_satuan: 15000000,
      },
    ]);

    console.log("Database initialized with seed data!");
  } catch (err) {
    console.error("Error initializing database:", err);
  }
};

initializeDatabase();
