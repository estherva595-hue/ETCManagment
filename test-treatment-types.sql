-- Test the treatment types stored procedure
EXEC spGetTreatmentTypes;

-- Also check the table directly
SELECT * FROM TreatmentTypes;