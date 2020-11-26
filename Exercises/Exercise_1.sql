/* 
Rahul Babu
QBS 181: Data Wrangling
Exercise 1
September 22nd 2020
*/ 

/* 
Question 1: Finding the different data types for the tables in the database 
*/

select DATA_TYPE,
COLUMN_NAME,
TABLE_NAME
from information_schema.columns

/* 
Question 2: How do we fix this error? Conversion failed when converting the 
nvarchar value 'NULL' to data type int. 

Error 1: This error indicates that the query is attemting to store a string containing 
'NULL' rather than an actual 'NULL' value.  . 
*/

UPDATE Conditions
	set tri_patientid = NULL
	where TRY_CONVERT(int, tri_patientid) is NULL AND tri_patientid is NOT NULL

/*
Error 2: This error can also come up when two different data types
are attempted to be joined (i.e.  Table A has an ID column that contains a 
numeric value; On the other hand, Table B contains an ID column that is a 
string of characters) 
*/

/* 
Question 3: How do we fix this error permanently?

Solution 1: To make sure that an actual 'NULL' value is stored rather than 
a string containing 'NULL'. The commands 'UPDATE' and 'set' are used 
simultaneously to identify the columns and values to be updated to 'NULL'. 
The Try convert function sets the values in tri_patientid to 'ints', if these 
values are 'NULL' and the original value in tri_patientid is not 'NULL', it 
will be updated accordingly. This process needs to be repeated for all desired
columns in the table.

*/ 

UPDATE Conditions
	set tri_patientid = NULL
	where TRY_CONVERT(int, tri_patientid) is NULL AND tri_patientid is NOT NULL

/*
Solution 2:: If you're storing a foreign key reference to another table they 
need to be of the same data type. If you don't have the foreign key 
reference defined, you should.
*/ 

