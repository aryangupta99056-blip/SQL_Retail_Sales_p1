# SQL Retail Sales Analysis

## About the Project

This project is a basic SQL analysis of a retail sales dataset. I worked on this to practice SQL concepts like grouping, aggregation, and window functions, and to understand how sales data can be analyzed in a practical way.

---

## What I Did

* Analyzed monthly sales data
* Calculated average sales for each month
* Found the best performing month in each year
* Used SQL functions to extract meaningful insights

---

## Tools Used

* PostgreSQL
* SQL
* CSV dataset

---

## Highlight Queries

### 1. Average Monthly Sales

```sql
SELECT 
    EXTRACT(YEAR FROM sale_date) AS year,
    EXTRACT(MONTH FROM sale_date) AS month,
    AVG(sales) AS avg_sales
FROM retail_sales
GROUP BY year, month
ORDER BY year, month;
```

### 2. Best Selling Month in Each Year

```sql
SELECT year, month, avg_sales
FROM (
    SELECT 
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(sales) AS avg_sales,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sale_date) 
            ORDER BY AVG(sales) DESC
        ) AS rank
    FROM retail_sales
    GROUP BY year, month
) ranked_data
WHERE rank = 1;
```

---

## Project Files

* `SQL - Retail Sales Analysis utf.csv` → dataset
* `SQL_PROJECT 1(p1).sql` → all SQL queries
* `README.md` → project explanation

---

## How to Run

1. Import the dataset into PostgreSQL
2. Open the SQL file
3. Run the queries
4. Check the output

---

## What I Learned

Through this project, I improved my understanding of:

* GROUP BY and aggregate functions
* Date functions like EXTRACT
* Window functions like RANK()
* How real-world sales data is analyzed

---

## Author

Aryan Gupta



