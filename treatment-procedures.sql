-- Get treatment history for a patient by therapist
CREATE OR ALTER PROCEDURE spGetTreatmentHistory
    @therapistId INT,
    @idNumber NVARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @patientId INT;
    SELECT @patientId = PatientID FROM Patients WHERE IDNumber = @idNumber;
    
    IF @patientId IS NULL OR NOT EXISTS (
        SELECT 1 FROM TreatmentRecords 
        WHERE TherapistID = @therapistId AND PatientID = @patientId
    )
    BEGIN
        RAISERROR('Forbidden', 16, 1);
        RETURN;
    END
    
    SELECT 
        tr.TreatmentID,
        tr.TreatmentDate,
        tr.TreatmentType,
        tr.TreatmentSummary,
        tr.Recommendations,
        tt.TypeName as TreatmentTypeName
    FROM TreatmentRecords tr
    LEFT JOIN TreatmentTypes tt ON tr.TreatmentTypeID = tt.TreatmentTypeID
    WHERE tr.TherapistID = @therapistId AND tr.PatientID = @patientId
    ORDER BY tr.TreatmentDate DESC;
END
GO

-- Get treatment types
CREATE OR ALTER PROCEDURE spGetTreatmentTypes
AS
BEGIN
    SET NOCOUNT ON;
    SELECT TreatmentTypeID, TypeName FROM TreatmentTypes;
END
GO

-- Update treatment record
CREATE OR ALTER PROCEDURE spUpdateTreatment
    @therapistId INT,
    @treatmentId INT,
    @treatmentType NVARCHAR(100),
    @treatmentSummary NVARCHAR(MAX),
    @recommendations NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Verify therapist owns this treatment record
    IF NOT EXISTS (
        SELECT 1 FROM TreatmentRecords 
        WHERE TreatmentID = @treatmentId AND TherapistID = @therapistId
    )
    BEGIN
        RAISERROR('Forbidden', 16, 1);
        RETURN;
    END
    
    UPDATE TreatmentRecords 
    SET 
        TreatmentType = @treatmentType,
        TreatmentSummary = @treatmentSummary,
        Recommendations = @recommendations
    WHERE TreatmentID = @treatmentId;
    
    SELECT 'Success' as Result;
END
GO