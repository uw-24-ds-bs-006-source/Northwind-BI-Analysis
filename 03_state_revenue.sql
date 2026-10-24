
SELECT
    c.state_province AS state,
    COUNT(DISTINCT o.id) AS order_count,
    ROUND(SUM(od.quantity * od.unit_price * (1 - od.discount)), 2) AS total_revenue
FROM orders o
JOIN customers c ON c.id = o.customer_id
JOIN order_details od ON od.order_id = o.id
WHERE c.state_province IS NOT NULL
  AND TRIM(c.state_province) <> ''
GROUP BY c.state_province
ORDER BY total_revenue DESC;