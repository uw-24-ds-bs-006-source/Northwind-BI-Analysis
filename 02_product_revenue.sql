
USE northwind;

SELECT
    p.id AS product_id,
    p.product_name,
    SUM(od.quantity) AS units_sold,
    ROUND(SUM(od.quantity * od.unit_price * (1 - od.discount)), 2) AS total_revenue
FROM order_details od
JOIN products p ON p.id = od.product_id
GROUP BY p.id, p.product_name
ORDER BY total_revenue DESC
LIMIT 10;
