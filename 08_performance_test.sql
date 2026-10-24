SELECT COUNT(*) AS total_rows
FROM inventory_transactions;

CREATE INDEX idx_inv_created
ON inventory_transactions(transaction_created_date);

EXPLAIN ANALYZE
SELECT
    id,
    transaction_type,
    transaction_created_date,
    product_id,
    quantity
FROM inventory_transactions
WHERE transaction_created_date
BETWEEN '2006-03-01 00:00:00'
    AND '2006-03-31 23:59:59';
    
    EXPLAIN ANALYZE
SELECT
    id,
    transaction_type,
    transaction_created_date,
    product_id,
    quantity
FROM inventory_transactions
WHERE transaction_created_date >= '2006-03-01'
  AND transaction_created_date < '2006-04-01';
