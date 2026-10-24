USE northwind;

SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_details', COUNT(*) FROM order_details
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'inventory_transactions', COUNT(*) FROM inventory_transactions;


SELECT COUNT(*) AS order_details_without_order
FROM order_details od
LEFT JOIN orders o ON o.id = od.order_id
WHERE o.id IS NULL;

SELECT COUNT(*) AS order_details_without_product
FROM order_details od
LEFT JOIN products p ON p.id = od.product_id
WHERE od.product_id IS NOT NULL AND p.id IS NULL;

