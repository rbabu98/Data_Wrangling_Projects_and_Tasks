
/* Question 2): Merging Tables in SQL */ 

/* Merging using Inner Join */ 
SELECT
	Demographics.contactid,
	Demographics.gendercode,
	Demographics.tri_age, 
	Demographics.parentcustomeridname, 
	Demographics.tri_imaginecareenrollmentstatus, 
	Demographics.address1_stateorprovince, 
	Demographics.tri_imaginecareenrollmentemailsentdate, 
	Demographics.tri_enrollmentcompletedate, 
	Demographics.gender,
	Conditions.tri_name,
	Text.SenderName,
	Text.TextSentDate
INTO 
	rababu.Final_Data_Table_Part_1
FROM 
	Demographics
INNER JOIN 
	Conditions
ON Demographics.contactid = Conditions.tri_patientid
INNER JOIN 
	Text
ON Demographics.contactid = Text.tri_contactId

/* Checking the merged table against the individual columns */ 
Select * from rababu.Final_Data_Table_Part_1
Select * from Demographics
Select * from Conditions
Select * from Text

/* Obtaining the rows with the max text sent date per contactid */ 
SELECT 
	x.*
INTO 
	rababu.Final_Data_Table_Part_2
FROM 
	rababu.Final_Data_Table_Part_1 x               
LEFT JOIN 
	rababu.Final_Data_Table_Part_1 y      
ON x.contactid = y.contactid    
AND x.TextSentDate < y.TextSentDate
WHERE y.TextSentDate IS NULL

Select * from rababu.Final_Data_Table_Part_2

/* Select First Row in each group (i.e. contactid) */
SELECT y.*
INTO rababu.Final_Data_Table_Part_3
FROM (
     SELECT 
		x.*,
		row_number() OVER(PARTITION BY x.contactid ORDER BY x.TextSentDate DESC) AS Row_Numb
     FROM  
		rababu.Final_Data_Table_Part_2 AS x
	) AS y
WHERE y.Row_Numb = 1

/* Checking the final edited table */ 
SELECT * FROM rababu.Final_Data_Table_Part_3

/* Checking Unique Values in Original Merge */ 
SELECT COUNT(DISTINCT contactid) FROM rababu.Final_Data_Table_Part_2;

/* Printing out the top ten rows to show the changes */ 
SELECT TOP 10 * FROM rababu.Final_Data_Table_Part_3;