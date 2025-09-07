CREATE PROCEDURE spLoginUser
    @username NVARCHAR(50),
    @password NVARCHAR(256)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT RoleID
    FROM dbo.Users
    WHERE Username = @username
      AND PasswordHash = @password
      AND IsActive = 1
END