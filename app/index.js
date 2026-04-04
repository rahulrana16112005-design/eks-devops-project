const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.setHeader("Content-Type", "text/html; charset=utf-8");
  res.send(`
    <html>
      <head>
        <title>DevOps App</title>
        <style>
          body {
            margin: 0;
            background: linear-gradient(135deg, #0f172a, #1e293b);
            color: white;
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
          }
          .card {
            text-align: center;
            padding: 40px;
            border-radius: 12px;
            background: rgba(255,255,255,0.05);
            box-shadow: 0 0 20px rgba(0,0,0,0.5);
          }
          h1 {
            font-size: 42px;
            color: #38bdf8;
          }
          p {
            font-size: 18px;
            color: #cbd5f5;
          }
        </style>
      </head>
      <body>
        <div class="card">
          <h1>🚀 DevOps App Live</h1>
          <p>CI/CD with Jenkins + Docker + EKS 😈</p>
        </div>
      </body>
    </html>
  `);
});

app.listen(3000, () => console.log("App running on port 3000"));
