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
  const { therapistId, patientId } = req.body;
  try {
    const result = await myRepository.searchPatient(therapistId, patientId);
    if (!result) {
      return res.status(404).json({ msg: 'Patient not found' });
    }
    res.json(result);
  } catch (err) {
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