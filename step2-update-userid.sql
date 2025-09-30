-- Step 2: Update Tomer Goldman's UserID
UPDATE Therapists 
SET UserID = 11 
WHERE TherapistID = 1;

-- Verify the update
SELECT TherapistID, FirstName, LastName, UserID FROM Therapists WHERE TherapistID = 1;