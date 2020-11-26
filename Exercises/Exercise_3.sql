/* 
Rahul Babu
October 1st 2020
Data Wrangling
In class exercise 3
 
Question 1) */ 

SELECT tri_name, COUNT(tri_patientid) FROM Conditions
GROUP BY tri_name 
HAVING COUNT(tri_patientid) > 100

/* Question 2) 
Part A) Outpatient */

SELECT AVG(MEAS_VALUE) AS AVG_HEIGHT FROM Flowsheets f
inner join 
Outpatient OP
ON f.PAT_ENC_CSN_ID = OP.NEW_PAT_ENC_CSN_ID 
WHERE PATIENT_DOB_CATEGORY like '%Over 64%' and DISP_NAME like '%Height%'
UNION  

/* Part B) Inpatient */ 

SELECT AVG(MEAS_VALUE) AS AVG_HEIGHT FROM Flowsheets f
inner join 
Inpatient IP
ON f.PAT_ENC_CSN_ID = IP.NEW_PAT_ENC_CSN_ID 
WHERE DOB_CATEGORY like '%Over 64%' and DISP_NAME like '%Height%'

/* Question 3 */ 

SELECT AVG(MEAS_VALUE) AS AVG_HEIGHT from Dx D 
inner join 
Flowsheets F
ON D.NEW_PAT_ENC_CSN_ID = F.PAT_ENC_CSN_ID 
WHERE DISP_Name like '%Height%' and DX_NAME like '%Hypertension%'

SELECT AVG(MEAS_VALUE)/16 AS AVG_WEIGHT from Dx D 
inner join 
Flowsheets F
ON D.NEW_PAT_ENC_CSN_ID = F.PAT_ENC_CSN_ID 
WHERE DISP_Name = 'Weight' and DX_NAME like '%Hypertension%'

/* The BMI formula = weight lbs/height(inches) ^2 * 703 = 31.101 */
/* Average Data from Tables */ 
SELECT AVG(MEAS_VALUE) AS AVG_BMI from Dx D 
inner join 
Flowsheets F 
ON D.NEW_PAT_ENC_CSN_ID = F.PAT_ENC_CSN_ID 
WHERE DISP_NAME like '%BMI%' and DX_NAME like '%Hypertension%'

