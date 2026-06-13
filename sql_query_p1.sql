1. Database Setup:
--SQL Retail Sales Analysis - p1
CREATE DATABASE sql_project_p1;

---Create Table:
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales(
	transactions_id	INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id INT,
	gender VARCHAR(10),
	age	INT,
	category VARCHAR(20),
	quantiy INT,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT
);

SELECT * FROM retail_sales;

2. Data Exploration & Cleaning:

Q.1 --- Record Count the No.of data is there
SELECT COUNT(*) FROM retail_sales;

Q.2 --- Customer Count:
SELECT COUNT(DISTINCT Customer_id) FROM retail_sales;

Q.3 --- Category Count And what is it:
SELECT category, COUNT(DISTINCT category) FROM retail_sales
GROUP BY category;

Q.4 --- Check Null Value :
SELECT * FROM retail_sales
WHERE (transactions_id IS NULL 
	  OR
	  sale_date	IS NULL
	  OR
	  sale_time IS NULL 
	  OR
	  customer_id	IS NULL 
	  OR
	  gender IS NULL 
	  OR
	  age IS NULL 
	  OR
	  category IS NULL
	  OR
	  quantiy IS NULL 
	  OR
	  price_per_unit IS NULL 
	  OR
	  cogs IS NULL 
	  OR
	  total_sale IS NULL 
);

Q.5 --- Delete the data where the NULL Values is Present
DELETE FROM retail_sales
WHERE (transactions_id IS NULL 
	  OR
	  sale_date	IS NULL
	  OR
	  sale_time IS NULL 
	  OR
	  customer_id	IS NULL 
	  OR
	  gender IS NULL 
	  OR
	  age IS NULL 
	  OR
	  category IS NULL
	  OR
	  quantiy IS NULL 
	  OR
	  price_per_unit IS NULL 
	  OR
	  cogs IS NULL 
	  OR
	  total_sale IS NULL 
);

SELECT * FROM retail_sales;

3. Data Analysis & Findings:

Q.6 --- Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

Q.7 --- Write a SQL query to retrieve all transactions where the category is 'Clothing'and the quantity sold is more than or Equal to 4 in the month of Nov-2022:
SELECT * FROM retail_sales
WHERE 
	  category ='Clothing'
	  AND
	  quantiy >= 4
	  AND
	  TO_CHAR(sale_date,'YYYY-MM') = '2022-11')

	  			OR

SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantiy >= 4
  AND EXTRACT(YEAR FROM sale_date) = 2022
  AND EXTRACT(MONTH FROM sale_date) = 11;


Q.8 --- Write a SQL query to calculate the total sales (total_sale) for each category.:
SELECT category, SUM(total_sale) AS TOTAL_SALES, COUNT(transactions_id) AS Orders
FROM retail_sales
GROUP BY category;

Q.9 --- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
SELECT category, AVG(age) FROM retail_sales
WHERE category = 'Beauty'
GROUP BY category;
                        

Q.10 --- Write a SQL query to find all transactions where the total_sale is greater than 1000.:
SELECT * FROM retail_sales
WHERE total_sale >1000;

Q.11 --- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT gender ,category, COUNT(*) AS No_Of_Trans FROM retail_sales
GROUP BY gender, category
ORDER BY No_Of_Trans DESC;

Q.12 --- Find the average age of customers.
SELECT ROUND(AVG(age),1) FROM retail_sales; --ROUND is udes heree for to rounded the value
											ROUND(FUNCTION_NAME(COLUMN_NAME),ROUND_ANS)

Q.13 --- Find categories with more than 500 transactions.
SELECT category, COUNT(transactions_id) AS NO_OF_TRANS FROM retail_sales
GROUP BY category
HAVING COUNT(transactions_id) > 500;

Q.14 --- Find genders whose total sales exceed ₹100,000.
SELECT gender, SUM(total_sale) AS Exceed_lakh FROM retail_sales
GROUP BY gender
HAVING SUM(total_sale) > 100000
LIMIT 1;

Q.15 --- Find categories where the average sale amount is greater than ₹500.
SELECT category, AVG(total_sale) FROM retail_sales
GROUP BY category
HAVING AVG(total_sale) > 450

Q.16 --- Find customers who made more than 5 purchases and count how many data is there:
SELECT SUM(purch) FROM 
(
SELECT customer_id, Count(*) AS purch FROM retail_sales
GROUP BY customer_id
HAVING Count(*) > 5
ORDER BY customer_id ASC
);

Q.17 --- Find months where total revenue exceeded ₹50,000.
SELECT TO_CHAR(sale_date,'MM') AS Only_Month, SUM(total_sale) AS Revenue FROM retail_sales
GROUP BY Only_Month
HAVING SUM(total_sale) > 50000
ORDER BY Revenue DESC;

Q.18 --- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT
 	YEAR,
	MONTH,
	AVG_SALE,
	sales_rank
FROM
(
SELECT 
	TO_CHAR(sale_date,'YYYY') AS YEAR, 
	TO_CHAR(sale_date,'MM') AS MONTH, 	
	ROUND(AVG(total_sale)::numeric,2) AS AVG_SALE ,
	RANK() OVER (
		PARTITION BY TO_CHAR(sale_date,'YYYY') 
		ORDER BY ROUND(AVG(total_sale)::numeric,2) DESC) AS sales_rank
FROM retail_sales
GROUP BY 
	TO_CHAR(sale_date,'YYYY'), 
	TO_CHAR(sale_date,'MM')
) AS T1
WHERE sales_rank=1;

Q.19 --- **Write a SQL query to find the top 5 customers based on the highest total sales **
SELECT 
	Customer_id, 
	SUM(total_sale) AS High_total_sales 
FROM retail_sales
GROUP BY Customer_id
ORDER BY High_total_sales DESC 
LIMIT 5;

Q.20 --- Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT category, COUNT(DISTINCT customer_id ) AS cnt_unique_cs FROM retail_sales
GROUP BY category

Q.21 --- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
WITH hourly_sale
AS(
SELECT *,
	CASE 
		WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END AS SHIFT
	FROM retail_sales
)
SELECT SHIFT, COUNT(*) AS NO_OF_ORDERS FROM hourly_sale
GROUP BY SHIFT

--- End of project