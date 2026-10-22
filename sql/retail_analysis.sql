-- Run these queries after importing the three CSV files into SQL Server.
USE Retail_SQL_Analysis;
GO

SELECT COUNT(*) AS TotalCustomers FROM dbo.customers;
SELECT COUNT(*) AS TotalProducts FROM dbo.products;
SELECT COUNT(*) AS TotalOrders FROM dbo.orders;
-- 1. Total revenue
SELECT SUM(o.quantity * p.price) AS total_revenue
FROM orders o JOIN products p ON o.product_id=p.product_id;

-- 2. Revenue by category
SELECT p.category, SUM(o.quantity*p.price) AS revenue
FROM orders o JOIN products p ON o.product_id=p.product_id
GROUP BY p.category ORDER BY revenue DESC;

-- 3. Top customers
SELECT TOP 10 c.customer_name, SUM(o.quantity*p.price) AS revenue
FROM orders o JOIN customers c ON o.customer_id=c.customer_id
JOIN products p ON o.product_id=p.product_id
GROUP BY c.customer_name ORDER BY revenue DESC;

-- 4. Monthly revenue
SELECT YEAR(o.order_date) AS order_year, MONTH(o.order_date) AS order_month,
       SUM(o.quantity*p.price) AS revenue
FROM orders o JOIN products p ON o.product_id=p.product_id
GROUP BY YEAR(o.order_date),MONTH(o.order_date)
ORDER BY order_year,order_month;

-- 5. Product ranking using a window function
WITH product_sales AS (
 SELECT p.product_name, SUM(o.quantity*p.price) AS revenue
 FROM orders o JOIN products p ON o.product_id=p.product_id
 GROUP BY p.product_name
)
SELECT product_name,revenue,RANK() OVER(ORDER BY revenue DESC) AS revenue_rank
FROM product_sales ORDER BY revenue_rank;

-- 6. Above-average customers using CTE + subquery
WITH customer_sales AS (
 SELECT c.customer_id,c.customer_name,SUM(o.quantity*p.price) AS revenue
 FROM orders o JOIN customers c ON o.customer_id=c.customer_id
 JOIN products p ON o.product_id=p.product_id
 GROUP BY c.customer_id,c.customer_name
)
SELECT * FROM customer_sales
WHERE revenue > (SELECT AVG(revenue) FROM customer_sales)
ORDER BY revenue DESC;



SELECT DB_NAME() AS CurrentDatabase;

SELECT TABLE_SCHEMA, TABLE_NAME
FROM Retail_SQL_Analysis.INFORMATION_SCHEMA.TABLES;