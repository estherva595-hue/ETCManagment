-- Create an appointment between Tomer Goldman (TherapistID=1) and patient 170459844
INSERT INTO Appointments (PatientID, TherapistID, RoomID, AppointmentDate, StartTime, EndTime, StatusID)
VALUES (170459844, 1, 1, '2025-01-10', '10:00:00', '11:00:00', 1);

-- Verify the appointment was created
SELECT * FROM Appointments WHERE PatientID = 170459844 AND TherapistID = 1;