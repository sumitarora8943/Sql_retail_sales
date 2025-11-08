-- Create Table

CREATE TABLE retail_sales(
			transaction_id INT PRIMARY KEY,
			sale_date DATE,
			sale_time TIME,
			customer_id INT,
			gender VARCHAR(20),
			age INT,
			category VARCHAR(20),
			quantity INT,
			price_per_unit FLOAT,
			cogs FLOAT,
			total_sale FLOAT
			
		)

--  Checking the table

SELECT * from retail_sales;

--  Importing the data
-- Steps
	-- 1. Select the table 
	-- 2. Right click
	-- 3. Import/Export Data
	-- 4. under General tab Select the .csv file location
	-- 5. under option tab select the header to be enable 
	-- 6. Click ok

-- Now again checking the data
SELECT * FROM retail_sales;

-- Exploratory Analysis on Data
SELECT * FROM retail_sales LIMIT 10;

-- Finding How many rows are there ??
SELECT COUNT(*) from retail_sales;



-- HANDLING NULL VALUES

-- Identifying Null values

-- FOR transaction_id
SELECT * FROM retail_sales
WHERE transaction_id IS NULL;
-- No Null Value

-- FOR sale_date
SELECT * FROM retail_sales
WHERE sale_date IS NULL;
-- No Null Value

-- FOR sale_time
SELECT * FROM retail_sales
WHERE sale_time IS NULL;
-- No Null Value

-- FOR customer_id
SELECT * FROM retail_sales
WHERE customer_id IS NULL;
-- No Null Value

-- FOR gender
SELECT * FROM retail_sales
WHERE gender IS NULL;
-- No Null Value

-- FOR age
SELECT * FROM retail_sales
WHERE age IS NULL;
-- There are 10 records which have the age as null

-- FOR cateogory
SELECT * FROM retail_sales
WHERE category IS NULL;
-- No Null Value

-- FOR quantity
SELECT * FROM retail_sales
WHERE quantity IS NULL;
-- There are 3 records which have the quantity as null

-- FOR price_per_unit
SELECT * FROM retail_sales
WHERE price_per_unit IS NULL;
-- There are 3 records which have the price_per_unit as null

-- FOR cogs
SELECT * FROM retail_sales
WHERE cogs IS NULL;
-- There are 3 records which have the cogs as null

-- FOR total_sale
SELECT * FROM retail_sales
WHERE total_sale IS NULL;
-- There are 3 records which have the total_sale as null


--  Now getting this identification of null in single query

SELECT * FROM retail_sales
WHERE
	transaction_id IS NULL
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
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;
	

--  Handling Null value in the rows which have quanity,price_per_unit,cogs,total_sale column

DELETE FROM retail_sales
WHERE
	transaction_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;

-- DATA EXPLORATION
-- How many sales we have ?

SELECT COUNT(*) as total_sales FROM retail_sales;

-- How many customers we have ?

SELECT COUNT(DISTINCT customer_id) AS total_customer from retail_sales

-- Number of categories
SELECT COUNT(DISTINCT category) as distinct_category FROM retail_sales

-- Which all are that distinct category
SELECT DISTINCT category as distinct_category FROM retail_sales


--  DATA ANALYSIS BY SOLVING BUSINESS PROBLEMS

-- Q1. Write a SQL Query to retrieve  all columns for sale made on '2022-11-05' ?

SELECT * FROM retail_sales where sale_date = '2022-11-05'

-- Q2. Write a SQL Query to retrieve all transactions where the category is 'Clothing' and quantity sold is more than 3 in the month of november?

SELECT * FROM retail_sales
WHERE
category = 'Clothing'
AND
TO_CHAR(sale_date,'YYYY-MM')='2022-11'
AND
quantity>3;




-- Q3. The a SQL query to calculate the total quantity by each category in descending order ?

SELECT category,SUM(quantity) as total_quantity
FROM retail_sales
GROUP BY category
ORDER BY total_quantity DESC;

-- Q4. The a SQL query to calculate the total sales by each category in descending order ?
SELECT category,SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY category
ORDER BY total_sales DESC;

