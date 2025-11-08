
# 🛍️ Retail Sales Analysis using SQL (PostgreSQL)

### 📊 *A beginner-friendly project analyzing retail sales data using SQL for business insights.*

---

## 🚀 Project Overview

This project demonstrates SQL skills for **data cleaning, exploration, and business analysis** using **PostgreSQL**.  
It simulates real-world retail analytics — from database setup to answering key business questions.

**Database:** `p1_retail_db`  
**Table:** `retail_sales`  
**Level:** Beginner  

---

## 🎯 Objectives

1. **Database Setup:** Create and populate the retail sales database.  
2. **Data Cleaning:** Detect and remove `NULL` or invalid values.  
3. **Exploratory Data Analysis (EDA):** Explore key statistics and relationships.  
4. **Business Insights:** Solve real-world questions using analytical SQL queries.  

---

## 🧱 Database Structure

**Table Name:** `retail_sales`

| Column Name | Data Type | Description |
|--------------|------------|-------------|
| transaction_id | INT | Primary key |
| sale_date | DATE | Date of sale |
| sale_time | TIME | Time of sale |
| customer_id | INT | Unique customer identifier |
| gender | VARCHAR(10) | Gender of customer |
| age | INT | Customer age |
| category | VARCHAR(35) | Product category |
| quantity | INT | Quantity sold |
| price_per_unit | FLOAT | Price per item |
| cogs | FLOAT | Cost of goods sold |
| total_sale | FLOAT | Total revenue per transaction |

---

## 🧹 Data Cleaning

Checked for missing or inconsistent values using SQL filters and removed invalid records to ensure integrity.

```sql
SELECT * FROM retail_sales
WHERE sale_date IS NULL OR customer_id IS NULL 
      OR category IS NULL OR quantity IS NULL 
      OR price_per_unit IS NULL OR cogs IS NULL;
```

Deleted incomplete rows:

```sql
DELETE FROM retail_sales
WHERE quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

---

## 🔍 Data Exploration

Basic exploration using aggregate queries:

```sql
SELECT COUNT(*) AS total_transactions FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) AS total_customers FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;
```

---

## 💡 Business Analysis Queries

### 🗓️ Sales by Date
```sql
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';
```

### 👕 Clothing Sales in November
```sql
SELECT * FROM retail_sales
WHERE category = 'Clothing'
  AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
  AND quantity > 3;
```

### 💰 Total Sales by Category
```sql
SELECT category, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY category
ORDER BY total_sales DESC;
```

### 🎂 Average Age of Beauty Buyers
```sql
SELECT ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';
```

### 🔝 Top 5 Customers
```sql
SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

### ☀️ Shift-wise Orders
```sql
WITH hourly_sale AS (
  SELECT *,
    CASE
      WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
      WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
      ELSE 'Evening'
    END AS shift
  FROM retail_sales
)
SELECT shift, COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;
```

---

## 📈 Key Findings

- **High-value customers** identified through spending analysis.  
- **Peak sales hours** found between **12–17 (Afternoon)**.  
- **Weekend vs weekday** sales comparison revealed stronger weekend performance.  
- **Beauty and Clothing** categories were top performers.  
- **Profit margin:** ~34% (calculated via total_sale – cogs).

---

## 🧠 Learnings

✅ Data validation and cleaning in SQL  
✅ Query optimization using `GROUP BY`, `HAVING`, and subqueries  
✅ Time-based analysis using `EXTRACT()` and `TO_CHAR()`  
✅ Translating SQL results into business insights  

---

## 🧰 Tools & Technologies

- **Database:** PostgreSQL (pgAdmin 4)  
- **Languages:** SQL  
- **Data Source:** CSV import  
- **Visualization:** Power BI (future enhancement)  

---

## 👨‍💻 Author — *Sumit Arora*

💼 *Aspiring Data Analyst passionate about transforming data into business value.*

🔗 **Connect with Me:**  
- [LinkedIn](https://www.linkedin.com/in/sumitarora)  
- [GitHub](https://github.com/sumitarora)  
- [Email](mailto:sumitarora@example.com)
