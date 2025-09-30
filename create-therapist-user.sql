-- Create a user for therapist Tomer Goldman
INSERT INTO Users (Username, PasswordHash, Email, RoleID, IsActive)
VALUES ('tomer.goldman', '1234', 'tomer.goldman@etc.com', 3, 1);

-- Check what UserID was created
SELECT UserID, Username, RoleID FROM Users WHERE Username = 'tomer.goldman';