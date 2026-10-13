-- 05_window_functions.sql
USE main.sql_practice;

-- Q1. Running total of monthly revenue.
WITH monthly AS (
  SELECT date_trunc('month', o.order_date) AS month, SUM(oi.quantity * oi.sale_price) AS revenue
  FROM orders o JOIN order_items oi ON o.order_id = oi.order_id
  WHERE o.status = 'Completed' GROUP BY 1
)
SELECT month, ROUND(revenue, 2) AS revenue,
       ROUND(SUM(revenue) OVER (ORDER BY month), 2) AS running_total
FROM monthly ORDER BY month;

-- Q2. Month-over-month growth using LAG.
WITH monthly AS (
  SELECT date_trunc('month', o.order_date) AS month, SUM(oi.quantity * oi.sale_price) AS revenue
  FROM orders o JOIN order_items oi ON o.order_id = oi.order_id
  WHERE o.status = 'Completed' GROUP BY 1
)
SELECT month, ROUND(revenue, 2) AS revenue,
       ROUND(100.0 * (revenue - LAG(revenue) OVER (ORDER BY month)) / LAG(revenue) OVER (ORDER BY month), 1) AS mom_growth_pct
FROM monthly ORDER BY month;

-- Q3. Each customer's order number and days since their previous order.
SELECT customer_id, order_id, order_date,
       ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS order_seq,
       DATEDIFF(order_date, LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date)) AS days_since_prev
FROM orders;

-- Q4. Top 3 customers per region by revenue.
WITH rev AS (
  SELECT c.region, c.customer_id, SUM(oi.quantity * oi.sale_price) AS revenue
  FROM customers c JOIN orders o ON c.customer_id = o.customer_id
  JOIN order_items oi ON o.order_id = oi.order_id
  WHERE o.status = 'Completed' GROUP BY c.region, c.customer_id
)
SELECT * FROM (SELECT *, DENSE_RANK() OVER (PARTITION BY region ORDER BY revenue DESC) AS rnk FROM rev) WHERE rnk <= 3;

-- TRY IT: Calculate a 3-month moving average of revenue.
