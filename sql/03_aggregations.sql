-- 03_aggregations.sql: GROUP BY, HAVING, conditional aggregation
USE main.sql_practice;

-- Q1. Revenue by product category (completed orders only).
SELECT p.category, ROUND(SUM(oi.quantity * oi.sale_price), 2) AS revenue
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.status = 'Completed'
GROUP BY p.category ORDER BY revenue DESC;

-- Q2. Monthly revenue trend.
SELECT date_trunc('month', o.order_date) AS month, ROUND(SUM(oi.quantity * oi.sale_price), 2) AS revenue
FROM orders o JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'Completed'
GROUP BY 1 ORDER BY 1;

-- Q3. Customers with more than 5 orders.
SELECT customer_id, COUNT(*) AS order_count FROM orders GROUP BY customer_id HAVING COUNT(*) > 5 ORDER BY order_count DESC;

-- Q4. Return rate by region.
SELECT c.region,
       COUNT(*) AS total_orders,
       SUM(CASE WHEN o.status = 'Returned' THEN 1 ELSE 0 END) AS returned,
       ROUND(100.0 * SUM(CASE WHEN o.status = 'Returned' THEN 1 ELSE 0 END) / COUNT(*), 1) AS return_rate_pct
FROM orders o JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.region;

-- TRY IT: Average order value by customer segment.
