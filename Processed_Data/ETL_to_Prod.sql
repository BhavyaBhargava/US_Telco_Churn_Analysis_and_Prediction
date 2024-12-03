CREATE DATABASE db_Telco_Churn

-- Imported the XLSX data as a flat file into the database as a staging table

USE db_Telco_Churn

-- Performing some data exploration

SELECT * 
FROM stg_Customer_Churn;

SELECT DISTINCT stg_Customer_Churn.Count, country, State
FROM stg_Customer_Churn;

/* As these columns offer no distinct value these need to be dropped as they might 
hinder our Machine Learning model */

-- Planned to remove these three columns
/*
ALTER TABLE stg_Customer_Churn
DROP COLUMN Count, country, state;
*/

-- Exploring the variety of values in some other critical columns

SELECT TOP 10 city, COUNT(city) AS Occurences, 
COUNT(city) * 100.0 / (SELECT COUNT(*) FROM stg_Customer_Churn) AS percentage
FROM stg_Customer_Churn
GROUP BY City
ORDER BY Occurences DESC;

SELECT TOP 10 Zip_Code, COUNT(Zip_Code) AS Occurences, 
COUNT(Zip_Code) * 100.0 / (SELECT COUNT(Count) FROM stg_Customer_Churn) AS percentage
FROM stg_Customer_Churn
GROUP BY Zip_Code
ORDER BY Occurences DESC;

/* Lat_Long field will be skipped from prduction as it can create 
confusion while Power BI dashboarding */

-- Other Demographic fields skipped for Dashboard insights

SELECT TOP 10 Tenure_Months, COUNT(Tenure_Months) AS Occurences, 
COUNT(Tenure_Months) * 100.0 / (SELECT COUNT(*) FROM stg_Customer_Churn) AS percentage
FROM stg_Customer_Churn
GROUP BY Tenure_Months
ORDER BY Occurences DESC;

SELECT TOP 10 Internet_Service, COUNT(Internet_Service) AS Occurences, 
COUNT(Internet_Service) * 100.0 / (SELECT COUNT(*) FROM stg_Customer_Churn) AS percentage
FROM stg_Customer_Churn
GROUP BY Internet_Service
ORDER BY Occurences DESC;

SELECT TOP 10 Contract, COUNT(Contract) AS Occurences, 
COUNT(Contract) * 100.0 / (SELECT COUNT(*) FROM stg_Customer_Churn) AS percentage
FROM stg_Customer_Churn
GROUP BY Contract
ORDER BY Occurences DESC;

SELECT TOP 10 Payment_Method, COUNT(Payment_Method) AS Occurences, 
COUNT(Payment_Method) * 100.0 / (SELECT COUNT(*) FROM stg_Customer_Churn) AS percentage
FROM stg_Customer_Churn
GROUP BY Payment_Method
ORDER BY Occurences DESC;

-- Other Services fields skipped for Dashboard insights

-- Following are the most critical fields for analysis

SELECT TOP 10 Churn_Label, COUNT(Churn_Label) AS Occurences, 
COUNT(Churn_Label) * 100.0 / (SELECT COUNT(*) FROM stg_Customer_Churn) AS percentage
FROM stg_Customer_Churn
GROUP BY Churn_Label
ORDER BY Occurences DESC;

SELECT TOP 10 Churn_Score, COUNT(Churn_Score) AS Occurences, 
COUNT(Churn_Score) * 100.0 / (SELECT COUNT(*) FROM stg_Customer_Churn) AS percentage
FROM stg_Customer_Churn
GROUP BY Churn_Score
ORDER BY Occurences DESC;

SELECT TOP 10 Churn_Reason, COUNT(Churn_Reason) AS Occurences, 
COUNT(Churn_Reason) * 100.0 / (SELECT COUNT(*) FROM stg_Customer_Churn) AS percentage
FROM stg_Customer_Churn
GROUP BY Churn_Reason
ORDER BY Occurences DESC;


