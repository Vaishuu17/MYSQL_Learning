-- ----RANK FUNCTIONS -------- 
SELECT * FROM emp;

-- 1. ROW_NUMBER() :
SELECT * ,ROW_NUMBER() OVER() AS row_no
FROM emp;

-- ASSIGN A UNIQUE REOW NO TO EMPLOYEES ORDER BY SALARY (HIGHEST FIRST) >>
SELECT * ,ROW_NUMBER() OVER(ORDER BY salary DESC) heighest_salary
FROM emp;

-- FIND THE HEIGHEST PAID EMP IN EACH DEPARTMENT >>
SELECT * 
FROM(
      SELECT * ,ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) heighest_salary_byDpt
      FROM emp
)t
WHERE heighest_salary_byDpt = 1;

-- FIND THE 2nd HEIGHEST BY EMP DROM EACH DEPARTMENT >>
SELECT * 
FROM(
      SELECT * ,ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) heighest_salary_byDpt
      FROM emp
)t
WHERE heighest_salary_byDpt = 2;

-- IDENTFY DUPLICATE SALARY RECORDS WITHIN EACH DEPARTMENT >>
 SELECT *
 FROM(
      SELECT * , ROW_NUMBER() OVER(PARTITION BY department,salary ORDER BY salary DESC) dup_record
      FROM emp
 )t
 WHERE dup_record > 1;
 
 -- DELETE DUPLICATE EMPLOYEES KEEPING THE EARLIEST JOINING DATE RECORD >>
-- DELETE FROM emp
-- WHERE emp_id IN(
-- 	  SELECT emp_id FROM(
--                         SELECT * ,emp_id, ROW_NUMBER() OVER(PARTITION BY department,salary ORDER BY joining_date ASC) dup_record
-- 				        FROM emp
-- )t
-- WHERE dup_record > 1
-- ); 

-- FIND 2  LOWEST SALARY EMP>>
SELECT * 
FROM (
      SELECT * , ROW_NUMBER() OVER(PARTITION BY salary ORDER BY salary) lowest_salary
      FROM emp
)t
WHERE lowest_salary > 1 
LIMIT 2;


-- 2. RANK() :
-- RANK EMP BY SALARY >>
SELECT *, RANK() OVER (ORDER BY salary DESC) rank_salary
FROM emp;   

-- FIND THE TOP 2 SALARY RANKS IN EACH DEPARTMENT >>
SELECT * 
FROM( 
    SELECT *, RANK() OVER (PARTITION BY department ORDER BY salary DESC) rank_salary
    FROM emp
)t 
WHERE rank_Salary <=2 ;   
 
-- LIST EMPLOYEES WHOSE SALARY RANK IS <=3 COMPANY-WIDE >>
SELECT * 
FROM( 
    SELECT *, RANK() OVER (PARTITION BY department ORDER BY salary DESC) rank_salary
    FROM emp
)t 
WHERE rank_Salary <=3 ;

-- COMPARE SALARY RANKING WITHIN DEPARTMENT VS OVERALL COMPANY RANKING >>
SELECT * , 
RANK() OVER (PARTITION BY department ORDER BY salary DESC) dept_rank,
RANK() OVER (ORDER BY salary DESC) overall_rank
FROM emp;

-- FIND DEPARTMENTS WHERE MULTIPLE EMPLOYEES SHARE RANK 1 >>
SELECT * 
FROM(
     SELECT * ,RANK() OVER (PARTITION BY department ORDER BY salary DESC) rnk
     FROM emp
)t
WHERE rnk = 1;


-- 3. DENSE_RANK() :
-- ASSIGN DENSE RANK COMPANY_WIDE >>
SELECT * , DENSE_RANK() OVER (ORDER BY salary DESC) dense_rnk
FROM emp; 

-- FIND THE EMPLOYEES HAVING THE 2ND HEIGHEST DISTINCT SALARY >>
SELECT * 
FROM (
       SELECT * , DENSE_RANK() OVER (ORDER BY salary DESC) dense_rnk
       FROM emp
)t
WHERE dense_rnk = 2;

-- GET TOP 3 DISTINCT SALARY GROUPS IN EACH DEPARTMENT >>
SELECT *
FROM(
     SELECT * , DENSE_RANK() OVER(PARTITION BY department ORDER BY salary DESC) distinct_slry
     FROM emp
)t
WHERE distinct_slry <=3;

-- SHOW SALARY BAND POSITION (1ST BAND,2ND BAND ,ETC) WITHIN DEPARTMENT>>
SELECT * , DENSE_RANK() OVER(PARTITION BY department ORDER BY salary DESC) salary_band
FROM emp;

-- COMPARE RANK VS DENSE RANK RESUKTS ON THIS DATASET >>
SELECT * ,
RANK() OVER (ORDER BY salary DESC) rnk,
DENSE_RANK() OVER(ORDER BY salary DESC) dense_rnk
FROM emp;


-- 4. NTILE():
-- DIVIDE EMPLOYEES INTO 4 SALARY QUARTILES >>
SELECT * , NTILE(4) OVER(ORDER BY salary) slry_quart
FROM emp;

