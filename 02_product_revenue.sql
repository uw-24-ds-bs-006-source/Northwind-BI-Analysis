USE northwind;

SELECT 'customers' AS tbl, COUNT(*) AS total_rows FROM customers
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_details', COUNT(*) FROM order_details
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'inventory_transactions', COUNT(*) FROM inventory_transactions;

SELECT 
    p.product_name,
    SUM(od.quantity) AS units_sold,
    ROUND(SUM(od.quantity * od.unit_price * (1 - od.discount)), 2) AS revenue
FROM order_details od
JOIN products p ON p.id = od.product_id
GROUP BY p.id, p.product_name
ORDER BY revenue DESC
LIMIT 5;




