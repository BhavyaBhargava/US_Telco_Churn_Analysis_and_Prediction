/*  Checking for the number of customers that didn't churn 
despite high churn score (i.e. < 50) */ 

SELECT Churn_Label, Count(CustomerID) AS Occurences
FROM prod_Customer_Churn
WHERE Churn_Score > 50
GROUP BY Churn_Label
ORDER BY Occurences DESC;

/* This data can be used for verifying the accuracy of 
IBM SPSS Modeler's Churn Score Metric */

-- Dividing the data with high churn score into two views for prediction model dev
 
-- Creating a view for the training dataset
-- This view combines the churned customers (Churn_Value = 1) and the randomized "stayed" customers.
CREATE VIEW vw_ChurnTraining AS
SELECT *
FROM (
    SELECT TOP (SELECT COUNT(*) FROM prod_Customer_Churn WHERE Churn_Value = 1) *
    FROM prod_Customer_Churn
    WHERE Churn_Value = 0 AND Churn_Score > 50
    ORDER BY NEWID()
) AS Stayed
UNION ALL
SELECT *
FROM prod_Customer_Churn
WHERE Churn_Value = 1 AND Churn_Score > 50;


-- Creating a view for the testing dataset
-- This view includes the remaining "stayed" customers not used in the training dataset.
CREATE VIEW vw_ChurnTesting AS
SELECT *
FROM prod_Customer_Churn
WHERE Churn_Value = 0
AND Churn_Score > 50
AND CustomerID NOT IN (SELECT CustomerID FROM vw_ChurnTraining);

-- Verifying the distribution of records in each dataset

-- Check the total record counts in vw_ChurnTraining
SELECT Churn_Value,
       COUNT(*) AS RecordCount,
       CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM vw_ChurnTraining) AS DECIMAL(10,2)) AS Percentage
FROM vw_ChurnTraining
GROUP BY Churn_Value;

-- Check the total record counts in vw_ChurnTesting
SELECT Churn_Value, 
       COUNT(*) AS RecordCount,
       CAST(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM vw_ChurnTesting) AS DECIMAL(10,2)) AS Percentage
FROM vw_ChurnTesting
GROUP BY Churn_Value;

-- Check if the TrainingDataset includes equal counts for Churn_Value = 1 (Churned) and Churn_Value = 0 (Stayed)
SELECT 'ChurnTraining' AS Dataset, COUNT(*) AS TotalRecords, 
       SUM(CASE WHEN Churn_Value = 1 THEN 1 ELSE 0 END) AS ChurnedCount,
       SUM(CASE WHEN Churn_Value = 0 THEN 1 ELSE 0 END) AS StayedCount
FROM vw_ChurnTraining;

-- Check the total number of records and ensure only "stayed" customers are in the TestingDataset
SELECT 'ChurnTesting' AS Dataset, COUNT(*) AS TotalRecords, 
       SUM(CASE WHEN Churn_Value = 1 THEN 1 ELSE 0 END) AS ChurnedCount,
       SUM(CASE WHEN Churn_Value = 0 THEN 1 ELSE 0 END) AS StayedCount
FROM vw_ChurnTesting;
