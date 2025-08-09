const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send(`
    <html>
      <head><title>IaC Demo</title></head>
      <body style="font-family: Arial; text-align: center; padding: 50px;">
        <h1>🚀 Infrastructure as Code Demo </h1>
        <p>Successfully deployed via GitHub Actions!</p>
        <p>Server time: ${new Date().toISOString()}</p>
        <p>Environment: ${process.env.NODE_ENV || 'production'}</p>
      </body>
    </html>
  `);
});

app.get('/health', (req, res) => {
  res.json({ status: 'healthy', timestamp: new Date().toISOString() });
});

app.listen(port, '0.0.0.0', () => {
  console.log(`Demo app listening at http://0.0.0.0:${port}`);
});