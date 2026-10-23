# Findings Report — Northwind SQL Analysis

## 1. Project Summary
This project analyzes the Northwind relational database using MySQL to extract commercial insights. The analysis covers table row-count validation, product revenue, state-level revenue, monthly trends and month-over-month growth, category-level product rankings, customer purchasing patterns, revenue reconciliation, and query execution-plan inspection.

---

## 2. Query 1 — Data Validation
Checks row counts across key database tables.

| Table | Row Count |
| :--- | ---: |
| `customers` | 29 |
| `orders` | 48 |
| `order_details` | 58 |
| `products` | 45 |
| `inventory_transactions` | 102 |

### Key Findings
- There are 29 customer records, 48 order headers, and 58 order-detail rows in the supplied output.
- The database output includes 45 products and 102 inventory transactions.
- The `products` table contains `category` as a direct column in the active schema used for this analysis.

### Business Recommendations
- Run row-count and relationship-integrity checks before publishing reports.
- Verify that all cataloged products have appropriate inventory tracking; the row counts alone do not confirm that every product has an inventory transaction.

---

## 3. Query 2 — Top Products by Revenue
Revenue is calculated using the following formula:

`SUM(quantity * unit_price * (1 - discount))`

| Product | Units Sold | Total Revenue |
| :--- | ---: | ---: |
| Northwind Traders Coffee | 650 | 29,900.00 |
| Northwind Traders Beer | 487 | 6,818.00 |
| Northwind Traders Marmalade | 40 | 3,240.00 |
| Northwind Traders Mozzarella | 90 | 3,132.00 |
| Northwind Traders Clam Chowder | 290 | 2,798.50 |

### Key Findings
- **Coffee leads the supplied results:** It generated 29,900.00 from 650 units sold, approximately **43.9% of total revenue (68,137.00)**.
- **Beer ranked second by revenue:** It generated 6,818.00 from 487 units sold.
- **Marmalade generated high revenue relative to units sold:** It generated 3,240.00 from 40 units. This result alone does not establish premium pricing power or profitability.

### Business Recommendations
- Monitor Coffee inventory and supplier availability because Coffee contributes a large share of recorded revenue.
- Consider cross-promotions involving high-revenue products and other product lines, then evaluate results using sales data.

---

## 4. Query 3 — State-level Revenue

| State | Orders | Total Revenue |
| :--- | ---: | ---: |
| TN | 3 | 15,432.50 |
| ID | 1 | 13,800.00 |
| WI | 5 | 8,007.50 |
| NY | 4 | 4,949.00 |
| OR | 5 | 4,683.00 |
| FL | 4 | 4,644.75 |
| UT | 2 | 3,786.50 |
| CO | 3 | 2,905.50 |
| NV | 2 | 2,695.00 |
| CA | 3 | 2,550.00 |
| WA | 2 | 2,410.75 |
| IL | 6 | 2,272.50 |

### Key Findings
- **Tennessee (TN) had the highest listed revenue:** 15,432.50 across 3 orders.
- **Idaho (ID) generated 13,800.00 from one order.** This is a high value for a single recorded order, but more data is needed to determine whether it reflects a broader trend.
- **Order volume does not equal revenue volume:** Illinois (IL) had the most orders in the list (6), with revenue of 2,272.50. TN and ID together generated 29,232.50 from 4 orders.

### Business Recommendations
- Review the orders and customer accounts behind high-revenue results in TN and ID to see whether similar opportunities exist elsewhere.
- Examine Illinois order values and product mix before deciding whether volume incentives or bulk discounts would be useful.

---

## 5. Query 4 — Monthly Revenue and Month-over-Month (MoM) Growth
The query uses a Common Table Expression (CTE) and `LAG()` to compare each month's revenue with the previous month.

| Month | Revenue | Previous Month Revenue | MoM Growth |
| :--- | ---: | ---: | ---: |
| 2006-01 | 3,836.00 | — | — |
| 2006-02 | 2,241.50 | 3,836.00 | -41.6% |
| 2006-03 | 32,609.25 | 2,241.50 | +1,354.8% |
| 2006-04 | 19,355.25 | 32,609.25 | -40.6% |
| 2006-05 | 1,788.50 | 19,355.25 | -90.8% |
| 2006-06 | 8,306.50 | 1,788.50 | +364.4% |

