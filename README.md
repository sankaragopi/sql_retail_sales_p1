# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `sql_project_p1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

## 1.Dataset Information

The dataset contains retail transaction records including customer details, product categories, quantities sold, and total sales values.

### Key Columns

| Column Name | Description |
|---|---|
| transaction_id | Unique transaction identifier |
| sale_date | Date of transaction |
| sale_time | Time of transaction |
| customer_id | Unique customer identifier |
| gender | Customer gender |
| age | Customer age |
| category | Product category |
| quantity | Quantity purchased |
| price_per_unit | Price of each unit |
| cogs | Cost of Goods Sold |
| total_sale | Total sales amount |

---

## 2. Tools & Technologies Used

- PostgreSQL
- SQL
- Power BI
- DAX
- Microsoft Excel
- CSV Dataset
- Git & GitHub

---

## 3. Project Architecture

```text
Retail Sales Dataset (CSV)
            |
            v
      PostgreSQL Database
            |
            v
       SQL Analysis
            |
            v
      Power BI Dashboard
            |
            v
 Business Insights & Reports
```

---


### 4. Database Setup

- **Database Creation**: The project starts by creating a database named `sql_project_p1`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE sql_project_p1;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
```

### 5. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 6. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT
    *
FROM retail_sales
WHERE 
	  category ='Clothing'
	  AND
	  quantiy >= 4
	  AND
	  TO_CHAR(sale_date,'YYYY-MM') = '2022-11');
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT
    category,
    SUM(total_sale) AS TOTAL_SALES,
    COUNT(transactions_id) AS Orders
FROM retail_sales
GROUP BY category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT
    category,
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'
GROUP BY category;
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT 
    category,
    gender,
    COUNT(*) as No_Of_Trans
FROM retail_sales
GROUP BY 
    category,
    gender
ORDER BY No_Of_Trans DESC;
```

7. **Find the average age of customers**:
```sql
SELECT
    ROUND(AVG(age),1)
FROM retail_sales;
```
8. **Find categories with more than 500 transactions**:
```sql
SELECT
    category,
    COUNT(transactions_id) AS NO_OF_TRANS
FROM retail_sales
GROUP BY category
HAVING COUNT(transactions_id) > 500;
```
9. **Find genders whose total sales exceed ₹100,000**:
```sql
SELECT
    gender,
    SUM(total_sale) AS Exceed_sales
FROM retail_sales
GROUP BY gender
HAVING SUM(total_sale) > 100000
LIMIT 1;
```
10. **Find categories where the average sale amount is greater than ₹500**:
```sql
SELECT
    category,
    AVG(total_sale) FROM retail_sales
GROUP BY category
HAVING AVG(total_sale) > 450;
```
11. **Find customers who made more than 5 purchases and count how many data is there**:
```sql
SELECT SUM(purch) FROM 
(
SELECT
    customer_id,
    Count(*) AS purch FROM retail_sales
GROUP BY customer_id
HAVING Count(*) > 5
ORDER BY customer_id ASC
);
```
12. **Find months where total revenue exceeded ₹50,000**:
```sql
SELECT
    TO_CHAR(sale_date,'MM') AS Only_Month,
    SUM(total_sale) AS Revenue FROM retail_sales
GROUP BY Only_Month
HAVING SUM(total_sale) > 50000
ORDER BY Revenue DESC;
);
```

13. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
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
```

14. **Write a SQL query to find the top 5 customers based on the highest total sales**:
```sql
SELECT 
	Customer_id, 
	SUM(total_sale) AS High_total_sales 
FROM retail_sales
GROUP BY Customer_id
ORDER BY High_total_sales DESC 
LIMIT 5;
```

15. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT
    category,
    COUNT(DISTINCT customer_id ) AS cnt_unique_cs
FROM retail_sales
GROUP BY category
```

16. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    SHIFT,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY SHIFT
```
## 7. Power BI Dashboard Features

The dashboard includes:

- KPI Cards
- Monthly Sales Trend Analysis
- Category-wise Revenue Analysis
- Customer Analysis
- Revenue Distribution
- Slicers and Filters
- Dynamic Visualizations
- Interactive Reports

---
## 8. Dashboard Preview

### Sales Dashboard
### Customer Analysis Dashboard
### Profit Analysis Dashboard

---


## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

---
## Author

**Sankara Gopi**
Final Year Engineering Student | Aspiring Data Analyst

### Skills

- SQL
- PostgreSQL
- Power BI
- DAX
- Excel
- Data Visualization
- Data Analysis

---
## Connect With Me

- LinkedIn: linkedin.com/in/sankaragopi-b-9b45312b2
- GitHub: Add your GitHub Profile

---



