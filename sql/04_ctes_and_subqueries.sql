-- 04_ctes_and_subqueries.sql
USE main.sql_practice;

-- Q1. Customers whose total spend is above the average customer spend.
WITH spend AS (
  SELECT o.customer_id, SUM(oi.quantity * oi.sale_price) AS total_spend
  FROM orders o JOIN order_items oi ON o.order_id = oi.order_id
  WHERE o.status = 'Completed'
  GROUP BY o.customer_id
)
SELECT s.customer_id, ROUND(s.total_spend, 2) AS total_spend
FROM spend s
WHERE s.total_spend > (SELECT AVG(total_spend) FROM spend)
ORDER BY s.total_spend DESC;

-- Q2. Best-selling product in each category (CTE + ranking).
WITH sales AS (
  SELECT p.category, p.product_name, SUM(oi.quantity) AS units
  FROM order_items oi JOIN products p ON oi.product_id = p.product_id
  GROUP BY p.category, p.product_name
),
ranked AS (
  SELECT *, RANK() OVER (PARTITION BY category ORDER BY units DESC) AS rnk FROM sales
)
SELECT category, product_name, units FROM ranked WHERE rnk = 1;

-- TRY IT: Find customers who bought from every product category.
