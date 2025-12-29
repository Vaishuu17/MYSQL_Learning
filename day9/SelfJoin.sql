USE Dominos;

SET autocommit = 0;


-- SELF JOIN -----
SELECT * FROM customers;

ALTER TABLE customers ADD COLUMN refered_by INT;
UPDATE  customers 
SET refered_by = 1
WHERE customer_id IN ( 2,6);

UPDATE  customers 
SET refered_by = 2
WHERE customer_id IN ( 3,5);

UPDATE  customers 
SET refered_by = 5
WHERE customer_id = 8;
UPDATE  customers 
SET refered_by = NULL
WHERE customer_id IN (6,8,9);
rollback;
commit;


SELECT c.name AS customer_name, r.name AS refered_by
FROM customers c
INNER JOIN customers r
ON c.refered_by = r.customer_id;

-- FIND CUSTOMERS WHO WERE NOT REFERED BY ANYONE >>
SELECT c.customer_id,c.name AS customer_name,r.name AS refered_by
FROM customers c
LEFT JOIN customers r
ON c.refered_by = r.customer_id
WHERE c.refered_by IS NULL;

-- FIND CUSTOMERS WHO REFERRED ATLEAST ONE OTHER CUSTOMER>>
SELECT DISTINCT r.customer_id,r.name
FROM customers c
INNER JOIN customers r
ON c.refered_by = r.customer_id;

-- COUNT HOW MANY CUSTOMERS EACH PERSON REFERRED>>
SELECT r.name AS referrer , COUNT(c.customer_id) AS total_refered
FROM customers c
INNER JOIN customers r
ON c.refered_by = r.customer_id
GROUP BY r.name;


-- SHOW CUSTOMER --> REFERRER --> REFERRER'S REFERRER
SELECT c.name AS customer ,r1.name AS refered_by , r2.name AS refered_by_of_referrer
FROM customers c
LEFT JOIN customers r1
ON c.refered_by = r1.customer_id
LEFT JOIN customers r2
ON r1.refered_by = r2.customer_id;


--  FIND CUSTOMERS WHO WERE REFERED BY RAHUL>>
SELECT c.name
FROM customers c
INNER JOIN customers r
ON c.refered_by = r.customer_id
WHERE r.name = "Rahul";
SELECT * FROM customers;

SET autocommit = 1;