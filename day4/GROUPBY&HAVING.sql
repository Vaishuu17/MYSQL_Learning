USE startsql;
SELECT * FROM addresses;
SELECT * FROM users;
SELECT COUNT(id), city FROM addresses
GROUP BY city;

SELECT id, city FROM addresses                   -- ERROR : Bcoz same cities have different ids. 
GROUP BY city;

SELECT COUNT(id), city FROM addresses
GROUP BY city
HAVING city = "Delhi";

SELECT gender , AVG(salary) FROM users
GROUP BY gender; 

SELECT gender , AVG(salary) FROM users
GROUP BY gender
HAVING AVG(salary) > 64000;