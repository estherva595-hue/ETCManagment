-- Debug the therapist-patient relationship issue

-- 1. Check what UserID is being sent from frontend (this should match your login)
PRINT 'Step 1: Check Users with Role 4'
SELECT UserID, Username, RoleID FROM Users WHERE RoleID = 4;

-- 2. Check Therapists table structure and data
PRINT 'Step 2: Check all Therapists'
SELECT * FROM Therapists;

-- 3. Check if there's a relationship between Users and Therapists
PRINT 'Step 3: Check User-Therapist relationship'
SELECT u.UserID, u.Username, t.TherapistID, t.FirstName, t.LastName
FROM Users u
LEFT JOIN Therapists t ON u.UserID = t.TherapistID
WHERE u.RoleID = 4;

-- 4. Check specific patient
PRINT 'Step 4: Check patient 170459844'
SELECT * FROM Patients WHERE PatientID = 170459844;

-- 5. Check appointments for this patient
PRINT 'Step 5: Check appointments for patient 170459844'
SELECT * FROM Appointments WHERE PatientID = 170459844;

-- 6. Test the stored procedure logic manually
PRINT 'Step 6: Test stored procedure logic'
-- Replace @therapistId with actual therapist ID from step 3
DECLARE @therapistId INT = 1; -- Change this to actual therapist ID
DECLARE @patientId INT = 170459844;

IF EXISTS (
    SELECT 1
    FROM dbo.Appointments
    WHERE TherapistID = @therapistId AND PatientID = @patientId
)
BEGIN
    PRINT 'Patient IS assigned to therapist'
END
ELSE
BEGIN
    PRINT 'Patient is NOT assigned to therapist'
END