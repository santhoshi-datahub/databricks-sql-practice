Databricks SQL Practice
Hands-on SQL practice on Databricks using a small e-commerce dataset (customers, products, orders, order items). Queries progress from basics to window functions and Delta Lake features.
Dataset
Table	Rows	Description
`customers`	60	Customer profile, region, segment, signup date
`products`	20	Product catalog with category and price
`orders`	250	Orders with date and status (Completed / Returned / Cancelled)
`order_items`	~620	Line items linking orders to products
All data is synthetic and randomly generated.
Skills Demonstrated
Joins (inner, left, anti)
Aggregations, `GROUP BY`, `HAVING`, conditional aggregation
CTEs and subqueries
Window functions (`RANK`, `ROW_NUMBER`, `LAG`, running totals)
Delta Lake: time travel, `MERGE`, `RESTORE`, `OPTIMIZE`
Unity Catalog schemas and Volumes
Getting Started
Sign up for the free Databricks Free Edition.
In Catalog Explorer, upload the four CSV files from `/data` to a Volume.
Run `sql/00_setup.sql` in the SQL Editor (adjust the catalog/schema/volume names if needed).
Work through `sql/01_...` to `sql/06_...` in order. Each file ends with a TRY IT challenge.
Repo Structure
```
data/   CSV sample data
sql/    Practice queries by topic
```
Progress Log
[ ] 01 Basics
[ ] 02 Joins
[ ] 03 Aggregations
[ ] 04 CTEs and Subqueries
[ ] 05 Window Functions
[ ] 06 Delta Features
Next Ideas
Build a Databricks SQL dashboard on monthly revenue
Add a medallion (bronze/silver/gold) pipeline
Add a notebook version with PySpark
