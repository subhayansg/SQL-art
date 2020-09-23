-- Write a query to find the maximum salary of an employee without using 
-- MAX function
-- ROWNUM function
-- Analytical functions
-- Joins and sub-queries

--Using MAX
SELECT max(salary) FROM employees;

--Using sub-query
SELECT * FROM 
(SELECT salary
FROM employees
ORDER BY salary DESC)
WHERE rownum = 1
;

--Using Analytical function
SELECT salary 
FROM 
(SELECT salary, ROW_NUMBER() OVER(ORDER BY salary DESC) r
FROM employees)
WHERE rownum = 1;

--Using correlated queries
SELECT salary
FROM employees a
WHERE 1 = (SELECT COUNT(*) FROM employees b WHERE b.salary >= a.salary);

--Using lateral join
SELECT salary
FROM employees a, LATERAL(SELECT * FROM
(SELECT COUNT(*) c FROM employees b WHERE b.salary >= a.salary)
WHERE c = 1);

--Using ALL
SELECT salary
FROM employees 
WHERE salary > ALL(SELECT salary -1 FROM employees);