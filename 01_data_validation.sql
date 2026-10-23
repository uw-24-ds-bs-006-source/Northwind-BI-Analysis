USE northwind;

SELECT
    (SELECT ROUND(
        SUM(quantity * unit_price * (1 - discount)), 2
    )
    FROM order_details) AS raw_revenue,

    (SELECT ROUND(SUM(state_rev), 2)
     FROM (
         SELECT SUM(
             od.quantity * od.unit_price * (1 - od.discount)
         ) AS state_rev
         FROM customers c
         JOIN orders o ON o.customer_id = c.id
         JOIN order_details od ON od.order_id = o.id
         GROUP BY c.state_province
     ) AS s) AS sum_of_states,

    (SELECT ROUND(SUM(month_rev), 2)
     FROM (
         SELECT SUM(
             od.quantity * od.unit_price * (1 - od.discount)
         ) AS month_rev
         FROM orders o
         JOIN order_details od ON od.order_id = o.id
         GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
     ) AS m) AS sum_of_months;
