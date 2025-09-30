-- Option 1: Update Therapists table to link UserID to TherapistID
-- Add UserID column to Therapists table if it doesn't exist
ALTER TABLE Therapists ADD UserID INT;

-- Link Tomer Goldman's user account to his therapist record
UPDATE Therapists 
SET UserID = 11 
WHERE TherapistID = 1;