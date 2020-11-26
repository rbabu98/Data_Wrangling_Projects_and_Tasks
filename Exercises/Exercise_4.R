
# Rahul Babu
# October 14th 2020
# QBS 181 Data Wrangling 
# Professor Yapalparvi

install.packages('sqldf')
install.packages('RODBC')

library('sqldf')
library('RODBC')

# username and password removed for publishing
my_connection <- odbcConnect('qbs181', uid = '', pwd = '',)

#Question 1) 

extracted_DX <- sqlQuery(my_connection, "SELECT * FROM Dx")
extracted_DX_lower <- tolower(extracted_DX$DX_NAME)
View(extracted_DX_lower)

#Question 2)
updated_DX <- gsub(" ","", extracted_DX_lower)
updated_DX <- gsub(",","", updated_DX)
View(updated_DX)

#Question 3)
Inpatient_Outpatient <- sqlQuery(my_connection,"
SELECT * FROM Inpatient A
INNER JOIN Outpatient B
ON A.NEW_PATIENT_DHMC_MRN=B.NEW_PATIENT_DHMC_MRN")

new_pat_DHMC <- (Inpatient_Outpatient$NEW_PATIENT_DHMC_MRN)
new_pat_DHMC <- gsub("-","",new_pat_DHMC)
View(new_pat_DHMC)

#Question 4)

new_pat_merged <- sqlQuery(my_connection, "
SELECT * FROM Inpatient A
INNER JOIN Outpatient B
ON A.NEW_PAT_ID=B.NEW_PAT_ID
")

distinct_pat <- unique(new_pat_merged$NEW_PATIENT_DHMC_MRN)
length(distinct_pat) == length(unique(Inpatient_Outpatient$NEW_PATIENT_DHMC_MRN))
#To conclude, we do not see the same distinct NEW_PATIENT_DHMC_MRN when merged on NEW_PAT_ID