-- SPLIT THE EMPLOYEES INTO 3 PERFORMANCE BUCKETS BASED ON SALARY>>
SELECT *,
CASE WHEN Bucket = 1 THEN "Best"
     WHEN Bucket = 2 THEN "Better"
     WHEN Bucket = 3 THEN "Good"
END AS Emp_performance
FROM( 
SELECT *, NTILE(3) OVER(ORDER BY salary DESC) Bucket
FROM emp
)t;

-- DISTRIBUTE EMPLOYEES EVENLY INTO 2 GROUPS WITHIN EACH DEPARTMENT >>
SELECT * , 
NTILE(2) OVER (PARTITION BY department ORDER BY salary DESC) dep_groups
FROM emp;

-- COMPARE QUARTILE DISTRIBUTION BETWEEN DEPARTMENTS >>
SELECT department,quartile,COUNT(*) AS dep_count
FROM(
     SELECT department, NTILE(4) OVER(PARTITION BY department ORDER BY salary) quartile
     FROM emp
)t
GROUP BY department,quartile
ORDER BY department,quartile;


-- 5. CUM_DIST() :
-- FIND EMPLOYEES WHOSE SALARY IS IN TOP 30% OF THE COMPANY >>
SELECT emp_id ,emp_name,department,salary,slry_rnk,
CONCAT(slry_rnk * 100,"%") slry_rnk_percent
FROM(   
      SELECT emp_id ,emp_name,department,salary,
      CUME_DIST() OVER(ORDER BY salary DESC) slry_rnk
      FROM emp
)t
WHERE slry_rnk <= 0.3;

-- SHOW CUMULATIVE SALARY DISTRIBUTION WITHIN EACH DEPARTMENT >>
SELECT *, CUME_DIST() OVER(PARTITION BY department ORDER BY salary) slry_dist
FROM emp;

-- FIND EMPLOYEES EARNING MORE THAN 70% OF THEIR DEPARTMENT >>
SELECT emp_id ,emp_name,department,salary,slry_rnk,
CONCAT(slry_rnk * 100,"%") slry_rnk_percent
FROM(   
      SELECT emp_id ,emp_name,department,salary,
      CUME_DIST() OVER(PARTITION BY department ORDER BY salary DESC) slry_rnk
      FROM emp
)t
WHERE slry_rnk > 0.7;

-- FIND MEDIUM SALARY GROUPS USING CUMULATIVE DISTRIBUTION >>
SELECT emp_id ,emp_name,department,salary,medium_slry
FROM(   
      SELECT emp_id ,emp_name,department,salary,
      CUME_DIST() OVER(PARTITION BY department ORDER BY salary DESC) medium_slry
      FROM emp
)t
WHERE medium_slry = 0.5;

-- RETURN EMPLOYEES WHOSE SALARY IS ABOVE 80% OF THE COMANIES SALARIES  BUT BELLOW DEPARTMENT TOP 10%>>
SELECT *
FROM(
      SELECT *,
      CUME_DIST() OVER (ORDER BY salary ) company_slry,
      CUME_DIST() OVER (PARTITION BY department ORDER BY salary DESC) dept_slry 
      FROM  emp
)t
WHERE company_slry > 0.8 AND dept_slry > 0.1;


-- 6. PERCENT_RANK :
-- CALACULATE THE SALARY PERCENTILE RANK OF EACH EMP IN THE COMPANY >>
 SELECT * , PERCENT_RANK() OVER(ORDER BY salary) per_rnk
 FROM emp;

-- FIND THE EMPLOYEES WHOSE SLARY PERCENTIE IS BETWEEN 0.4 AND 0.6 >>
SELECT * 
FROM(
     SELECT * , PERCENT_RANK() OVER(ORDER BY salary) per_rnk
     FROM emp
)t
WHERE per_rnk > 0.4 AND per_rnk < 0.6;

-- COMPARE EMPLOYEES DEPARTMENT PERCENTILE VS COMPANY PERCENTILE >>
SELECT *,
PERCENT_RANK() OVER(PARTITION BY department ORDER BY salary DESC) dept_per,
PERCENT_RANK() OVER(ORDER BY salary DESC) company_per
FROM emp; 

-- FIND THE EMPLOYEES IN THE BOTTOM 20% SALARY GROUP >>
SELECT *
FROM(
     SELECT *, PERCENT_RANK() OVER (ORDER BY salary ASC) per_rnk
     FROM emp
)t
WHERE per_rnk <= 0.2;     

-- FIND EMPLOYEES WHOSE DEPERTMENT PERCENTILE RANK IS HEIGHER THAN THEIR COMPANY PERCENTILE RANK >>
SELECT * 
FROM(
SELECT *,
PERCENT_RANK() OVER(PARTITION BY department ORDER BY salary DESC) dept_per,
PERCENT_RANK() OVER(ORDER BY salary DESC) company_per
FROM emp
)t
WHERE dept_per > company_per; 




 