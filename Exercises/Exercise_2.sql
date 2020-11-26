/* 
QBS 181 Data Wrangling Exercise 2
Rahul Babu
September 24th 2020
*/ 

/* Question 1) How many patients had hypertension and belonged to Dartmouth-Hitchcock */

SELECT COUNT(contactid) AS SUM FROM Demographics
inner join 
Conditions b 
ON contactid = b.tri_patientid
WHERE parentcustomeridname = 'Dartmouth-Hitchcock' AND tri_name = 'Hypertension' 

/* Question 2) What is the average age of each patient having Hypertension, COPD, and CHF? */ 

SELECT tri_name, AVG(tri_age) as Average_Age from Demographics
inner join 
Conditions b 
ON contactid = b.tri_patientid
WHERE tri_name = 'Hypertension' OR tri_name = 'Congestive Heart Failure' OR tri_name = 'COPD'
group by tri_name

/* Question 3) How many Male and Female patients had Hypertension, COPD, and CHF? */
/* Gendercode of 1 is used to denote Males, while 2 is for Females */
/* for Men, gendercode = 1*/ 

SELECT tri_name, 
COUNT(tri_name) AS SUM 
FROM (
	SELECT gendercode, tri_name
	FROM Demographics
inner join 
Conditions b 
ON contactid = b.tri_patientid
WHERE (TRY_CONVERT(int, gendercode)=1) AND 
	  (tri_name = 'Hypertension' OR tri_name = 'Congestive Heart Failure' OR tri_name = 'COPD') ) a
GROUP BY tri_name

/* For Women, gendercode = 2*/

SELECT tri_name, 
COUNT(tri_name) AS SUM 
FROM (
	SELECT gendercode, tri_name
	FROM Demographics
inner join 
Conditions b 
ON contactid = b.tri_patientid
WHERE (TRY_CONVERT(int, gendercode)=2) AND 
	  (tri_name = 'Hypertension' OR tri_name = 'Congestive Heart Failure' OR tri_name = 'COPD') ) a
GROUP BY tri_name
