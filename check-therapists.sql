-- Check what therapists exist and their relationship to users
SELECT * FROM Therapists;

-- Check users with role 3 (should be therapists)
SELECT UserID, Username, RoleID FROM Users WHERE RoleID = 3;

-- Check if there are appointments for patient 170459844
SELECT * FROM Appointments WHERE PatientID = 170459844;