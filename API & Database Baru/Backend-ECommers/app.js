const express = require("express");
const bodyParser = require("body-parser");
const { sequelize } = require("./models");
const cors = require("cors");

const pembeliRoutes = require("./routes/authPembeli");
const barangRouter = require("./routes/barangRouter");
const keranjangRouter = require("./routes/keranjangRouter");
const pembayaranRouter = require("./routes/pembayaranRouter");

const app = express();

app.use(bodyParser.json());
app.use(
  cors({
    origin: "*",
    methods: ["GET", "POST", "PUT", "DELETE"],
    credentials: true,
  })
);

app.use("/api/pembeli", pembeliRoutes);
app.use("/barang", barangRouter);
app.use("/keranjang", keranjangRouter);
app.use("/pembayaran", pembayaranRouter);

// (async () => {
//     try {
//         await sequelize.sync({ force: true }); // force: true akan membuat ulang tabel
//         console.log('Database synchronized!');
//     } catch (err) {
//         console.error('Error synchronizing database:', err);
//     }
// })();

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
