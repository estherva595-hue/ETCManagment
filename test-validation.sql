-- Test the validation logic
DECLARE @IDNumber NVARCHAR(20) = '252587963';

SELECT 
    @IDNumber as IDNumber,
    LEN(@IDNumber) as Length,
    CASE WHEN @IDNumber LIKE '%[^0-9]%' THEN 'Contains non-digits' ELSE 'Only digits' END as DigitCheck,
    CASE WHEN LEN(@IDNumber) <> 9 OR @IDNumber LIKE '%[^0-9]%' THEN 'FAIL' ELSE 'PASS' END as ValidationResult;