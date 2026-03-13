--  VALUE FUNCTIONS :

-- 1. LEAD(): NEXT ROW VALUE 
-- Show each employee’s salary along with the next employee’s salary in the same department.>>
SELECT *,
LEAD(salary) OVER(PARTITION BY department ORDER BY salary) nxt_emp_slry
FROM emp;

-- Find employees whose salary is higher than the next joiner in their department.>>
SELECT *
FROM(
	SELECT *,
    LEAD(salary) OVER(PARTITION BY department ORDER BY joining_date) next_salary 
    FROM emp
)t
WHERE salary > next_salary ;

-- Calculate salary difference between current employee and next hire. >>
SELECT *, salary AS  current_emp_slry,
salary  - next_emp_salary AS slry_diff
FROM(
	SELECT *,
    LEAD(salary) OVER(PARTITION BY department ORDER BY joining_date) next_emp_salary 
    FROM emp
)t;

-- Predict promotion gap: find employees whose next hire earns less than them.
SELECT *, 
salary  - next_emp_salary AS promotion_gap
FROM(
	SELECT *,
    LEAD(salary) OVER(PARTITION BY department ORDER BY joining_date) next_emp_salary 
    FROM emp
)t
WHERE salary > next_emp_salary;

-- 2.LAG() : PREVIOUS ROW VALUE 
-- Find employees whose salary is higher than the previous employee in the same department (by joining date).
SELECT * 
FROM(
SELECT *,
LAG(salary) OVER (PARTITION BY department ORDER BY joining_date) previous_slry
FROM emp
)t
WHERE salary > previous_slry;

-- Show salary difference between an employee and the person who joined just before them in the department.>>
SELECT *,
salary - previous_slry AS slry_diff
FROM(
SELECT *,
LAG(salary,1,0) OVER (PARTITION BY department ORDER BY joining_date) previous_slry
FROM emp
)t;

-- Identify employees whose salary increased compared to the previous hire in their department.>>
SELECT *
FROM(
SELECT *,
LAG(salary) OVER (PARTITION BY department ORDER BY joining_date) previous_slry
FROM emp
)t
WHERE salary > previous_slry; 

-- Find salary jump percentage compared to previous joiner.>>
SELECT *,
CONCAT(ROUND((salary-previous_slry)/previous_slry * 100,2),"%") AS jump_percentage 
FROM(
SELECT *,
LAG(salary) OVER (PARTITION BY department ORDER BY joining_date) previous_slry
FROM emp
)t
WHERE previous_slry IS NOT NULL;

-- Detect sudden salary spikes (difference > 2000 compared to previous hire).
SELECT
    emp_id,
    emp_name,
    department,
    salary,
    joining_date,
    prev_salary,
    salary - prev_salary AS salary_diff
FROM (
    SELECT *,
           LAG(salary) OVER (
               PARTITION BY department
               ORDER BY joining_date
           ) AS prev_salary
    FROM emp
) t
WHERE prev_salary IS NOT NULL
  AND salary - prev_salary > 2000;


-- 3. FIRST_VALUE() >>
-- SHOW EACH EMPLOYEE'S SALARY ALONG WITH THE HIGHEST SALARY IN THEIR DEPARTMENT >>>
SELECT emp_id ,emp_name,department,salary,
FIRST_VALUE(salary) OVER(PARTITION BY department ORDER BY salary DESC) Heighest_salary
FROM emp;

-- COMPARE EACH EMP SALARY WITH THE FIRST HIRED EMPLOYEE IN THEIR DEPARTMENT >> 
SELECT emp_id ,emp_name,department,salary,joining_date,
FIRST_VALUE(salary) OVER(PARTITION BY department ORDER BY joining_date) first_emp_slry,
salary - FIRST_VALUE(salary) OVER(PARTITION BY department ORDER BY joining_date) slry_difference
FROM emp;

-- FIND SALARY DIFFERENCE FROM DEPARTMENT TOP EARNER >>
SELECT emp_id ,emp_name,department,salary,joining_date,
FIRST_VALUE(salary) OVER(PARTITION BY department ORDER BY salary DESC) Top_earner,
FIRST_VALUE(salary) OVER(PARTITION BY department ORDER BY salary DESC) - salary AS slry_difference  
FROM emp;

-- FIND EMPLOYEES EARNING LESS THAN 50% OF DEPARTMENT'S HEIGHEST SALARY >>
SELECT emp_id ,emp_name,department,salary
FROM(
      SELECT *,
      FIRST_VALUE(salary) OVER(PARTITION BY department ORDER BY salary DESC) max_dept_slry
      FROM emp
)t
WHERE salary < 0.5 * max_dept_slry;


-- 4. LAST_VALUE :
-- SHOW EACH EMP WITH THE LOWEST SALARY IN THEIR DEPARTMENT >>
SELECT  * ,
LAST_VALUE(salary) OVER(PARTITION BY department ORDER BY salary DESC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING ) lowest_salary
FROM emp;

-- COMPARE EMP SALARY WITH MOST RECENTLY HIERED EMP >>
SELECT *,
FIRST_VALUE(salary) OVER(PARTITION BY department ORDER BY joining_date DESC) recently_joiner_slry,
FIRST_VALUE(salary) OVER(PARTITION BY department ORDER BY joining_date DESC) - salary AS salary_diff
FROM emp;

-- FIND EMPLOYEES  WHOSE SALARY IS LOWER THAN THE LAST HIRED EMP IN THEIR DEP 
SELECT * 
FROM (
       SELECT *,
       LAST_VALUE(salary) OVER(PARTITION BY department ORDER BY joining_date) last_hired_slry
       FROM emp
)t
WHERE salary < last_hired_slry;

-- 5. NTH_VALUE() :
-- SHOW THE 2nd HEIGHEST SALARY IN EACH DEPARTMENT ALONGSIDE ALL EMPLOYEES >>
SELECT * ,
NTH_VALUE(salary,2) OVER(PARTITION BY department ORDER BY salary ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) 2nd_heighest_salary
FROM emp; 

-- RETURN EMPLOYEES EARNING MORE THAN THE 3RD HIGHEST SALARY IN THEIR DEPARTMENT >>
SELECT * 
FROM ( 
      SELECT *,
      NTH_VALUE(salary,3) OVER(PARTITION BY department ORDER BY salary) 3rd_heighest_slry
      FROM emp
)t
WHERE salary > 3rd_heighest_slry;

-- RETURN EMPLOYEES WHOSE SALARY IS EQUAL TO 2ND HIRED EMPLOYEE'S SALARY >>
 SELECT * 
 FROM (
        SELECT * ,
        NTH_VALUE(salary,2) OVER(PARTITION BY department ORDER BY joining_date DESC) 2nd_hiredemp_slry
        FROM emp
)t
WHERE salary =  2nd_hiredemp_slry;      
