CREATE TABLE employees_test (
employee_id INT PRIMARY KEY,
employee_name VARCHAR(50),
department VARCHAR(50),
salary DECIMAL(10, 2),
hire_date DATE
);

INSERT INTO employees_test (employee_id, employee_name, department, salary,
hire_date)
VALUES
(1, 'Amit',   'HR',      50000, '15-JAN-2022'),
(2, 'Neha',   'HR',      55000, '10-MAR-2023'),
(3, 'Suresh', 'HR',      48000, '20-NOV-2021'),
(4, 'Rohit',  'HR',      52000, '05-SEP-2022'),
(5, 'Raj',    'Finance', 60000, '23-JUL-2021'),
(6, 'Ravi',   'Finance', 62000, '01-SEP-2022'),
(7, 'Kiran',  'Finance', 58000, '14-FEB-2021'),
(8, 'Sunita', 'Finance', 61000, '11-JAN-2023'),
(9, 'Priya',  'IT',      70000, '02-DEC-2020'),
(10, 'Anjali','IT',      67000, '19-NOV-2021'),
(11, 'Vikas', 'IT',      69000, '20-MAY-2022');

-- find max salary for each department without Window function
SELECT department,
       Max(salary)
FROM   employees_test
GROUP  BY department;

-- find max salary for each department using Window function
SELECT department,
       salary
FROM   (SELECT department,
               Rank ()
                 over (
                   PARTITION BY department
                   ORDER BY salary DESC ) AS rnk,
               salary
        FROM   employees_test)
WHERE  rnk = 1;

-- I want top 2 employees from each department without window function (ties considered)
SELECT e1.department, e1.name, e1.salary
FROM employees_test e1
WHERE (
    SELECT COUNT(DISTINCT e2.salary)
    FROM employees_test e2
    WHERE e2.department = e1.department AND e2.salary > e1.salary
) < 2
ORDER BY e1.department, e1.salary DESC;

-- #### How does it work?

-- 1. **Main Table Alias (`e1`):**  
--    The outer query iterates over each row in `employees_test` as `e1`.

-- 2. **Correlated Subquery:**  
--    For each row in `e1`, the subquery:
--    - Looks at all rows in `employees_test` as `e2`.
--    - Filters to only those in the same department as `e1` (`e2.department = e1.department`).
--    - Further filters to only those with a higher salary than `e1` (`e2.salary > e1.salary`).
--    - Counts the number of **distinct** higher salaries in that department.

-- 3. **WHERE Clause:**  
--    The outer query keeps only those rows where the count of higher salaries is **less than 2**.  
--    - If there are 0 higher salaries, the employee has the highest salary (rank 1).
--    - If there is 1 higher salary, the employee has the second highest salary (rank 2).
--    - This logic includes ties: if two employees have the same salary, both will be included if their salary is in the top 2.

-- 4. **ORDER BY:**  
--    Results are ordered by department and salary (highest first).

-- ---

-- ### What is a Correlated Subquery?

-- A **correlated subquery** is a subquery that references columns from the outer query.  
-- - It is evaluated once for each row processed by the outer query.
-- - In this example, the subquery uses `e1.department` and `e1.salary` from the outer query.

-- **Example from the query:**
-- ```sql
-- SELECT COUNT(DISTINCT e2.salary)
-- FROM employees_test e2
-- WHERE e2.department = e1.department AND e2.salary > e1.salary
-- ```
-- - Here, `e1.department` and `e1.salary` are from the outer query, so the subquery is "correlated" to the current row of the outer query.

-- ---

-- **Summary:**  
-- - The query finds the top 2 salaries per department by counting, for each employee, how many higher salaries exist in their department.
-- - A correlated subquery is a subquery that depends on the outer query for its values and is evaluated for each row of the outer query.

-- If you want to avoid ties (i.e., only select the top 2 unique highest salaries per department, and if multiple employees have the same salary, only one is returned for that salary), you can use the following query:
SELECT e1.department, e1.name, e1.salary
FROM employees_test e1
WHERE (
    SELECT COUNT(e2.salary)
    FROM employees_test e2
    WHERE e2.department = e1.department AND e2.salary > e1.salary
) < 2
AND (
    SELECT COUNT(*)
    FROM employees_test e3
    WHERE e3.department = e1.department AND e3.salary = e1.salary AND e3.name < e1.name
) = 0
ORDER BY e1.department, e1.salary DESC;

-- Explanation:
-- The first subquery ensures only the top 2 unique salaries per department are considered.
-- The second subquery ensures that for each salary, only the first employee (by name) is picked, thus avoiding ties.

-- The order of execution for above the query:
-- FROM Clause
-- The database scans the employees_test table and assigns it the alias e1.

-- WHERE Clause (Correlated Subquery)
-- For each row in e1, the correlated subquery is executed:

-- The subquery scans employees_test as e2.
-- It filters e2 to only rows where e2.department = e1.department and e2.salary > e1.salary.
-- It counts the number of distinct higher salaries in that department.
-- If this count is less than 2, the row from e1 is included in the result.
-- SELECT Clause
-- For each row that passed the WHERE filter, the columns department, name, and salary are selected.

-- ORDER BY Clause
-- The final result set is sorted by department (ascending by default) and then by salary in descending order.

-- Order of execution of SQL statements
-- Step	Clause
-- 1	    FROM
-- 2	    WHERE
-- 3	    GROUP BY
-- 4	    HAVING
-- 5	    SELECT
-- 6	    DISTINCT
-- 7	    ORDER BY
-- 8	    LIMIT/OFFSET

-- I want top 2 employees from each department using window function
SELECT employee_name,
       department,
       salary
FROM   (SELECT employee_name, 
               department,
               Rank ()
                 over (
                   PARTITION BY department
                   ORDER BY salary DESC ) AS rnk,
               salary
        FROM   employees_test)
WHERE  rnk < 3;
