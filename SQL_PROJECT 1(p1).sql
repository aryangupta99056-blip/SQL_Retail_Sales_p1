--SQL Retail Sales Analysis - P1



--Create Table

Create Table Retail_Sales_tb
            (
              transactions_id INT PRIMARY KEY,
              sale_date DATE,
			  sale_time TIME,
              customer_id INT,
              gender VARCHAR(15),
              age INT,
              category VARCHAR(15),
              quantiy INT,
              price_per_unit FLOAT,	
              cogs FLOAT,
              total_sale FLOAT
             );


SELECT*
FROM Retail_Sales_tb


SELECT
   COUNT(*)
 FROM Retail_Sales_tb


--DATA CLEANING

SELECT*
FROM Retail_Sales_tb
WHERE transactions_id IS NULL

SELECT*
FROM Retail_Sales_tb
WHERE sale_date IS NULL

SELECT*
FROM Retail_Sales_tb
WHERE sale_time IS NULL

SELECT*
FROM Retail_Sales_tb
WHERE customer_id IS NULL

SELECT*
FROM Retail_Sales_tb
WHERE gender IS NULL

SELECT*
FROM Retail_Sales_tb
WHERE
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
	 total_sale IS NULL;



DELETE FROM Retail_sales_tb
WHERE
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
	 total_sale IS NULL;


--DATA EXPLORATION

--How many sales we have?

SELECT COUNT(*) as total_sale
FROM Retail_Sales_tb


-- How many unique customer we have?

SELECT COUNT(DISTINCT customer_id) as total_sale
FROM Retail_Sales_tb

--How many unique category we have?

SELECT DISTINCT category 
FROM Retail_Sales_tb


--Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
--Q1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'.
--Q2 Write a SQL query to retrieve all transactions where the category in 'clothing'and the quantity sold is more than 4 in the month of Nov-2022.
--Q3 Write a SQL query to calculate the total sales (total_sale) for each category.
--Q4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
--Q5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
--Q6 Write a SQL query to find the total number of transaction(transaction_id) made by each gender in each category.
--Q7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
--Q8 Write a SQL query to find the top 5 customer based on the highest total sales.
--Q9 Write a SQL query to find the number of unique customer who purchased items from each category.
--Q10 Write a SQL query to create each shift and number of orders(Example Morning <=12,Afternoon Between 12 & 17, Evening>17)



--Q1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'.

SELECT*
FROM Retail_Sales_tb
WHERE sale_date = '2022-11-05'


--Q2 Write a SQL query to retrieve all transactions where the category in 'clothing'and the quantity sold is more than 4 in the month of Nov-2022.

SELECT *
FROM Retail_Sales_tb
 
  where
  category ='Clothing'
  and 
  TO_CHAR(sale_date, 'YYYY-MM') = '2022-11' 
  AND
  quantiy >= 4


--Q3 Write a SQL query to calculate the total sales (total_sale) for each category.


select 
      category,
	  SUM(total_sale) as net_sale,
	  count(*) as total_orders
from retail_sales_tb
group by 1



--Q4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.


select 
       ROUND(AVG(age),2) as avg_age
from retail_sales_tb
where category = 'Beauty'



--Q5 Write a SQL query to find all transactions where the total_sale is greater than 1000.


SELECT *
from retail_sales_tb
where total_sale > 1000



--Q6 Write a SQL query to find the total number of transaction(transaction_id) made by each gender in each category.


select category,
       gender,
	   COUNT(*) AS total_transaction
from retail_sales_tb
GROUP BY 1,2
ORDER BY 1


--Q7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.


select
      year,
	  month,
	  avg_sale
from

(
SELECT 
      EXTRACT(year from sale_date) as Year,
	  EXTRACT(month from sale_date) as Month,
	  AVG (total_sale) As Avg_sale,
	  RANK() OVER(PARTITION BY EXTRACT(year from sale_date) ORDER BY AVG (total_sale)DESC) AS Rank
FROM retail_sales_tb
group by 1,2
)as t1
where rank =1
--ORDER BY 1, 3 DESC


--Q8 Write a SQL query to find the top 5 customer based on the highest total sales.

select
       customer_id,
	   sum(total_sale)as total_sales
from retail_sales_tb
group by 1
order by 2 desc
limit 5



--Q9 Write a SQL query to find the number of unique customer who purchased items from each category.



select
      category,
	  COUNT(customer_id)
from retail_sales_tb
group by category




--Q10 Write a SQL query to create each shift and number of orders(Example Morning <=12,Afternoon Between 12 & 17, Evening>17)



WITH hourly_sale
as
(
SELECT*,
      CASE
	      WHEN EXTRACT(HOUR FROM sale_time) <12 THEN 'Morning'
		  WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		  ELSE 'Evening'
	  END AS Shift
from retail_sales_tb
)

SELECT
      shift,
	  COUNT(transactions_id) as total_orders
FROM hourly_sale
group by shift



--END OF PROJECT




