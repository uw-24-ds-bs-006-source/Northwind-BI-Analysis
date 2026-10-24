WITH product_revenue AS (
    SELECT
        p.category,
        p.id AS product_id,
        p.product_name,
        SUM(od.quantity * od.unit_price * (1 - od.discount)) AS revenue
    FROM products p
    JOIN order_details od ON od.product_id = p.id
    GROUP BY p.category, p.id, p.product_name
),
ranked_products AS (
    SELECT
        category,
        product_id,
        product_name,
        revenue,
        RANK() OVER (
            PARTITION BY category
            ORDER BY revenue DESC
        ) AS revenue_rank
    FROM product_revenue
)
SELECT
    category,
    product_id,
    product_name,
    ROUND(revenue, 2) AS revenue,
    revenue_rank
FROM ranked_products
ORDER BY category, revenue_rank, product_name;
