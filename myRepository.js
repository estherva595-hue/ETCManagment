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
    // Return RoleID (and optionally UserID if needed)
    if (result.recordset.length > 0) {
      return { RoleID: result.recordset[0].RoleID };
    } else {
      return { msg: 'No user found' };
    }
  } catch (err) {
    throw err;
  }
}

module.exports = {
  loginUser
};