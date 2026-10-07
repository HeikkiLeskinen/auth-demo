const express = require("express");

const app = express();
const port = process.env.PORT || 8080;

app.disable("x-powered-by");
app.set("trust proxy", true);

app.get("/healthz", (req, res) => res.json({ status: "ok" }));

// Log every other incoming request as a single JSON line on stdout.
app.use((req, res) => {
  console.log(
    JSON.stringify({
      time: new Date().toISOString(),
      method: req.method,
      url: req.originalUrl,
      ip: req.ip,
      headers: req.headers,
    })
  );
  res.set("Cache-Control", "no-store");
  res.json({ status: "logged" });
});

app.listen(port, "0.0.0.0", () => console.log(`Listening on port ${port}`));
