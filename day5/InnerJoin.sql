SELECT * FROM customers;
SELECT * FROM orders;

-- INNER JOIN----
SELECT customers.customer_id,customers.name,orders.food_item,orders.amount
FROM customers
INNER JOIN orders
ON customers.customer_id = orders.customer_id;

-- SHOW ONLY CUSTOMERS WHO HAVE PLACED ORDERS>>
SELECT DISTINCT c.name
FROM customers c
INNER JOIN orders o 
ON c.customer_id = o.customer_id; 

-- SHOW CUSTOMER NAME AND TOTAL AMOUNT SPENT>>
SELECT c.name,SUM(o.amount) AS total_spent
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.name; 

-- SHOW CUSTOMER NAME & NUMBER OF ORDER PLACED >>
SELECT  c.name,COUNT(o.order_id) AS total_orders
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.name; 

-- SHOW CUSTOMERS WHO ORDERED MORE THAN ONE ITEMS>> 
SELECT  c.name
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.name
HAVING COUNT(o.order_id) > 1; 

-- SHOW FOOD ITEMS ORDERED BY CUSTOMERS FROM DELHI >>
SELECT c.name,o.food_item,c.city
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
WHERE c.city = "Mumbai";

-- SHOW CUSTOMER NAME & HEIGHEST ORDER AMOUNT >>
SELECT c.name, MAX(o.amount) AS heighest_amt
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.name
LIMIT 1;

-- SHOW CUSTOMERS WHOSE ORDER AMOUNT IS GREATER THAN 200>>
SELECT c.name,o.food_item,o.amount
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.amount > "200";
 


