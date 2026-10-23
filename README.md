# Northwind-BI-Analysis
SQL data analysis project using the Northwind dataset
# Northwind SQL Data Analysis Project

## Project Overview
This project uses SQL in MySQL Workbench to analyze the Northwind sample database. It covers product revenue, state-level revenue, monthly trends, product ranking within categories, repeat-customer analysis, data validation, and query-plan inspection.

## SQL Files

| File | Purpose |
| :--- | :--- |
| `01_data_validation.sql` | Checks row counts in available tables. |
| `02_product_revenue.sql` | Calculates units sold and revenue for the top five products. |
| `03_state_revenue.sql` | Analyzes revenue and orders by state, if state/customer data exists in the schema. |
| `04_monthly_revenue_growth.sql` | Calculates monthly revenue and month-over-month growth using a CTE and `LAG()`. |
| `05_category_ranking.sql` | Ranks products by revenue within `products.category`. |
| `06_customer_analysis.sql` | Analyzes repeat customers; requires valid customer fields/tables in the database. |
| `07_verification_queries.sql` | Independently verifies revenue totals and product rankings. |
| `08_performance_test.sql` | Inspects date filtering and execution plans on `inventory_transactions`. |

## Tools and SQL Concepts
* **Tools:** MySQL and MySQL Workbench
* **SQL Concepts:** `JOIN`, `GROUP BY`, `HAVING`, `SUM()`, `COUNT()`, `AVG()`
* **Advanced Concepts:** Common Table Expressions (CTEs), Window functions (`LAG()`, `RANK()`), Subqueries, and `EXPLAIN ANALYZE`

## Key Findings from Supplied Query Outputs

### Data Validation
* **`customers`:** 29 rows
* **`orders`:** 48 rows
* **`order_details`:** 58 rows
* **`products`:** 45 rows
* **`inventory_transactions`:** 102 rows

### Top Products by Revenue
* **Northwind Traders Coffee:** 650 Units Sold | $29,900.00 Revenue
* **Northwind Traders Beer:** 487 Units Sold | $6,818.00 Revenue
* **Northwind Traders Marmalade:** 40 Units Sold | $3,240.00 Revenue
* **Northwind Traders Mozzarella:** 90 Units Sold | $3,132.00 Revenue
* **Northwind Traders Clam Chowder:** 290 Units Sold | $2,798.50 Revenue

> **Revenue Formula:** `quantity * unit_price * (1 - discount)`

### State Revenue Highlights
| State | Orders | Revenue ($) |
| :--- | :---: | :---: |
| **TN** | 3 | 15,432.50 |
| **ID** | 1 | 13,800.00 |
| **WI** | 5 | 8,007.50 |
| **NY** | 4 | 4,949.00 |
| **OR** | 5 | 4,683.00 |
| **FL** | 4 | 4,644.75 |
| **UT** | 2 | 3,786.50 |
| **CO** | 3 | 2,905.50 |
| **NV** | 2 | 2,695.00 |
| **CA** | 3 | 2,550.00 |
| **WA** | 2 | 2,410.75 |
| **IL** | 6 | 2,272.50 |

### Monthly Revenue Growth
| Month | Revenue ($) | Previous Month ($) | MoM Growth |
| :--- | :---: | :---: | :---: |
| **2006-01** | 3,836.00 | — | — |
| **2006-02** | 2,241.50 | 3,836.00 | -41.6% |
| **2006-03** | 32,609.25 | 2,241.50 | +1,354.8% |
| **2006-04** | 19,355.25 | 32,609.25 | -40.6% |
| **2006-05** | 1,788.50 | 19,355.25 | -90.8% |
| **2006-06** | 8,306.50 | 1,788.50 | +364.4% |

### Customer Analysis Highlights
* **Company BB:** Highest total revenue ($15,432.50) and highest average order value ($5,144.17).
* **Companies F and H:** Most orders placed (5 orders each).
* **Company Y:** Lowest total revenue among listed companies ($860.00).

### Category Ranking Highlights
* **Coffee:** $29,900.00 (Rank 1 in Beverages)
* **Marmalade:** $3,240.00 (Rank 1 in Jams, Preserves)
* **Mozzarella:** $3,132.00 (Rank 1 in Dairy products)
* **Clam Chowder:** $2,798.50 (Rank 1 in Soups)

### Performance Test
The March date filter returned 64 rows. One plan used an index range scan while another used a table scan. Because predicates differed and the table is small, this does not prove a definitive index performance improvement.


## Important Schema Notes
* The latest `SHOW TABLES` output did not include `customers` or `categories`, although the supplied row-count output reported 29 customers. This suggests outputs may come from different active schemas or database versions.
* The `products` table contains a `category` column. Do not use `JOIN categories` in the current category-ranking queries.
* The Query 7 output supplied was identical to the customer-analysis output; ensure `07_verification_queries.sql` runs the intended independent check.
* An earlier overall revenue reconciliation reported $68,137.00; reconfirm against the active database before final submission.
* Confirm the active schema using `SELECT DATABASE();`, then check table and column names with `SHOW TABLES;` and `DESCRIBE table_name;`.

## Suggested Repository Structure
```text
Northwind-BI-Analysis/
├── 01_data_validation.sql
├── 02_product_revenue.sql
├── 03_state_revenue.sql
├── 04_monthly_revenue_growth.sql
├── 05_category_ranking.sql
├── 06_customer_analysis.sql
├── 07_verification_queries.sql
├── 08_performance_test.sql
├── README.md
└── findings_report.md