### Key Findings
- **March 2006 was the peak month:** Revenue reached 32,609.25, up 1,354.8% from February.
- **May 2006 had the lowest revenue:** 1,788.50, down 90.8% from April.
- **June showed a recovery:** Revenue increased 364.4% to 8,306.50. The supplied data shows the changes but does not establish their causes.

### Business Recommendations
- Investigate the transactions and customers behind the March peak and May decline before attributing them to seasonality, promotions, or inventory behavior.
- Consider recurring delivery arrangements with interested business customers if further analysis confirms that revenue volatility is a business concern.

---

## 6. Query 5 — Category-wise Product Ranking
Products are ranked within each category using the `products.category` column and a SQL window function such as `RANK()` or `DENSE_RANK()`.

| Category | Product | Revenue | Rank |
| :--- | :--- | ---: | ---: |
| Baked Goods & Mixes | Northwind Traders Chocolate Biscuits Mix | 782.00 | 1 |
| Baked Goods & Mixes | Northwind Traders Scones | 200.00 | 2 |
| Beverages | Northwind Traders Coffee | 29,900.00 | 1 |
| Beverages | Northwind Traders Beer | 6,818.00 | 2 |
| Candy | Northwind Traders Chocolate | 2,550.00 | 1 |
| Canned Fruit & Vegetables | Northwind Traders Fruit Cocktail | 1,560.00 | 1 |
| Canned Meat | Northwind Traders Crab Meat | 2,208.00 | 1 |
| Condiments | Northwind Traders Cajun Seasoning | 880.00 | 1 |
| Condiments | Northwind Traders Syrup | 500.00 | 2 |
| Dairy products | Northwind Traders Mozzarella | 3,132.00 | 1 |
| Dried Fruit & Nuts | Northwind Traders Dried Apples | 2,120.00 | 1 |
| Dried Fruit & Nuts | Northwind Traders Dried Pears | 1,200.00 | 2 |
| Grains | Northwind Traders Long Grain Rice | 280.00 | 1 |
| Jams, Preserves | Northwind Traders Marmalade | 3,240.00 | 1 |
| Jams, Preserves | Northwind Traders Boysenberry Spread | 2,500.00 | 2 |
| Oil | Northwind Traders Olive Oil | 533.75 | 1 |
| Pasta | Northwind Traders Ravioli | 1,950.00 | 1 |
| Pasta | Northwind Traders Gnocchi | 380.00 | 2 |
| Sauces | Northwind Traders Curry Sauce | 2,600.00 | 1 |
| Soups | Northwind Traders Clam Chowder | 2,798.50 | 1 |

### Key Findings
- **Beverages leads the listed categories:** Coffee and Beer together generated 36,718.00.
- Category leaders in the supplied output include Marmalade in Jams, Preserves (3,240.00), Mozzarella in Dairy products (3,132.00), Clam Chowder in Soups (2,798.50), and Curry Sauce in Sauces (2,600.00).
- The listed lower-revenue products include Long Grain Rice (280.00) and Scones (200.00). Revenue alone is not enough to determine profitability or whether a product should be discontinued.

### Business Recommendations
- Review cost, margin, demand, and strategic value before making decisions about lower-revenue products.
- Consider featuring category leaders and other products with demonstrated sales, then monitor campaign performance.

---

## 7. Query 6 — Customer Purchase Analysis

| Company | Total Orders | Average Order Value | Total Revenue |
| :--- | ---: | ---: | ---: |
| Company BB | 3 | 5,144.17 | 15,432.50 |
| Company F | 5 | 1,601.50 | 8,007.50 |
| Company D | 4 | 1,237.25 | 4,949.00 |
| Company H | 5 | 936.60 | 4,683.00 |
| Company I | 2 | 1,893.25 | 3,786.50 |
| Company Z | 2 | 1,812.62 | 3,625.25 |
| Company CC | 3 | 968.50 | 2,905.50 |
| Company C | 3 | 850.00 | 2,550.00 |
| Company A | 2 | 1,205.38 | 2,410.75 |
| Company J | 4 | 353.12 | 1,412.50 |
| Company K | 2 | 509.75 | 1,019.50 |
| Company Y | 2 | 430.00 | 860.00 |

