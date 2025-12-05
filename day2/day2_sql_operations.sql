-- UPDATE DATA:
UPDATE customers
SET name = "alicia" 
WHERE id = 1;
SELECT * FROM customers;

UPDATE customers
SET name = "robert",email = "robert@gmail.com" 
WHERE id = 63;

UPDATE customers
SET date_of_birth = "1990-08-30"
WHERE email = "lily4@gmail.com";

UPDATE customers
SET salary = 100000
WHERE id = 3;

UPDATE customers
SET salary = salary + 10000
WHERE salary < 60000;

UPDATE customers
SET id = 6
WHERE id = 47;

-- DELETE DATA :
DELETE FROM customers
WHERE  id = 60; 
SELECT * FROM customers;

DELETE FROM customers
WHERE salary<50000;

DELETE FROM customers;            -- DELETE ALL ROWS BUT KEEP THE TABLE STRUCTURE 

DROP TABLE customers;              -- DELETE THE ENTIRE TABLE


SELECT * FROM users; 
-- CONSTRAINTS ---
ALTER TABLE users
ADD CONSTRAINT uniq_email UNIQUE (email); 

ALTER TABLE users
MODIFY COLUMN name VARCHAR(100) NOT NULL;

ALTER TABLE users
MODIFY COLUMN date_of_birth DATE NULL;

ALTER TABLE users
ADD COLUMN is_active BOOLEAN DEFAULT TRUE;


-- SQL FUNCTIONS ----
-- 1. AGGREGATE FUNCTIONS:
 SELECT COUNT(*) FROM users;
 SELECT COUNT(*) AS total FROM users;
 
 SELECT  MIN(salary) AS min_salary , MAX(salary) AS  max_salary FROM users;
 
SELECT  SUM(salary) AS Total FROM users;

SELECT  AVG(salary) AS avg_Salary FROM users;

SELECT  gender,SUM(salary) AS Total FROM users GROUP BY gender;

-- 2. STRING/TEXT FUNCTIONS:
SELECT  LENGTH(name) AS name_len FROM users; 
SELECT id,  LENGTH(name) AS name_len FROM users; 

SELECT  UPPER(name) AS uppercase, LOWER(name) AS lowercase FROM users;

SELECT  CONCAT(name,"123") AS username FROM users;
SELECT  CONCAT(name,"<",email,">") AS user_contact FROM users;
 
 -- 3. DATE & TIME FUNCTIONS:
 SELECT NOW();
 SELECT YEAR(NOW());
 SELECT MONTH(NOW());
 SELECT DAY(NOW());
 
 SELECT  DAY(date_of_birth) AS day FROM users; 
 SELECT  date_of_birth, DAY(date_of_birth) AS day FROM users; 

SELECT  date_of_birth, MONTH(date_of_birth) AS month FROM users; 

SELECT  date_of_birth, YEAR(date_of_birth) AS year FROM users;
 
SELECT  name, DATEDIFF(CURDATE(),date_of_birth) AS days FROM users; 

SELECT  name, date_of_birth,TIMESTAMPDIFF(YEAR,date_of_birth,CURDATE()) AS Age FROM users; 

-- 4. MATHEMATICAL FUNCTIONS:
SELECT salary,
ROUND(salary) AS ROUND,
FLOOR(salary) AS FLOOR,
CEIL(salary) AS CEIL
FROM users;

SELECT id, MOD(id,2) AS remainder FROM users;

-- 5. CONDITIONAL FUNCTIONS:
SELECT name, gender, IF(gender = "female" , "yes","no") AS is_female FROM users;
SELECT name , salary, IF (salary>50000 ,"heigh","low") AS salary_level FROM users;

SELECT name, salary ,CASE 
WHEN salary>=70000 THEN "heigh"
WHEN salary>=45000 AND salary<=69000 THEN "average"
WHEN salary>=20000 AND salary<=44000 THEN "low"
ELSE "poor"
END AS status 
FROM users;


