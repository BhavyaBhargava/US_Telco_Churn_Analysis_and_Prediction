CREATE DATABASE db_Telco_Churn

-- Imported the XLSX data as a flat file into the database as a staging table

USE db_Telco_Churn

-- Performing some data exploration and finding NULLs

SELECT * 
FROM stg_Customer_Churn;

-- Checking if the following initial fields contain any Unique values

SELECT DISTINCT stg_Customer_Churn.Count, country, State
FROM stg_Customer_Churn;

/* As they have no unique values except singular values we'll just check 
for NULLs and omit these from production table */

SELECT COUNT(*) - COUNT(Count) AS Count_NULL_Count FROM stg_Customer_Churn;
SELECT COUNT(*) - COUNT(Country) AS Country_NULL_Count FROM stg_Customer_Churn;
SELECT COUNT(*) - COUNT(State) AS State_NULL_Count FROM stg_Customer_Churn;

/* As these columns offer no distinct value these need to be dropped as they might 
hinder our Machine Learning model */

-- Planned to remove these three columns but will just omit these
/*
ALTER TABLE stg_Customer_Churn
DROP COLUMN Count, country, state;
*/

-- Exploring trends in variety of values from some other critical fields

SELECT TOP 10 city, COUNT(city) AS Occurences, 
COUNT(city) * 100.0 / (SELECT COUNT(*) FROM stg_Customer_Churn) AS percentage
FROM stg_Customer_Churn
GROUP BY City
ORDER BY Occurences DESC;

-- Trying to identify the areas leaking the most valuable customers
SELECT TOP 10 Zip_Code, COUNT(Zip_Code) AS Occurences, 
COUNT(Zip_Code) * 100.0 / (SELECT COUNT(*) FROM stg_Customer_Churn) AS percentage,
City, AVG(CLTV) AS AVG_CLTV, AVG(Churn_Score) AS AVG_Churn
FROM stg_Customer_Churn
WHERE Churn_Label = 'Yes'
GROUP BY Zip_Code, City
ORDER BY Occurences DESC, AVG_CLTV DESC;

/* Lat_Long field will be skipped from prduction as it can create 
confusion while Power BI dashboarding */

-- Other Demographic fields skipped for Dashboard insights

SELECT TOP 10 Tenure_Months, COUNT(Tenure_Months) AS Occurences, 
COUNT(Tenure_Months) * 100.0 / (SELECT COUNT(*) FROM stg_Customer_Churn) AS percentage
FROM stg_Customer_Churn
GROUP BY Tenure_Months
ORDER BY Occurences DESC;

SELECT Internet_Service, COUNT(Internet_Service) AS Occurences, 
COUNT(Internet_Service) * 100.0 / (SELECT COUNT(*) FROM stg_Customer_Churn) AS percentage
FROM stg_Customer_Churn
GROUP BY Internet_Service
ORDER BY Occurences DESC;

SELECT Contract, COUNT(Contract) AS Occurences, 
COUNT(Contract) * 100.0 / (SELECT COUNT(*) FROM stg_Customer_Churn) AS percentage
FROM stg_Customer_Churn
GROUP BY Contract
ORDER BY Occurences DESC;

SELECT Payment_Method, COUNT(Payment_Method) AS Occurences, 
COUNT(Payment_Method) * 100.0 / (SELECT COUNT(*) FROM stg_Customer_Churn) AS percentage
FROM stg_Customer_Churn
GROUP BY Payment_Method
ORDER BY Occurences DESC;

-- Other Services fields skipped for Dashboard insights

-- Following are the most critical fields for analysis

SELECT Churn_Label, COUNT(Churn_Label) AS Occurences, 
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

/* Checking all the fields for NULL Values except the 
excluded ones-
(This Includes the Primary key, Count, Country, State (All 
the records belong to California, United States) and 
Lat_Long fields.)*/

