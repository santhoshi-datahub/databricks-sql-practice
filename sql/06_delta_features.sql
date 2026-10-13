-- 06_delta_features.sql: Databricks / Delta Lake specifics (great for a portfolio!)
USE main.sql_practice;

-- 1. Inspect table history and details
DESCRIBE HISTORY customers;
DESCRIBE DETAIL customers;

-- 2. Make a change, then time travel
UPDATE customers SET segment = 'Corporate' WHERE customer_id = 1;
SELECT * FROM customers VERSION AS OF 0 WHERE customer_id = 1;   -- before
SELECT * FROM customers WHERE customer_id = 1;                    -- after

-- 3. Restore a previous version
-- RESTORE TABLE customers TO VERSION AS OF 0;

-- 4. MERGE (upsert) example
CREATE OR REPLACE TEMP VIEW customer_updates AS
SELECT * FROM VALUES
  (1,  'Ava',  'Smith', 'ava.new@example.com',  'West', 'CA', 'Corporate', DATE'2022-03-01'),
  (999,'Zoe',  'Adams', 'zoe@example.com',      'East', 'NY', 'Consumer',  DATE'2024-06-01')
AS t(customer_id, first_name, last_name, email, region, state, segment, signup_date);

MERGE INTO customers AS tgt
USING customer_updates AS src ON tgt.customer_id = src.customer_id
WHEN MATCHED THEN UPDATE SET *
WHEN NOT MATCHED THEN INSERT *;

-- 5. Optimize
OPTIMIZE customers;
