
WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
        SUM(od.quantity * od.unit_price * (1 - od.discount)) AS revenue
    FROM orders o
    JOIN order_details od ON od.order_id = o.id
    WHERE o.order_date IS NOT NULL
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
),
monthly_with_previous AS (
    SELECT
        sales_month,
        revenue,
        LAG(revenue) OVER (ORDER BY sales_month) AS previous_month_revenue
    FROM monthly_revenue
)
SELECT
    sales_month,
    ROUND(revenue, 2) AS revenue,
    ROUND(previous_month_revenue, 2) AS previous_month_revenue,
    ROUND(
        100 * (revenue - previous_month_revenue) / NULLIF(previous_month_revenue, 0),
        1
    ) AS mom_growth_percent
FROM monthly_with_previous
ORDER BY sales_month;
