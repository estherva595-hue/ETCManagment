-- Check current structure of Therapists table
SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Therapists';

-- Check current data in Therapists table
SELECT * FROM Therapists;