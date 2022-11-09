--Check the data  
SELECT *
FROM Worker_Injury..[2021_Data]

--Pull only Ralphs Data
SELECT *
FROM Worker_Injury..[2021_Data]
WHERE company_name LIKE 'Ralphs Grocery Company%' AND establishment_name LIKE '703%'

--Create new table ONLY about Ralphs Grocery Store
SELECT *
INTO Ralphs
FROM Worker_Injury..[2021_Data]
WHERE company_name LIKE 'Ralphs Grocery Company%' AND establishment_name LIKE '703%'
	
--Checking Ralphs Table
SELECT *
FROM Ralphs
Order BY city ASC, zip_code ASC

--Drop columns that aren't useful
ALTER TABLE Ralphs
DROP COLUMN establishment_id, establishment_type, size, created_timestamp, change_reason 

--Checking data if there are duplicates ids, eins, and establishment name
SELECT id, ein, establishment_name, COUNT(*)
FROM Ralphs
GROUP BY id, ein, establishment_name
HAVING COUNT(*) > 1

--Finding Average workers across Division
SELECT ROUND(AVG(annual_average_employees),1) AS Annual_Employees_for_Division
FROM Ralphs

--Finding Average hours worked across Division
SELECT ROUND(AVG(total_hours_worked),1) AS Total_hours_worked_for_division
FROM Ralphs

--Finding Total Injuries across Division
SELECT SUM(total_injuries) AS Total_Injuries_for_Division
FROM Ralphs

--Finding Top 10 stores with most injuries
SELECT TOP 10 *
FROM Ralphs
ORDER BY total_injuries DESC

--Make new column for percent of injuried per store
SELECT *, ROUND((total_injuries/annual_average_employees),3) * 100 AS Injured_per_store_percentage 
FROM Ralphs
ORDER BY Injured_per_store_percentage DESC

--Make new column for percent of injured for whole Division
SELECT (SUM(total_injuries)/SUM(annual_average_employees)) * 100 AS Percent_injured_for_Division
FROM Ralphs

--COVID RELATED CASES for whole divison
SELECT COUNT(*) AS Total_Covid_cases
FROM Ralphs
WHERE total_respiratory_conditions > 0

--COVID cases for each store
SELECT establishment_name,street_address,city,state,zip_code,total_respiratory_conditions
FROM Ralphs
WHERE total_respiratory_conditions > 0
ORDER BY total_respiratory_conditions DESC, city ASC

--Covid Cases per each city
SELECT city, SUM(total_respiratory_conditions) AS Total_cases_per_city
FROM Ralphs
WHERE total_respiratory_conditions > 0
GROUP BY city
ORDER BY SUM(total_respiratory_conditions) DESC

--Stores in Los Angeles that have high covid counts
SELECT establishment_name,street_address,city,state,zip_code,total_respiratory_conditions
FROM Ralphs
WHERE total_respiratory_conditions > 0 AND city = 'Los Angeles'
ORDER BY total_respiratory_conditions DESC






