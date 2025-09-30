-- Add UserID column to Therapists table
ALTER TABLE Therapists ADD UserID INT NULL;

-- Update Tomer Goldman's record
UPDATE Therapists 
SET UserID = 11 
WHERE TherapistID = 1;

-- Verify the update
SELECT TherapistID, FirstName, LastName, UserID FROM Therapists WHERE TherapistID = 1;