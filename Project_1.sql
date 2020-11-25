
-- Data Wrangling QBS 181
-- Homework -1

/* Printing top 10 rows to show this change */
SELECT TOP 10 * FROM rababu.enrollment

/* Question 1) */

SELECT 
	contactid AS ID,
	gendercode AS GenderC, 
	tri_age AS Age, 
	parentcustomeridname AS HCOProvider, 
	tri_imaginecareenrollmentstatus AS IdentityCode, 
	address1_stateorprovince AS State,
	tri_imaginecareenrollmentemailsentdate AS EmailSentDate,
	tri_enrollmentcompletedate AS Completedate,
	gender AS Sex
INTO rababu.edited_dem
FROM Demographics 
	
/* Checking */
SELECT * FROM rababu.edited_dem
DROP TABLE rababu.edited_dem

/* Casting */
UPDATE rababu.edited_dem
SET EmailSentDate = CAST(EmailSentDate AS DATETIME)
WHERE ISDATE(EmailSentDate) = 1

UPDATE rababu.edited_dem
SET CompleteDate = CAST(Completedate AS DATETIME) 
WHERE ISDATE(Completedate) = 1

-/* Changing to real nulls */
UPDATE rababu.edited_dem
SET EmailSentDate = Null 
WHERE ISDATE(EmailSentDate) = 0

UPDATE rababu.edited_dem 
SET CompleteDate = Null 
WHERE ISDATE(CompleteDate) = 0

/* Calculating time to complete enrollment - adding new column with data */

SELECT
	ID,
	GenderC, 
	Age, 
	HCOProvider, 
	IdentityCode, 
	State,
	EmailSentDate as START_D,
	Completedate as END_D,
	Sex, 
	DATEDIFF(DAY, EmailSentDate, CompleteDate) AS TimeForEnrollment
INTO rababu.enrollment
FROM rababu.edited_dem
	
/* Checking */
SELECT * FROM rababu.enrollment
DROP TABLE rababu.enrollment

/* Question 2) */

ALTER TABLE rababu.enrollment
	ADD Enrollment_Status AS ( 
		CASE 
			WHEN IdentityCode = 167410000 THEN 'Unprocessed'
			WHEN IdentityCode = 167410001 THEN 'Email Sent'
			WHEN IdentityCode = 167410002 THEN 'Incomplete'
			WHEN IdentityCode = 167410003 THEN 'Opted Out'
			WHEN IdentityCode = 167410004 THEN 'Non Responder'
			WHEN IdentityCode = 167410005 THEN 'Facilitated Enrollment'
			WHEN IdentityCode = 167410006 THEN 'Email Sent Date'
			WHEN IdentityCode = 167410011 THEN 'Complete'
		END);

/* Checking */
SELECT * FROM rababu.enrollment

/* Question 3 */

ALTER TABLE rababu.enrollment
	ADD Gender AS ( 
		CASE 
			WHEN GenderC = 'Null' THEN 'Unknown'
			WHEN GenderC = '1' THEN 'Male'
			WHEN GenderC = '2' THEN 'Female'
			WHEN GenderC = '167410000' THEN 'Other'
		END);
	
/* Checking */
SELECT * FROM rababu.enrollment

/* Question 4) */

ALTER TABLE rababu.enrollment
	ADD Age_Group AS ( 
		CASE  
			WHEN Age > 100 THEN '101-125' 
			WHEN 100 >= Age and Age > 75 THEN '76-100'
			WHEN 75 >= Age and Age > 50 THEN '51-75'
			WHEN 50 >= Age and Age > 25 THEN '26-50'
			WHEN 25 >= Age and Age > 0 THEN '0-25'
		END);

/* Checking */
SELECT * FROM rababu.enrollment


    