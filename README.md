# Northwind SQL Business Analysis

## Project Overview
This project analyzes the Northwind sample database using SQL to understand product revenue, state revenue, monthly revenue changes, product rankings, and repeat customers.

**Database:** northwind  
**Tools:** MySQL and MySQL Workbench

## Business Questions
1. Which products generate the most revenue?
2. Which states generate the most revenue?
3. How does revenue change month by month?
4. Which products rank highest within each category?
5. Which customers place multiple orders?

## SQL Files
- 01_data_validation.sql — validates table counts and data relationships.
- 02_product_revenue.sql — analyzes product sales and revenue.
- 03_state_revenue.sql — analyzes revenue by state.
- 04_monthly_revenue_growth.sql — calculates monthly revenue changes.
- 05_category_ranking.sql — ranks products within categories.
- 06_customer_analysis.sql — analyzes repeat customers.
- 07_verification_queries.sql — verifies revenue totals.
- 08_performance_test.sql — tests query performance.

## Key Findings
- Total revenue recorded: $68,137.
- Coffee revenue: $29,900.
- Beer revenue: $6,818.
- Marmalade revenue: $3,240.
- Mozzarella revenue: $3,132.
- Clam Chowder revenue: $2,798.50.
- Highest monthly revenue was March 2006: $32,609.25.

## How to Run
1. Open MySQL Workbench.
2. Connect to your MySQL server.
3. Select the northwind database.
4. Open and execute the SQL files.
5. Verify the results using 07_verification_queries.sql.
6. Run the performance test and record actual results.

## Important Notes
- Verify all findings by running the queries against your database.
- Add actual before-and-after performance results before submitting.
- Revenue formula: quantity * unit_price * (1 - discount).
