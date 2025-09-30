-- Just update the UserID for Tomer Goldman
UPDATE Therapists 
SET UserID = 11 
WHERE TherapistID = 1;

-- Verify the update
SELECT TherapistID, FirstName, LastName, UserID FROM Therapists WHERE TherapistID = 1;