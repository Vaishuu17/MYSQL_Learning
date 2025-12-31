USE Dominos;

SELECT * FROM customers;
SELECT * FROM orders;

-- VIEWS-----
CREATE VIEW customer_spends AS
SELECT c.name,SUM(o.amount) AS total_spend
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
Group BY c.name 
ORDER BY total_spend DESC;

SELECT * FROM customer_spends;

UPDATE orders 
SET amount = 100 
WHERE order_id = 108;

SELECT * FROM customer_spends;

DROP VIEW customer_spends;
