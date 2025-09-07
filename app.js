const express = require('express');
const path = require('path');
const myRepository = require('./myRepository');

const app = express();
const PORT = 3000;

app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

app.get('/api/hello', (req, res) => {
  res.json({ msg: "hello world" });
});

app.post('/loginUser', async (req, res) => {
  const { username, password } = req.body;
  try {
    const result = await myRepository.loginUser(username, password);
    res.json(result);
  } catch (err) {
    res.status(500).json({ msg: 'Login failed', error: err.message });
  }
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});