const express = require('express');
const app = express();

app.get('/', (req, res) => {
  const name = process.env.NAME || 'World';
  res.send(`Hello ${name}!`);
});

const port = parseInt(process.env.PORT) || 80;
app.listen(port, () => {
  console.log(`helloworld: listening on port ${port}`);
});