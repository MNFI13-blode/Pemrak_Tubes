const express = require("express");
const bodyParser = require("body-parser");
const { sequelize } = require("./models");
const pembeliRoutes = require("./routes/authPembeli");
const cors = require("cors");

const app = express();
app.use(bodyParser.json());

app.use(
  cors({
    origin: "http://localhost:62438", // Izinkan hanya asal tertentu
    methods: ["GET", "POST", "PUT", "DELETE"], // Tentukan metode HTTP yang diizinkan
    credentials: true, // Jika menggunakan cookie
  })
);

app.use("/api/pembeli", pembeliRoutes);

//(async () => {
//  try {
//     await sequelize.sync({ force: true }); // `force: true` akan membuat ulang tabel
//     console.log("Database synchronized!");
//   } catch (err) {
//     console.error("Error synchronizing database:", err);
//   }
// })();

const PORT = 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
