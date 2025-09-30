-- Create new treatment record
CREATE OR ALTER PROCEDURE spCreateTreatment
    @therapistId INT,
    @idNumber NVARCHAR(20),
    @treatmentType NVARCHAR(100),
    @treatmentSummary NVARCHAR(MAX),
    @recommendations NVARCHAR(MAX),
    @templateId INT = 2
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Get PatientID from IDNumber
    DECLARE @patientId INT;
    SELECT @patientId = PatientID FROM Patients WHERE IDNumber = @idNumber;
    
    IF @patientId IS NULL
    BEGIN
        RAISERROR('Patient not found', 16, 1);
        RETURN;
    END
    
    -- Verify therapist has access to this patient (has previous treatments)
    IF NOT EXISTS (
        SELECT 1 FROM TreatmentRecords 
        WHERE TherapistID = @therapistId AND PatientID = @patientId
    )
    BEGIN
        RAISERROR('Forbidden', 16, 1);
        RETURN;
    END
    
    -- Get TreatmentTypeID from TypeName
    DECLARE @treatmentTypeId INT;
    SELECT @treatmentTypeId = TreatmentTypeID 
    FROM TreatmentTypes 
    WHERE TypeName = @treatmentType;
    
    -- Use provided templateId or default to 2 (regular treatment session)
    IF @templateId IS NULL OR @templateId = 0
        SET @templateId = 2;
    
    -- Insert new treatment record
    INSERT INTO TreatmentRecords (
        PatientID,
        TherapistID,
        TreatmentDate,
        TreatmentType,
        TreatmentSummary,
        Recommendations,
        TreatmentTypeID,
        TemplateID,
        CreatedAt
    )
    VALUES (
        @patientId,
        @therapistId,
        GETDATE(),
        @treatmentType,
        @treatmentSummary,
        @recommendations,
        @treatmentTypeId,
        @templateId,
        GETDATE()
    );
    
    SELECT SCOPE_IDENTITY() as NewTreatmentID;
END
GO

-- Get treatment templates
CREATE OR ALTER PROCEDURE spGetTreatmentTemplates
AS
BEGIN
    SET NOCOUNT ON;
    SELECT TemplateID, TemplateName, Description 
    FROM TreatmentTemplates 
    WHERE IsActive = 1
    ORDER BY TemplateName;
END
GO