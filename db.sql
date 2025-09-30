CREATE OR ALTER PROCEDURE spLoginUser
    @username NVARCHAR(50),
    @password NVARCHAR(256)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT UserID, RoleID
    FROM dbo.Users
    WHERE Username = @username
      AND PasswordHash = @password
      AND IsActive = 1
END
GO

CREATE OR ALTER PROCEDURE spSearchPatient
    @therapistId INT,
    @patientId INT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM dbo.Appointments
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
GO

CREATE OR ALTER PROCEDURE spAddPatient
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @DateOfBirth DATE,
    @Gender NVARCHAR(10),
    @FundID INT,
    @IDNumber NVARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Check if ID Number already exists
    IF EXISTS (SELECT 1 FROM Patients WHERE IDNumber = @IDNumber)
    BEGIN
        RAISERROR('Patient with this ID number already exists', 16, 1);
        RETURN;
    END

    -- Trim whitespace and validate ID Number format (9 digits)
    SET @IDNumber = LTRIM(RTRIM(@IDNumber));
    IF LEN(@IDNumber) <> 9 OR @IDNumber LIKE '%[^0-9]%'
    BEGIN
        RAISERROR('ID Number must be exactly 9 digits', 16, 1);
        RETURN;
    END

    -- Insert new patient
    INSERT INTO Patients (
        FirstName, 
        LastName, 
        DateOfBirth, 
        Gender, 
        FundID, 
        IDNumber
    )
    VALUES (
        @FirstName,
        @LastName,
        @DateOfBirth,
        @Gender,
        @FundID,
        @IDNumber
    );

    -- Return the new PatientID
    SELECT SCOPE_IDENTITY() AS PatientID;
END
GO

