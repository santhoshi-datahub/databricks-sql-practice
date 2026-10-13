-- 02_joins.sql: INNER / LEFT joins across the star-ish schema
USE main.sql_practice;

-- Q1. Each order with the customer's full name.
SELECT o.order_id, o.order_date, CONCAT(c.first_name, ' ', c.last_name) AS customer
FROM orders o JOIN customers c ON o.customer_id = c.customer_id;

-- Q2. Line-item detail: order, product, category, line revenue.
SELECT oi.order_id, p.product_name, p.category, oi.quantity * oi.sale_price AS line_revenue
FROM order_items oi JOIN products p ON oi.product_id = p.product_id;

-- Q3. Customers who have NEVER placed an order (anti-join pattern).
SELECT c.customer_id, c.first_name, c.last_name
FROM customers c LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- Q4. Products that have never been sold.
SELECT p.product_name FROM products p
LEFT ANTI JOIN order_items oi ON p.product_id = oi.product_id;

-- TRY IT: Join all four tables to show customer, region, order date, product, and revenue in one result.
