SELECT
    'direct_order_details_total' AS verification_method,
    ROUND(SUM(quantity * unit_price * (1 - discount)), 2) AS total_revenue
FROM order_details
UNION ALL
SELECT
    'product_join_total',
    ROUND(SUM(od.quantity * od.unit_price * (1 - od.discount)), 2)
FROM order_details od
JOIN products p ON p.id = od.product_id;

-- Check B: product revenue aggregated in one CTE versus a direct category total.
WITH product_totals AS (
    SELECT
        p.category,
        p.id AS product_id,
        SUM(od.quantity * od.unit_price * (1 - od.discount)) AS revenue
    FROM products p
    JOIN order_details od ON od.product_id = p.id
    GROUP BY p.category, p.id
),
category_totals_from_products AS (
    SELECT category, SUM(revenue) AS revenue
    FROM product_totals
    GROUP BY category
),
category_totals_direct AS (
    SELECT
        p.category,
        SUM(od.quantity * od.unit_price * (1 - od.discount)) AS revenue
    FROM products p
    JOIN order_details od ON od.product_id = p.id
    GROUP BY p.category
)
SELECT
    COALESCE(a.category, b.category) AS category,
    ROUND(a.revenue, 2) AS product_rollup_revenue,
    ROUND(b.revenue, 2) AS direct_category_revenue,
    ROUND(a.revenue - b.revenue, 2) AS difference
FROM category_totals_from_products a
JOIN category_totals_direct b
  ON a.category <=> b.category
ORDER BY category;
