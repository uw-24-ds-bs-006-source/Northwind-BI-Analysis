# Northwind SQL Findings Report

## 1. Project Objective
The objective of this project is to analyze the Northwind database using SQL and identify product revenue, state-wise revenue, monthly revenue trends, product rankings, and repeat customer behavior.

**Tools:** MySQL and MySQL Workbench  
**Database:** northwind

## 2. Data Validation

Previously recorded row counts:

| Table | Number of Rows |
|---|---:|
| customers | 29 |
| orders | 48 |
| order_details | 58 |
| products | 45 |
| inventory_transactions | 102 |

These counts should be verified again before final submission.

## 3. Product Revenue Analysis

Revenue was calculated using the formula:

`quantity * unit_price * (1 - discount)`

| Product | Units Sold | Revenue |
|---|---:|---:|
| Coffee | 650 | $29,900.00 |
| Beer | 487 | $6,818.00 |
| Marmalade | 40 | $3,240.00 |
| Mozzarella | 90 | $3,132.00 |
| Clam Chowder | 290 | $2,798.50 |

**Finding:** Coffee generated the highest revenue among the listed products.

## 4. State-Wise Revenue Analysis

Previously recorded results:

| State | Orders | Revenue |
|---|---:|---:|
| TN | 3 | $15,432.50 |
| ID | Not recorded | $13,800.00 |
| WI | Not recorded | $8,007.50 |
| NY | Not recorded | $4,949.00 |
| OR | Not recorded | $4,683.00 |
| FL | Not recorded | $4,644.75 |

**Finding:** TN had the highest revenue among the states listed above. Run the state revenue query to verify the complete results.

## 5. Monthly Revenue Analysis

| Month | Revenue | Monthly Change |
|---|---:|---:|
| January 2006 | $3,836.00 | — |
| February 2006 | $2,241.50 | -41.6% |
| March 2006 | $32,609.25 | +1354.8% |
| April 2006 | $19,355.25 | -40.6% |
| May 2006 | $1,788.50 | -90.8% |
| June 2006 | $8,306.50 | +364.4% |

**Finding:** March had the highest monthly revenue in the recorded period. Revenue changed significantly from month to month.

## 6. Product Ranking by Category

The category-ranking SQL query uses the `RANK()` window function to rank products within their categories according to revenue.

The actual query results should be added to this section after running `05_category_ranking.sql` in MySQL Workbench.

## 7. Repeat Customer Analysis

Previously recorded results:

| Customer/Company | Number of Orders | Total Revenue | Average Revenue per Order |
|---|---:|---:|---:|
| Company BB | 3 | $15,432.50 | $5,144.17 |
| Company F | 5 | $8,007.50 | $1,601.50 |
| Company D | 4 | $4,949.00 | $1,237.25 |

Run the customer analysis query to verify the full list of repeat customers.

## 8. Revenue Verification

Previously recorded total revenue: **$68,137**.

Run `07_verification_queries.sql` to confirm that the independent revenue calculations agree.

## 9. Query Performance Testing

The performance test compares query execution plans before and after creating an index.

The final report must include actual results from MySQL Workbench:

- Before index: [Add actual execution time and query plan]
- After index: [Add actual execution time and query plan]

Use the same query conditions before and after indexing. Earlier observations used different predicates, so they are not a fair comparison. Do not claim a performance improvement until the test is completed.

## 10. Conclusion

The recorded analysis shows that Coffee was the strongest revenue-generating product among the listed products, while March had the highest monthly revenue in the observed period.

The project demonstrates SQL skills in data validation, aggregation, revenue analysis, window functions, repeat customer analysis, and query performance testing.

All queries and figures should be rechecked against the final database before submission.
