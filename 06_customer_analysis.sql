SELECT
    c.id AS customer_id,
    COALESCE(NULLIF(c.company, ''), CONCAT(c.first_name, ' ', c.last_name)) AS customer_name,
    COUNT(DISTINCT o.id) AS total_orders,
    ROUND(SUM(od.quantity * od.unit_price * (1 - od.discount)), 2) AS total_revenue,
    ROUND(
        SUM(od.quantity * od.unit_price * (1 - od.discount)) / NULLIF(COUNT(DISTINCT o.id), 0),
        2
    ) AS average_order_value
FROM customers c
JOIN orders o ON o.customer_id = c.id
JOIN order_details od ON od.order_id = o.id
GROUP BY c.id, customer_name
HAVING COUNT(DISTINCT o.id) >= 2
ORDER BY total_revenue DESC;
