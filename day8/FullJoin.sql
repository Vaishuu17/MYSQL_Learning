USE Dominos;
SELECT * FROM customers;
SELECT * FROM orders;

-- FULL OUTER JOIN -----
SELECT c.customer_id,o.order_id,c.name,o.food_item,o.amount
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
UNION
SELECT o.customer_id,o.order_id,c.name,o.food_item,o.amount
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id;

-- FIND CUSTOMERS WHO NEVER ORDERED AND ORDERS WITHOUT CUSTOMERS >>
SELECT c.customer_id ,o.order_id,c.name,o.food_item,o.amount
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL
UNION
SELECT o.customer_id,o.order_id,c.name,o.food_item,o.amount
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id
WHERE c.customer_id IS NULL;

-- SHOW ENTITY TYPE : Customer only / Order only / Both 
SELECT COALESCE(c.customer_id,o.order_id) AS customer_id,c.name,o.food_item,
CASE
WHEN c.customer_id IS NULL THEN "Order Only"
WHEN o.order_id IS NULL THEN "Customer Only"
ELSE "Both"
END AS Record_Type
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
UNION
SELECT COALESCE(c.customer_id,o.order_id) AS customer_id,c.name,o.food_item,"Order Only"
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id
WHERE c.customer_id IS NULL;

-- CALCULATE TOTAL ORDER PER CUSTOMER AND ORPHEN ORDERS>>
SELECT COALESCE(c.customer_id,o.customer_id) AS customer_id,COALESCE(c.name,"Unregisterd") AS name,COALESCE(SUM(o.amount),"0") AS total_amount
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id,c.name
UNION
SELECT o.customer_id,"Unregistered",SUM(o.amount)
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id 
WHERE c.customer_id IS NULL
GROUP BY o.customer_id;