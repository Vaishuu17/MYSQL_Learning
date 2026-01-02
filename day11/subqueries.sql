USE Dominos;

SELECT * FROM customers;
SELECT * FROM orders;

-- FIND CUSTOMERS WHO HAVE PLACED ATLEST ONE ORDER>>
SELECT name
FROM customers
WHERE customer_id IN (
SELECT customer_id 
FROM orders);

-- SAME QUE WITH JOIN> 
SELECT DISTINCT c.name 
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;

-- FIND CUSTOMERS WHO HAVE NOT PLACED ANY ORDER>>
SELECT name 
FROM customers 
WHERE customer_id NOT IN (
SELECT customer_id
FROM orders);

SELECT c.name 
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


-- CUSTOMERS WHOSE TOTAL SPENDING IS MORE THAN AVERAGE SPENDING >>
SELECT name
FROM customers
WHERE customer_id IN (
     SELECT customer_id
     FROM orders
     GROUP BY customer_id
     HAVING SUM(amount) > (
	          SELECT AVG(amount) FROM orders)
);

SELECT c.name 
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.name,c.customer_id
HAVING SUM(o.amount) > (SELECT AVG(o.amount) FROM orders o);


-- FIND CUSTOMERS WHO MADE THE MAXIMUM ORDER AMOUNT >>
SELECT name
FROM customers 
WHERE customer_id = (
SELECT customer_id
FROM orders
WHERE amount = (SELECT MAX(amount) FROM orders)); 

SELECT c.name
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.name
HAVING MAX(o.amount)
LIMIT 1;


-- CUSTOMERS WHO PLACED MORE THAN ONE ORDER>>
SELECT name
FROM customers
WHERE customer_id IN(
SELECT customer_id
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id)>1);

SELECT c.name
FROM customers c
LEFT JOIN orders o 
ON c.customer_id = o.customer_id
GROUP BY c.name
HAVING COUNT(o.order_id)>1;



