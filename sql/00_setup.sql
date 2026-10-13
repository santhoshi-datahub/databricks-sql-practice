-- 00_setup.sql
-- Create a schema and load the CSVs from a Unity Catalog Volume.
-- Before running: upload the 4 CSV files in /data to a Volume
-- (Catalog > your catalog > your schema > Create > Volume, then Upload to this volume).
-- Replace the catalog/schema/volume names below to match yours.

CREATE SCHEMA IF NOT EXISTS main.sql_practice;
USE main.sql_practice;

CREATE VOLUME IF NOT EXISTS main.sql_practice.raw;

-- Upload CSVs to: workspace.e_commerce_practise.e_commerce/

CREATE OR REPLACE TABLE customers AS
SELECT customer_id, first_name, last_name, email, region, state, segment, CAST(signup_date AS DATE) AS signup_date
FROM read_files('workspace.e_commerce_practise.e_commerce/customers.csv', format => 'csv', header => true, inferSchema => true);

CREATE OR REPLACE TABLE products AS
SELECT * FROM read_files('workspace.e_commerce_practise.e_commerce/products.csv', format => 'csv', header => true, inferSchema => true);

CREATE OR REPLACE TABLE orders AS
SELECT order_id, customer_id, CAST(order_date AS DATE) AS order_date, status
FROM read_files('workspace.e_commerce_practise.e_commerce/orders.csv', format => 'csv', header => true, inferSchema => true);

CREATE OR REPLACE TABLE order_items AS
SELECT * FROM read_files('workspace.e_commerce_practise.e_commerce/order_items.csv', format => 'csv', header => true, inferSchema => true);

-- Sanity check
SELECT 'customers' AS tbl, COUNT(*) AS n FROM customers
UNION ALL SELECT 'products', COUNT(*) FROM products
UNION ALL SELECT 'orders', COUNT(*) FROM orders
UNION ALL SELECT 'order_items', COUNT(*) FROM order_items;
