const express = require("express");
const app = express();
const port = 3000;

app.get("/health", (req, res) => {
  res.json({ status: "ok" });
});

app.get("/ready", (req, res) => {
  res.json({ ready: true });
});

app.get("/", (req, res) => {
  res.json({
    message: "Backend running",
    version: "v1"
  });
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});