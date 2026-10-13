-- 01_basics.sql: SELECT, WHERE, ORDER BY, LIMIT, DISTINCT
USE main.sql_practice;

-- Q1. List all customers in the West region, newest signups first.
SELECT * FROM customers WHERE region = 'West' ORDER BY signup_date DESC;

-- Q2. What distinct product categories exist?
SELECT DISTINCT category FROM products ORDER BY category;

-- Q3. Top 5 most expensive products.
SELECT product_name, unit_price FROM products ORDER BY unit_price DESC LIMIT 5;

-- Q4. Completed orders placed in 2024.
SELECT * FROM orders WHERE status = 'Completed' AND order_date BETWEEN '2024-01-01' AND '2024-12-31';

-- TRY IT: Find customers whose email ends in '1@example.com' (hint: LIKE).
