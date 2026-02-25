-- WINDOW FUNCTIONS ------

CREATE DATABASE Emp;
USE Emp;
CREATE TABLE emp(
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(20),
    salary INT,
    joining_date DATE
);

INSERT INTO emp VALUES
(1, 'Amit',   'IT',    50000, '2022-01-10'),
(2, 'Vaishnavi',   'IT',    60000, '2021-03-15'),
(3, 'Yash',  'IT',    60000, '2023-06-01'),
(4, 'Rahul',  'HR',    40000, '2021-07-20'),
(5, 'Ankit',  'HR',    45000, '2022-11-05'),
(6, 'Sneha',  'HR',    45000, '2023-02-18'),
(7, 'Karan',  'Sales', 55000, '2021-09-12'),
(8, 'Pooja',  'Sales', 52000, '2022-04-25'),
(9, 'Rohit',  'Sales', 58000, '2023-08-30'),
(10, 'Priya',  'HR',    40000, '2021-07-20');

SELECT * FROM emp;

-- 1.AGGEREGATE FUNCTIONS:
SELECT emp_id, emp_name,department, COUNT(emp_id) OVER(PARTITION BY department) AS employees
FROM emp;

-- SHOW DEPARTMENTS HAVING MORE THAN 3 EMPLPYESS
SELECT DISTINCT department 
FROM (
        SELECT department , COUNT(*) OVER(PARTITION BY department) AS dept_count
        FROM emp
)t
WHERE dept_count > 3;

-- CHECK WHERTER THERE ARE ANY DUPLICATES IN THE EMP TABLE:
SELECT emp_id, 
COUNT(emp_id) OVER(PARTITION BY emp_id) AS checkdup          -- if count=1 >> there are no duplicates  
FROM emp;


-- WHOSE EMPLOYES'S SALARY IS THE HEIGHEST?:
SELECT emp_id,emp_name,salary
FROM(
      SELECT emp_id,emp_name,salary,MAX(salary) OVER() AS Max_Salary
      FROM emp
)t
WHERE salary = Max_Salary;

-- CALCULATE DEPARTMENT-WISE TOTAL SALARY FOR EACH EMPLOYEE :
SELECT emp_id ,emp_name ,salary,
SUM(salary) OVER(PARTITION BY department) AS total_salary
FROM emp;


-- Compute running total of salary in each department based on join_date:
SELECT emp_id ,emp_name,department,salary,
SUM(salary) OVER(PARTITION BY department ORDER BY joining_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM emp;


-- Show cumulative salary expense for the company ordered by join_date:
SELECT emp_id ,emp_name,department,salary,
SUM(salary) OVER(ORDER BY joining_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_salary
FROM emp;

-- Identify at which employee the department salary crosses 1,00,000:
SELECT emp_id ,emp_name,department,joining_date, running_total
FROM (
        SELECT emp_id ,emp_name,department,joining_date,
        SUM(salary) OVER(PARTITION BY department ORDER BY joining_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
        AS running_total
        FROM emp
)t
WHERE running_total > 100000;


-- CALACULATE THE RUNNING SALARY:
SELECT emp_id,emp_name,salary,
SUM(salary) OVER(ORDER BY department ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_salary
FROM emp;


-- CALCULATE THE ROLLING SALARY :
SELECT emp_id,emp_name,salary,
SUM(salary) OVER(ORDER BY department ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS rolling_salary
FROM emp;

-- FIND THE PERCENTAGE CONTRIBUTION OF EACH EMPLOYEE'S SALARY TO THE TOTAL SALARY:
SELECT 	emp_id,emp_name,salary,
SUM(salary) OVER() AS TotalSalary,
ROUND(CAST(salary AS Float)/SUM(salary) OVER() * 100 ,2) AS PercentageOfTotal
FROM emp;

-- Show average salary of each department along with employee details:
SELECT emp_id ,emp_name, department ,salary, joining_date,
AVG(salary) OVER(PARTITION BY department) AS avg_salary
FROM emp;


-- Find employees earning more than the department average salary:
SELECT emp_id, emp_name, department, salary
FROM (SELECT emp_id ,emp_name, department ,salary,
      AVG(salary) OVER(PARTITION BY department) AS avg_salary
      FROM emp
)t
WHERE salary > avg_salary;


-- Calculate difference between employee salary and department average:
SELECT emp_id ,emp_name, department,salary, avg_salary, (salary - avg_salary) AS salary_diff
FROM (SELECT emp_id ,emp_name, department ,salary,
      AVG(salary) OVER(PARTITION BY department) AS avg_salary
      FROM emp
)t;

-- Display department-wise average salary without using GROUP BY:
SELECT emp_id, emp_name ,department, salary,
AVG(salary) OVER (PARTITION BY department) AS avg_salary
FROM emp;

-- CALCULATE THE MOVING AVERAGE OF SALARY FOR EACH DEPARTMENT OVER TIME:
SELECT emp_id,emp_name,department,salary,
AVG(salary) OVER(PARTITION BY department ORDER BY joining_date) AS moving_avg
FROM emp;


                   

 