-- Q5. Write a SQL Query to find the average age of the customer who purchased items from the 'beauty' category?

SELECT ROUND(AVG(age),2) as Avg_age from retail_sales 
where category = 'Beauty'

-- Q6. Write a SQL query to find all the transaction where total_sale is greater than 1000.

SELECT * FROM retail_sales 
WHERE total_sale >1000;


-- Q7. Write a SQL Query to find the total number of transactions made by each gender in each category ?

SELECT gender,category,COUNT(*) AS total_sale_count from retail_sales
GROUP BY category,gender;

-- Q8. Write a SQL Query to calculate the average sale for each month, Find out best selling month in each year ?
SELECT year,month,avg_sale FROM
(SELECT
	EXTRACT(YEAR FROM sale_date) as year,
	EXTRACT(MONTH FROM sale_date) as month,
	AVG(total_sale) as avg_sale,
	RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date)ORDER BY AVG(total_sale) DESC ) as rank
FROM retail_sales
GROUP BY year,month) as t1
WHERE rank=1;

-- Q9. Write a SQL Query to find the top 5 customer based on highest total sales.

SELECT customer_id,SUM(total_sale) as total_sale FROM retail_sales
GROUP BY customer_id
ORDER BY total_sale DESC
LIMIT 5;

-- Q10. Write a SQL Squey to find the number of unique customers who purchased items in each category.

SELECT
    category,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category
ORDER BY category;

