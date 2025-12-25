-- RIGHT JOIN----- 
USE Dominos;
SELECT * FROM customers;
SELECT * FROM orders;

SELECT c.customer_id,c.name,o.food_item
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id;


-- SHOW ALL ORDERS WITH CUSTOMER NAMES IF AVAILABLE >>
SELECT o.customer_id ,o.order_id,c.name,o.food_item,o.amount
FROM customers c
RIGHT JOIN orders o 
ON c.customer_id = o.customer_id;


-- FIND ORDERS PLACE BY CUSTOMERS NOT PRESENT IN THE CUSTOMER TABLE>>
 SELECT o.customer_id ,o.order_id,c.name,o.food_item,o.amount
FROM customers c
RIGHT JOIN orders o 
ON c.customer_id = o.customer_id
WHERE c.customer_id IS NULL;


-- REPLACE MISSING CUSTOMERS'S NAMES WITH "GUESTS">>
SELECT o.customer_id ,o.order_id,COALESCE(c.name,"Guests") AS customer_name,o.food_item,o.amount
FROM customers c
RIGHT JOIN orders o 
ON c.customer_id = o.customer_id;


-- COUNT NUMBER OF ORDERS PER CUSTOMERS ,INCLUDE UNREGISTERED CUSTOMERS >>
SELECT COUNT(o.order_id) AS total_orders ,COALESCE(c.name,"Unregistered") AS customer_type
FROM customers c
RIGHT JOIN orders o 
ON c.customer_id = o.customer_id
GROUP BY c.name;


-- SHOW ONLY ORPHEN ORDERS WITH FULL DETAILS>>
SELECT o.customer_id,o.order_id,c.name,o.food_item,o.amount
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id
WHERE c.name IS NULL;


-- FIND TOTAL AMOUNT SPENT PER CUSTOMER , INCLUDE UNREGISTERED CUSTOMERS ALSO >>
SELECT SUM(o.amount) AS total_spent,COALESCE(c.name,"Unregistered") AS customer_type
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.name;


-- SHOW ORDERS WHERE CUSTOMERS EXISTS VS DOES NOT EXISTS>>
SELECT o.customer_id,o.order_id, c.name,o.amount,
CASE 
WHEN c.customer_id IS NULL THEN "No Customer"
ELSE "Registerd Customer"
END AS order_type
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id;


 
 
