const sql = require('mssql');

const config = {
  user: 'system32',
  password: '1234',
  server: 'localhost',
  database: 'ETC',
  port: 1433,
  options: {
    encrypt: false,
    trustServerCertificate: true
  }
};

async function loginUser(username, password) {
  try {
    let pool = await sql.connect(config);
    let result = await pool.request()
      .input('username', sql.NVarChar, username)
      .input('password', sql.NVarChar, password)
      .execute('spLoginUser');
    if (result.recordset.length > 0) {
      // Return both RoleID and UserID
      return { RoleID: result.recordset[0].RoleID, UserID: result.recordset[0].UserID };
    } else {
      return { msg: 'No user found' };
    }
  } catch (err) {
    throw err;
  }
}


async function searchPatient(therapistId, idNumber) {
  try {
    let pool = await sql.connect(config);
    let result = await pool.request()
      .input('therapistId', sql.Int, parseInt(therapistId))
      .input('idNumber', sql.NVarChar, idNumber)
      .execute('spSearchPatient');
    if (result.recordset.length > 0) {
      return result.recordset[0];
    } else {
      return null;
    }
  } catch (err) {
    if (err.message.includes('Forbidden')) {
      const error = new Error('Forbidden');
      error.status = 403;
      throw error;
    }
    throw err;
  }
}


module.exports = {
  loginUser,
  searchPatient
};


async function getHealthFunds() {
  try {
    let pool = await sql.connect(config);
    let result = await pool.request().query('SELECT FundID, FundName FROM HealthFunds');
    return result.recordset;
  } catch (err) {
    throw err;
  }
}

async function addPatient(patient) {
  try {
    let pool = await sql.connect(config);
    let result = await pool.request()
      .input('FirstName', sql.NVarChar, patient.FirstName)
      .input('LastName', sql.NVarChar, patient.LastName)
      .input('DateOfBirth', sql.Date, patient.DateOfBirth)
      .input('Gender', sql.NVarChar, patient.Gender)
      .input('FundID', sql.Int, patient.FundID)
      .input('IDNumber', sql.NVarChar, patient.IDNumber)
      .execute('spAddPatient');
    return { PatientID: result.recordset[0].PatientID };
  } catch (err) {
    throw err;
  }
}

async function getTreatmentHistory(therapistId, idNumber) {
  try {
    let pool = await sql.connect(config);
    let result = await pool.request()
      .input('therapistId', sql.Int, parseInt(therapistId))
      .input('idNumber', sql.NVarChar, idNumber)
      .execute('spGetTreatmentHistory');
    return result.recordset;
  } catch (err) {
    if (err.message.includes('Forbidden')) {
      const error = new Error('Forbidden');
      error.status = 403;
      throw error;
    }
    throw err;
  }
}

async function getTreatmentTypes() {
  try {
    let pool = await sql.connect(config);
    let result = await pool.request().execute('spGetTreatmentTypes');
    return result.recordset;
  } catch (err) {
    throw err;
  }
}

async function updateTreatment(therapistId, treatmentId, treatmentType, treatmentSummary, recommendations) {
  try {
    let pool = await sql.connect(config);
    let result = await pool.request()
      .input('therapistId', sql.Int, parseInt(therapistId))
      .input('treatmentId', sql.Int, parseInt(treatmentId))
      .input('treatmentType', sql.NVarChar, treatmentType)
      .input('treatmentSummary', sql.NVarChar, treatmentSummary)
      .input('recommendations', sql.NVarChar, recommendations)
      .execute('spUpdateTreatment');
    return result.recordset[0];
  } catch (err) {
    if (err.message.includes('Forbidden')) {
      const error = new Error('Forbidden');
      error.status = 403;
      throw error;
    }
    throw err;
  }
}

async function getTreatmentTemplates() {
  try {
    let pool = await sql.connect(config);
    let result = await pool.request().execute('spGetTreatmentTemplates');
    return result.recordset;
  } catch (err) {
    throw err;
  }
}

async function createTreatment(therapistId, idNumber, treatmentType, treatmentSummary, recommendations, templateId) {
  try {
    let pool = await sql.connect(config);
    let result = await pool.request()
      .input('therapistId', sql.Int, parseInt(therapistId))
      .input('idNumber', sql.NVarChar, idNumber)
      .input('treatmentType', sql.NVarChar, treatmentType)
      .input('treatmentSummary', sql.NVarChar, treatmentSummary)
      .input('recommendations', sql.NVarChar, recommendations)
      .input('templateId', sql.Int, templateId || 2)
      .execute('spCreateTreatment');
    return result.recordset[0];
  } catch (err) {
    if (err.message.includes('Forbidden')) {
      const error = new Error('Forbidden');
      error.status = 403;
      throw error;
    }
    throw err;
  }
}

module.exports = {
  loginUser,
  searchPatient,
  getHealthFunds,
  addPatient,
  getTreatmentHistory,
  getTreatmentTypes,
  getTreatmentTemplates,
  updateTreatment,
  createTreatment
};