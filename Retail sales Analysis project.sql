-- SQL Retail Data Analysis P1--
CREATE DATABASE AProject;

USE Aproject;
-- create table 
CREATE TABLE Retail_sales(
	transactions_id	int,
    sale_date date,
    sale_time time,
    customer_id	int,
    gender varchar(15),
    age	int,
    category varchar(15),
    qauntity int,
    price_per_unit float,
    cogs float,
    total_sale float
);

select * from retail_sales;

SELECT COUNT(*) FROM retail_sales;

SELECT * FROM retail_sales
WHERE transactions_id IS NULL
OR 
sale_date IS NULL
OR
sale_time IS NULL 
OR
customer_id IS NULL 
OR
gender IS NULL
OR
age IS NULL 
OR 
category IS NULL
OR 
qauntity IS NULL
OR
price_per_unit IS NULL
OR 
cogs IS NULL
OR 
total_sale IS NULL;

SELECT * 
FROM Retail_sales;
-- DATA EXPLORATION
-- HOW MANY SALES DO WE HAVE?>?

SELECT COUNT(*) AS TOTALCOUNT
FROM Retail_sales;

-- HOW MANY CUSTOMERS UNIQUE DO WE HAVE?>?>?
SELECT COUNT(DISTINCT customer_id) as total_sale FROM Retail_sales;

SELECT DISTINCT category from Retail_sales;

-- DATA ANALYSIS Q1'2022-11-05'

SELECT * FROM Retail_sales
WHERE sale_date = '2022-11-05';

-- data analysis q2 

SELECT * FROM Retail_sales
WHERE 
category = 'Clothing'
AND 
DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
AND
qauntity >=3;

-- Q3 write a sql query to calculate the total sales (total_sale) for each category.

SELECT CATEGORY, SUM(TOTAL_SALE) AS TOTAL_SALES, COUNT(*) AS TOTAL_ORDERS FROM RETAIL_SALES
GROUP BY CATEGORY;

-- Q4 SQL QUERY TO FIND THE AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEMS FROM THE 'BEAUTY' CATEGORY

SELECT CATEGORY, ROUND(AVG(AGE), 2) AS AVG_AGE FROM RETAIL_SALES
WHERE CATEGORY = 'BEAUTY'
GROUP BY CATEGORY;

-- Q5 SQL QUERY TO FIND ALL TRANSCATIONS WHERE THE TOTAL_SALE IS GREATER THAN 1000

SELECT * FROM RETAIL_SALES
WHERE TOTAL_SALE > 1000;

-- TOTAL NUMBERS OF SALES OF ABOVE QUERY
SELECT COUNT(*) FROM RETAIL_SALES
WHERE TOTAL_SALE > 1000;

-- Q6 SQL QUERY TO FIND THE TOTAL NUMBER OF TRANSACTION (TRANSACTION_ID) MADE BY EACH GENDER IN EACH 

SELECT CATEGORY, GENDER, COUNT(*) AS TOTAL_TRANS FROM RETAIL_SALES
GROUP BY CATEGORY, GENDER
ORDER BY 1;

SELECT * 
FROM Retail_sales;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT year,month,AVG_sales FROM(
SELECT 
YEAR(sale_date) AS year,
MONTH(sale_date) AS month,
ROUND(AVG(total_sale)) AS AVG_sales,
RANK() OVER (
        PARTITION BY YEAR(sale_date) 
        ORDER BY ROUND(AVG(total_sale)) DESC
    ) AS rank_no
FROM Retail_sales
GROUP BY 1,2) 
AS t1
WHERE rank_no = 1; 
-- ORDER BY 1,3 DESC;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales

SELECT CUSTOMER_ID, 
SUM(TOTAL_SALE) AS sale_co
FROM Retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT 
	CATEGORY,
	COUNT(DISTINCT CUSTOMER_ID) AS unique_customers
FROM Retail_sales
GROUP BY CATEGORY;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH hourly_sales
AS
(
SELECT *,
	CASE
		WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'MORNING'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
        ELSE 'EVENING'
	END AS SHIFT
 FROM RETAIL_SALES)
 SELECT SHIFT, COUNT(*) AS TOTAL_ORDERS FROM hourly_sales
 GROUP BY SHIFT;
 
