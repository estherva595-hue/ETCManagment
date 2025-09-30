const axios = require('axios');

async function testAddPatient() {
  const testPatient = {
    FirstName: "John",
    LastName: "Doe", 
    DateOfBirth: "1990-05-15",
    Gender: "Male",
    FundID: 1,
    IDNumber: "123456789"
  };

  try {
    const response = await axios.post('http://localhost:3000/api/patients', testPatient);
    console.log('Success:', response.data);
  } catch (error) {
    console.log('Error:', error.response?.data || error.message);
  }
}

testAddPatient();