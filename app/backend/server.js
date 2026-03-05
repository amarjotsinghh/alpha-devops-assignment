const express = require("express");
const { Pool } = require("pg");
const { getDbSecret } = require("./secrets");

const app = express();
const port = 3000;

let pool;

// Initialize DB connection using AWS Secrets Manager
async function initDb() {

  const secret = await getDbSecret();

  const host = secret.host.split(":")[0];

  pool = new Pool({
    host: host,
    user: secret.username,
    password: secret.password,
    database: secret.dbname,
    port: parseInt(secret.port),
    ssl: {
      rejectUnauthorized: false
    }
  });

  console.log("Connected to RDS database");
}

app.get("/health", (req, res) => {
  res.json({ status: "ok" });
});

app.get("/api/health", (req, res) => {
  res.json({ status: "ok" });
});

app.get("/ready", async (req, res) => {
  try {
    await pool.query("SELECT 1");
    res.json({ ready: true });
  } catch (err) {
    res.status(500).json({ ready: false });
  }
});

app.get("/db", async (req, res) => {
  try {

    const result = await pool.query("SELECT NOW()");

    res.json({
      database_time: result.rows[0]
    });

  } catch (err) {

    res.status(500).json({
      error: err.message
    });

  }
});

// Start server after DB init
async function startServer() {

  try {

    await initDb();

    app.listen(port, () => {
      console.log(`Server running on port ${port}`);
    });

  } catch (err) {

    console.error("Failed to start server:", err);

  }

}

startServer();