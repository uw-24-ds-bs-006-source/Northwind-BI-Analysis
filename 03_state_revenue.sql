SELECT 
    c.state_province,
    COUNT(DISTINCT o.id) AS orders_count,
    ROUND(SUM(od.quantity * od.unit_price * (1 - od.discount)), 2) AS revenue
FROM customers c
JOIN orders o ON o.customer_id = c.id
JOIN order_details od ON od.order_id = o.id
GROUP BY c.state_province
ORDER BY revenue DESC;customersemployee_privilegesemployee_privilegesemployees