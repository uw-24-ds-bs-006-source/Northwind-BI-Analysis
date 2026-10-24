
USE northwind;

WITH monthly AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS month,
        SUM(
            od.quantity * od.unit_price * (1 - od.discount)
        ) AS revenue
    FROM orders AS o
    JOIN order_details AS od
        ON od.order_id = o.id
    GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
),
monthly_comparison AS (
    SELECT
        month,
        revenue,
        LAG(revenue) OVER (ORDER BY month) AS prev_month_revenue
    FROM monthly
)
SELECT
    month,
    ROUND(revenue, 2) AS revenue,
    ROUND(prev_month_revenue, 2) AS prev_month_revenue,
    ROUND(
        100.0 * (revenue - prev_month_revenue)
        / NULLIF(prev_month_revenue, 0),
        1
    ) AS mom_growth_pct
FROM monthly_comparison
ORDER BY month;
