CREATE OR ALTER PROCEDURE spSearchPatient
    @therapistId INT,
    @idNumber NVARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;
    
    -- First get PatientID from IDNumber
    DECLARE @patientId INT;
    SELECT @patientId = PatientID FROM Patients WHERE IDNumber = @idNumber;
    
    IF @patientId IS NULL
    BEGIN
        RAISERROR('Patient not found', 16, 1);
        RETURN;
    END

    IF EXISTS (
        SELECT 1
        FROM dbo.TreatmentRecords
        WHERE TherapistID = @therapistId AND PatientID = @patientId
    )
    BEGIN
        SELECT 
            p.*,
            hf.FundName
        FROM dbo.Patients p
        LEFT JOIN dbo.HealthFunds hf ON p.FundID = hf.FundID
        WHERE p.PatientID = @patientId
    END
    ELSE
    BEGIN
        RAISERROR('Forbidden', 16, 1);
    END
END