SELECT 
    SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END) AS City_NULL_Count,
    SUM(CASE WHEN Zip_Code IS NULL THEN 1 ELSE 0 END) AS Zip_Code_NULL_Count,
    SUM(CASE WHEN Latitude IS NULL THEN 1 ELSE 0 END) AS Latitude_NULL_Count,
    SUM(CASE WHEN Longitude IS NULL THEN 1 ELSE 0 END) AS Longitude_NULL_Count,
    SUM(CASE WHEN Gender IS NULL THEN 1 ELSE 0 END) AS Gender_NULL_Count,
    SUM(CASE WHEN Senior_Citizen IS NULL THEN 1 ELSE 0 END) AS Senior_Citizen_NULL_Count,
    SUM(CASE WHEN Partner IS NULL THEN 1 ELSE 0 END) AS Partner_NULL_Count,
    SUM(CASE WHEN Dependents IS NULL THEN 1 ELSE 0 END) AS Dependents_NULL_Count,
    SUM(CASE WHEN Tenure_Months IS NULL THEN 1 ELSE 0 END) AS Tenure_Months_NULL_Count,
    SUM(CASE WHEN Phone_Service IS NULL THEN 1 ELSE 0 END) AS Phone_Service_NULL_Count,
    SUM(CASE WHEN Multiple_Lines IS NULL THEN 1 ELSE 0 END) AS Multiple_Lines_NULL_Count,
    SUM(CASE WHEN Internet_Service IS NULL THEN 1 ELSE 0 END) AS Internet_Service_NULL_Count,
    SUM(CASE WHEN Online_Security IS NULL THEN 1 ELSE 0 END) AS Online_Security_NULL_Count,
    SUM(CASE WHEN Online_Backup IS NULL THEN 1 ELSE 0 END) AS Online_Backup_NULL_Count,
    SUM(CASE WHEN Device_Protection IS NULL THEN 1 ELSE 0 END) AS Protection_NULL_Count,
    SUM(CASE WHEN Tech_Support IS NULL THEN 1 ELSE 0 END) AS Support_NULL_Count,
    SUM(CASE WHEN Streaming_TV IS NULL THEN 1 ELSE 0 END) AS Streaming_TV_NULL_Count,
    SUM(CASE WHEN Streaming_Movies IS NULL THEN 1 ELSE 0 END) AS Streaming_Movies_NULL_Count,
    SUM(CASE WHEN Contract IS NULL THEN 1 ELSE 0 END) AS Contract_NULL_Count,
    SUM(CASE WHEN Paperless_Billing IS NULL THEN 1 ELSE 0 END) AS Paperless_Billing_NULL_Count,
    SUM(CASE WHEN Payment_Method IS NULL THEN 1 ELSE 0 END) AS Payment_Method_NULL_Count,
    SUM(CASE WHEN Monthly_Charges IS NULL THEN 1 ELSE 0 END) AS Monthly_Charge_NULL_Count,
    SUM(CASE WHEN Total_Charges IS NULL THEN 1 ELSE 0 END) AS Total_Charges_NULL_Count,
    SUM(CASE WHEN Churn_Label IS NULL THEN 1 ELSE 0 END) AS Churn_Label_NULL_Count,
    SUM(CASE WHEN Churn_Value IS NULL THEN 1 ELSE 0 END) AS Churn_Value_NULL_Count,
    SUM(CASE WHEN Churn_Score IS NULL THEN 1 ELSE 0 END) AS Churn_Score_NULL_Count,
    SUM(CASE WHEN CLTV IS NULL THEN 1 ELSE 0 END) AS CLTV_NULL_Count,
    SUM(CASE WHEN Churn_Reason IS NULL THEN 1 ELSE 0 END) AS Churn_Reason_NULL_Count
FROM stg_Customer_Churn;

-- Total_Charges and Churn_Reason identified as fields with NULL Values

-- Dealing with the data inconsistencies and pushing the data in Prod table

SELECT 
    CustomerID,
    City,
    Zip_Code,
    Latitude,
    Longitude,
    Gender,
    Senior_Citizen,
    Partner,
    Dependents,
    Tenure_Months,
    Phone_Service,
    Multiple_Lines,
    Internet_Service,
    Online_Security,
    Online_Backup,
    Device_Protection,
    Tech_Support,
    Streaming_TV,
    Streaming_Movies,
    Contract,
    Paperless_Billing,
    Payment_Method,
    Monthly_Charges,
    ISNULL(Total_Charges, 0.0) AS Total_Charges, -- Replacing NULL values with 0
    Churn_Label,
    Churn_Value,
    Churn_Score,
    CLTV,
    ISNULL(Churn_Reason, 'Miscellaneous') AS Churn_Reason -- Replacing NULL values with 'Miscellaneous'
INTO [db_Telco_Churn].[dbo].[prod_Customer_Churn]
FROM [db_Telco_Churn].[dbo].[stg_Customer_Churn];
