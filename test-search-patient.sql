-- Test the search patient procedure
EXEC spSearchPatient @therapistId = 4, @idNumber = '949372955';

-- Check what's in HealthFunds table
SELECT * FROM HealthFunds WHERE FundID = 4;
