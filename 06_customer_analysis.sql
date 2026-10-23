WITH order_totals AS (
  SELECT 
    o.id AS order_id, 
    o.customer_id,
    SUM(od.quantity * od.unit_price * (1 - od.discount)) AS total
  FROM orders o
  JOIN order_details od ON od.order_id = o.id
  GROUP BY o.id, o.customer_id
)
SELECT 
  c.company,
  COUNT(*) AS orders_placed,
  ROUND(AVG(total), 2) AS avg_order_value,
  ROUND(SUM(total), 2) AS total_revenue
FROM order_totals ot
JOIN customers c ON c.id = ot.customer_id
GROUP BY c.id, c.company
HAVING COUNT(*) >= 2
ORDER BY total_revenue DESC;