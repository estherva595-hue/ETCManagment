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


select * from appointments where therapistId =4 and patientId = 103

--let me = read_file(filePath: "c:\\Users\\user\\Documents\\EstherW\\GITHUB\\FinalProd32\\myRepository.js", startLine: 1, endLine: 50)

