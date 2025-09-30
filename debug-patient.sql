-- Check if patient exists
SELECT * FROM Patients WHERE PatientID = 170459844;

-- Check appointments for this patient
SELECT * FROM Appointments WHERE PatientID = 170459844;

-- Check what therapist ID you're using (role 4 users)
SELECT u.UserID, u.Username, t.TherapistID, t.FirstName, t.LastName 
FROM Users u
LEFT JOIN Therapists t ON u.UserID = t.TherapistID
WHERE u.RoleID = 4;