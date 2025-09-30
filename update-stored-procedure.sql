CREATE OR ALTER PROCEDURE spSearchPatient
    @therapistId INT,
    @patientId INT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM dbo.TreatmentRecords
        WHERE TherapistID = @therapistId AND PatientID = @patientId
    )
    BEGIN
        SELECT *
        FROM dbo.Patients
        WHERE PatientID = @patientId
    END
    ELSE
    BEGIN
        RAISERROR('Forbidden', 16, 1);
    END
END