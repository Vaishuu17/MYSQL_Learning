-- LEFT JOIN -------- 
USE Dominos;
SELECT * FROM customers;
SELECT * FROM orders;

SELECT c.customer_id,c.name,o.food_item,o.amount 
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;


-- SHOW ALL CUSTOMERS AND FOOD THEY ORDERED (IF ANY)>>
SELECT c.customer_id,c.name,o.food_item
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id; 


-- SHOW ALL CUSTOMERS AND THIER ORDER AMOUNTS>>
SELECT c.customer_id,c.name,o.amount
FROM customers c 
LEFT JOIN orders o
ON c.customer_id = o.customer_id; 


-- FIND CUSTOMERS WHO HAVE NEVER PLACED ANY ORDER>> 
SELECT c.name
FROM customers c
LEFT JOIN orders o 
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL; 


-- SHOW TOTAL AMOUNT SPENT BY EACH CUSTOMER, INCLUDE CUSTOMERS WITH ZERO SPENDING >>
SELECT c.name, COALESCE(SUM(o.amount),0) AS total_spent       -- COALESCE >> REPLACEMENT OF NULL  
FROM customers c 
LEFT JOIN orders o 
ON c.customer_id = o.customer_id
GROUP BY c.name;

-- SHOW NUMBER OF ORDERS PLACED BY EACH CUSTOMERS >>
SELECT c.name, COUNT(o.order_id) AS total_order
FROM customers c 
LEFT JOIN orders o 
ON c.customer_id = o.customer_id
GROUP BY c.name;


-- FIND CUSTOMERS WHO NEVER ORDERED BIRYANI>>
SELECT c.name
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
AND o.food_item = "Biryani"
WHERE o.order_id IS NULL;


-- FIND CUSTOMERS WHO HAVE NOT ORDERED ANYTHING ABOVE 200>>
SELECT c.name
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.name
HAVING MAX(o.amount) <= 200;


-- FIND CUSTOMERS WHO PLACED EXACTLY ONE ORDER>>
SELECT c.name
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.name
HAVING COUNT(o.order_id) = 1;

 
-- FIND CUSTOMERS WHO PLACED NO ORDER OR ONLY ONE ORDER>>
SELECT c.name
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.name
HAVING COUNT(o.order_id) <=1;


-- FIND CUSTOMERS WHOSE TOTAL SPENDING IS LESS THAN 300>>
SELECT c.name
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.name
HAVING COALESCE(SUM(o.amount),0)<300;

