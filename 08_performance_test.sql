
USE northwind;

EXPLAIN ANALYZE
SELECT id, transaction_created_date, product_id, quantity
FROM inventory_transactions
WHERE transaction_created_date >= '2006-03-01 00:00:00'
  AND transaction_created_date <  '2006-04-01 00:00:00';
  
CREATE INDEX idx_inv_created ON inventory_transactions (transaction_created_date);

EXPLAIN ANALYZE
SELECT id, transaction_created_date, product_id, quantity
FROM inventory_transactions
WHERE transaction_created_date >= '2006-03-01 00:00:00'
  AND transaction_created_date <  '2006-04-01 00:00:00';

SHOW INDEX FROM inventory_transactions;
