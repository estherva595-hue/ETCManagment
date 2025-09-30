-- Test the stored procedure manually
DECLARE @therapistId INT = 4;
DECLARE @patientId INT = 103;

-- Check if the relationship exists in TreatmentRecords
SELECT COUNT(*) as RecordCount
FROM dbo.TreatmentRecords
WHERE TherapistID = @therapistId AND PatientID = @patientId;

-- Test the stored procedure
EXEC spSearchPatient @therapistId = 4, @patientId = 103;