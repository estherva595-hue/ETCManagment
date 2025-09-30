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
    res.json(result); // result should include RoleID and UserID
  } catch (err) {
    res.status(500).json({ msg: 'Login failed', error: err.message });
  }
});

app.post('/searchPatient', async (req, res) => {
  const { therapistId, idNumber } = req.body;
  console.log('Server received search request:', { therapistId, idNumber });
  try {
    const result = await myRepository.searchPatient(therapistId, idNumber);
    if (!result) {
      return res.status(404).json({ msg: 'Patient not found' });
    }
    res.json(result);
  } catch (err) {
    console.log('Search error:', err.message);
    if (err.status === 403) {
      res.status(403).json({ msg: 'Forbidden' });
    } else {
      res.status(500).json({ msg: 'Error searching patient', error: err.message });
    }
  }
});

app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
});


// In app.js or a separate routes file
app.get('/api/healthFunds', async (req, res) => {
  try {
    const funds = await myRepository.getHealthFunds();
    res.json(funds);
  } catch (err) {
    res.status(500).json({ error: 'Failed to load health funds' });
  }
});

app.post('/api/patients', async (req, res) => {
  try {
    const result = await myRepository.addPatient(req.body);
    res.json(result);
  } catch (err) {
    res.status(500).json({ error: 'Failed to register patient' });
  }
});