### Key Findings
- **Company BB had the highest total revenue:** 15,432.50, with an average order value of 5,144.17. Its revenue is approximately **22.6% of total revenue (68,137.00)**.
- **Companies F and H had the highest order counts in this table:** 5 orders each. Order counts alone do not establish customer loyalty or future demand.
- **Company Y had the lowest total revenue in the listed results:** 860.00 from 2 orders.

### Business Recommendations
- Review high-revenue customer needs and service expectations to identify opportunities to maintain business relationships.
- Investigate product mix and order values for lower-revenue accounts before offering discounts or incentives.

---

## 8. Query 7 — Revenue Verification
The query compares the direct total revenue from `order_details` with the sum of revenue aggregated by product through `products` and `order_details`.

| Verification Method | Total Revenue |
| :--- | ---: |
| Direct total revenue (`order_details`) | 68,137.00 |
| Product-wise aggregated revenue (`products` + `order_details`) | 68,137.00 |
| **Difference** | **0.00** |

### Key Findings
- **Revenue verification passed:** Both calculation methods returned 68,137.00, with a difference of 0.00.
- This confirms agreement between these two calculations. It does **not**, by itself, prove that every line item maps to a valid product or that no orphan records exist; those require separate integrity checks.

### Verification Scope
Query 7 verifies consistency between the two revenue calculations only. It does not automatically validate all other queries or the performance findings in Query 8.

---

## 9. Query 8 — Performance Test and Query Plan Inspection
The test inspects date filtering and execution plans on `inventory_transactions`.

- **Table size:** 102 rows.
- **March date filter:** Returned 64 rows.
- **Execution plan observations:** One tested query showed an index range scan using `idx_inv_created`; another query with a slightly different date predicate showed a full table scan.

### Key Findings and Technical Caveat
- Because the table is small, a table scan may be reasonable for the optimizer.
- The two tests used different predicates, so the results do not prove a definitive speed improvement from the index.

### Technical Recommendations
- Benchmark index usage with identical query predicates and controlled conditions, comparing index use with a scan on a larger dataset.
- Treat execution-plan observations as evidence of optimizer behavior, not as a measured speed improvement unless elapsed times are compared under controlled conditions.

---

## 10. Synthesized Business Recommendations
1. **Monitor the Beverage category:** Coffee and Beer generated 36,718.00, approximately **53.9% of total revenue**. Review stock availability and supplier risks.
2. **Investigate revenue fluctuations:** Analyze the transactions and customers behind the March peak and May decline before assigning causes.
3. **Use both revenue and order volume in regional decisions:** TN and ID had high revenue in the supplied results, while IL had the most orders among the listed states but lower total revenue.
4. **Review customer segments:** Company BB had the highest revenue; Companies F and H had the highest order counts in the customer table. Use these metrics as starting points for further account analysis, not as proof of loyalty.
5. **Maintain reconciliation checks:** Compare direct order-detail revenue with product-wise aggregated revenue before publishing financial summaries.

---

## 11. Data and Schema Caveats
- **Category column:** The active schema used for these results contains `products.category`. Do not join a separate `categories` table unless it exists in the database being queried.
- **Customer table:** The supplied validation output reports 29 customer records. Run `SELECT DATABASE();` and `SHOW TABLES;` to confirm the active schema when reproducing the project.
- **Revenue reconciliation:** The two supplied calculations both returned 68,137.00. This confirms consistency between those calculations, not every aspect of data integrity.
- **Performance testing:** The date-filter tests returned 64 rows, but different predicates and a small table mean the results are not conclusive evidence of a speed improvement.

---

## 12. Conclusion
The supplied SQL outputs identify Coffee as the leading product by revenue, Tennessee as the highest-revenue state in the listed results, March 2006 as the peak month, and Company BB as the highest-revenue customer in the customer table. The revenue reconciliation matched at 68,137.00 with a difference of 0.00, confirming consistency between the two revenue calculation methods. Other queries and performance results should be validated independently.
