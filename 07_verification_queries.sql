
USE northwind;

SELECT
    c.company,
    COUNT(DISTINCT o.id) AS orders_placed,
    ROUND(
        SUM(od.quantity * od.unit_price * (1 - od.discount)), 2
    ) AS total_revenue,
    ROUND(
        SUM(od.quantity * od.unit_price * (1 - od.discount))
        / COUNT(DISTINCT o.id), 2
    ) AS avg_order_value
FROM customers c
JOIN orders o
    ON c.id = o.customer_id
JOIN order_details od
    ON o.id = od.order_id
GROUP BY c.id, c.company
HAVING COUNT(DISTINCT o.id) >= 2
ORDER BY total_revenue DESC;