-- Q11. Write a SQL Query to create each shift and number of orders (example Morning <12 , afternoon 12-17, Evening >17)
WITH hourly_sale 
as (
SELECT *,
	CASE 
	WHEN EXTRACT(HOUR from sale_time) < 12 THEN 'Morning'
	WHEN EXTRACT(HOUR from sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
	ELSE 'Evening'
	END as shift
	FROM retail_sales
)
SELECT shift,COUNT(shift) as no_of_orders FROM hourly_sale
GROUP BY shift
ORDER BY 2 DESC;





-- Show only the first 10 transactions.
	SELECT * FROM retail_sales
	LIMIT 10;

-- Display all transactions made by a specific customer (e.g., customer_id = 101).
	SELECT * FROM retail_sales
	WHERE transaction_id = 101

-- List all unique product categories.
	SELECT DISTINCT category from retail_sales

-- Find the total number of transactions recorded.
	SELECT COUNT(*) FROM retail_sales

-- Retrieve all sales where the quantity is greater than 5.
	SELECT * FROM retail_sales WHERE quantity > 5

-- Display all sales that happened on a particular date.
	SELECT * FROM retail_sales WHERE sale_date = '2023-11-05'

-- Find all transactions with gender = 'Female'.
	SELECT COUNT(*) FROM retail_sales WHERE gender = 'Female'

-- Sort all sales by sale_date in descending order.
	SELECT sale_date,total_sale FROM retail_sales
	ORDER BY 1 DESC

-- Show all transactions where total_sale > 1000.
	SELECT * FROM retail_sales WHERE total_sale >1000


-- Find the total revenue (SUM(total_sale)) for each category.
	SELECT category, SUM(total_sale) FROM retail_sales GROUP BY category

-- Find the average price_per_unit for each category.
	SELECT category,ROUND(AVG(price_per_unit)::numeric,2) FROM retail_sales
	GROUP BY category

-- Calculate total quantity sold per day.
	SELECT sale_date,SUM(quantity) FROM retail_sales
	GROUP BY sale_date

-- Find the number of transactions per gender.
	SELECT gender,COUNT(transaction_id) FROM retail_sales GROUP BY gender

-- Calculate average age of customers who made purchases.
	SELECT ROUND(AVG(age)::numeric,2) as avg_age FROM retail_sales 

-- Find maximum and minimum total_sale amounts.
	SELECT MIN(total_sale),MAX(total_sale) FROM retail_sales

-- Count how many unique customers made purchases each day.
	SELECT sale_date,COUNT(DISTINCT customer_id) as no_of_customer FROM retail_sales GROUP BY sale_date

-- Find number of unique customers per category.
	SELECT category,COUNT(DISTINCT customer_id) FROM retail_sales GROUP BY category

-- Find total sales and number of items sold by category and gender.
	SELECT category,gender,SUM(quantity) AS total_quantity,SUM(total_sale) AS total_sales_value FROM retail_sales
	GROUP BY category,gender

-- Find average total_sale per customer.
	SELECT customer_id,ROUND(AVG(total_sale)::numeric,2) AS total_sales FROM retail_sales GROUP BY customer_id


-- Calculate the total revenue (sum of total_sale) for the entire dataset.
	SELECT SUM(total_sale) AS total_revenue FROM retail_sales

-- Find the profit margin if profit = total_sale - cogs.
	SELECT SUM(total_sale - cogs) / SUM(total_sale) * 100 as profit_percentage FROM retail_sales
 
-- Determine which category generated the highest total sales.
	SELECT category, SUM(total_sale) AS total_sale from retail_sales GROUP BY category ORDER BY total_sale DESC LIMIT 1

-- Find the category with the lowest total sales.
	SELECT category, SUM(total_sale) AS total_sale from retail_sales GROUP BY category ORDER BY total_sale  LIMIT 1

-- Find the top 5 customers by total spending.
	SELECT customer_id , SUM(total_sale) AS total_sale FROM retail_sales GROUP BY customer_id ORDER BY total_sale DESC LIMIT 5

-- Find the top 3 categories by total quantity sold.
	SELECT category, SUM(quantity) as total_quantity FROM retail_sales GROUP BY category ORDER BY total_quantity DESC LIMIT 3

-- Calculate total sales by each gender.
	SELECT gender, SUM(total_sale) as total_sales FROM retail_sales GROUP BY gender ORDER by total_sales

-- Find the average order value per gender.
	SELECT gender, ROUND(AVG(total_sale) ::numeric,2)as avg_total_sales FROM retail_sales GROUP BY gender ORDER by avg_total_sales

-- Calculate daily sales trends (sum of total_sale per sale_date).
	SELECT sale_date, SUM(total_sale) AS total_daily_sale FROM retail_sales GROUP BY sale_date ORDER BY sale_date 

-- Find total cogs per category.
	SELECT category,ROUND(SUM(cogs)::numeric,2) as total_cp FROM retail_sales GROUP BY category


-- Find total sales for each day of the week.
	SELECT EXTRACT(DOW FROM sale_date) AS week_day ,SUM(total_sale) AS total_sale FROM retail_sales GROUP BY week_day ORDER BY total_sale DESC
	-- Second way in which date name is actually seen
	SELECT TO_CHAR(sale_date, 'FMDay') AS week_day,SUM(total_sale) AS total_sale FROM retail_sales GROUP BY week_day ORDER BY total_sale DESC;
 
-- Find total sales by month.
	SELECT EXTRACT(MONTH FROM sale_date) AS month_of_year ,SUM(total_sale) as total_revenue FROM retail_sales GROUP BY month_of_year ORDER BY total_revenue DESC
	-- Second way in which MONTH NAME is actually seen
	SELECT TO_CHAR(sale_date,'MONTH') as month_of_year ,SUM(total_sale) as total_revenue FROM retail_sales GROUP BY month_of_year ORDER BY total_revenue DESC

-- Find the busiest hour of the day (based on number of transactions).
	SELECT EXTRACT(HOUR FROM sale_time)AS day_hour,COUNT(transaction_id)as total_transaction FROM retail_sales GROUP BY day_hour ORDER BY total_transaction DESC LIMIT 1

-- Find sales between specific times (e.g., between 09:00 and 12:00).
	SELECT SUM(total_sale) from retail_sales WHERE EXTRACT(HOUR FROM sale_time) BETWEEN 9 AND 12

-- Calculate total sales on weekends vs weekdays.
	-- THIS WILL GIVE THE DAY WISE TOTAL SALE
	SELECT TO_CHAR(sale_date,'FMDay') as weekday,SUM(total_sale)  FROM retail_sales GROUP BY weekday
	-- EXACT ANSWER
	SELECT 
	CASE 
		WHEN EXTRACT(DOW FROM sale_date) IN (0,6) THEN 'WEEKEND'
		ELSE 'WEEKDAY'
		END AS day_category,
	SUM(total_sale)
	FROM retail_sales
	GROUP BY day_category
		

-- Find which date had the maximum total sales.
	SELECT sale_date ,SUM(total_sale) AS total_revenue FROM retail_sales GROUP BY sale_date ORDER BY total_revenue DESC LIMIT 1

-- Find number of customers who purchased during morning, afternoon, evening slots.
	SELECT
	CASE
	WHEN EXTRACT(HOUR FROM sale_time) < 12  THEN 'MORNING'
	WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
	ELSE 'EVENING'
	END AS time_slots,
	COUNT(customer_id) AS total_customer
	from retail_sales
	GROUP BY time_slots
	ORDER BY total_customer DESC
	

	

-- Count how many customers made repeat purchases.
	SELECT
    customer_id,
    COUNT(*) AS total_transactions
	FROM retail_sales
	GROUP BY customer_id
	HAVING COUNT(*) > 1;

	
-- Identify new customers who purchased only once.
	SELECT
    customer_id,
    COUNT(*) AS total_transactions
	FROM retail_sales
	GROUP BY customer_id
	HAVING COUNT(*) = 1;


-- Calculate average spending per customer.
	SELECT customer_id,ROUND(AVG(total_sale)::numeric,2) AS Average_spending FROM retail_sales GROUP BY customer_id

-- Find customers who spent more than 5000 in total.
	SELECT customer_id,SUM(total_sale) AS total_sale FROM retail_sales GROUP BY customer_id HAVING SUM(total_sale)>5000 ORDER BY total_sale DESC

-- Find customers who purchased from more than one category.
	SELECT customer_id,count(DISTINCT category) as category_purchased FROM retail_sales GROUP BY customer_id HAVING count(DISTINCT category)>1 
	

-- Show gender distribution of customers by category.
	SELECT gender,category, COUNT(transaction_id) as total_sales FROM retail_sales GROUP BY gender,category 

-- Find the youngest and oldest customers who made purchases.
	SELECT MIN(age),MAX(age) from retail_sales

-- Find the age group that spent the most.
	SELECT SUM(total_sale) AS total_spend,
	CASE
	WHEN age <18 THEN 'Teenagers'
	WHEN age BETWEEN 18 AND 25 THEN 'Young Aduls'
	WHEN age BETWEEN 26 AND 35 THEN 'Early Professionals'
	WHEN age BETWEEN 36 AND 45 THEN 'Middle Age'
	WHEN age BETWEEN 46 AND 60 THEN 'Mature Aduls'	
	ELSE 'Senior Citizen'
	END AS age_group
	FROM retail_sales
	GROUP BY age_group

	

-- Find all transactions where total_sale > 2 * cogs.
	SELECT transaction_id,cogs,total_sale  FROM retail_sales where total_sale > 2*cogs;
	

-- Identify transactions where quantity * price_per_unit != total_sale.
	SELECT transaction_id,quantity,price_per_unit  FROM retail_sales where quantity * price_per_unit != total_sale;

-- Find categories where the average total_sale > 1000.
	SELECT category,AVG(total_sale) as avg_sale FROM retail_sales GROUP BY category HAVING AVG(total_sale) >1000
	

-- List all customers who purchased more than 2 different categories.
	SELECT customer_id ,COUNT( DISTINCT category) FROM retail_sales GROUP BY CUSTOMER_id HAVING COUNT( DISTINCT category) >2
	

-- Find the date and category combination with maximum sales.
	SELECT sale_date,category ,SUM(total_sale) as total_sale FROM retail_sales GROUP BY category,sale_date ORDER BY total_sale DESC LIMIT 1

-- Calculate percentage contribution of each category to total sales.
	SELECT category,SUM(total_sale), SUM(total_sale) *100 / (SELECT SUM(total_sale) FROM retail_sales) AS perc_total FROM retail_sales GROUP BY category

