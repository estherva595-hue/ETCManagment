SELECT 
    t.TherapistID,
    t.FirstName + ' ' + t.LastName AS TherapistName,
    p.PatientID,
    p.FirstName + ' ' + p.LastName AS PatientName,
    p.IDNumber,
    p.DateOfBirth
FROM Therapists t
INNER JOIN Appointments a ON t.TherapistID = a.TherapistID
INNER JOIN Patients p ON a.PatientID = p.PatientID
ORDER BY t.TherapistID, p.LastName, p.FirstName;