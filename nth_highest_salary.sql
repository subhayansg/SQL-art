-- Normal approach
SELECT
   MAX(Salary)
FROM
   Employees
WHERE
   Salary NOT IN
   (
      SELECT
         MAX(Salary)
      FROM
         Employees
   )
;

SELECT *
FROM
   Employees
ORDER BY
   Salary DESC OFFSET 1 ROW
FETCH NEXT 1 ROW ONLY
;

SELECT
   MAX(Salary)
FROM
   Employees
WHERE
   Salary <
   (
      SELECT
         MAX(Salary)
      FROM
         Employees
   )
;

--second highest salary with CTE and DENSE RANK
WITH T AS
   (
      SELECT *
       , DENSE_RANK() OVER(ORDER BY Salary DESC) AS RNK
      FROM
         Employee
   )
SELECT
   EMPNAME
 , SAL
FROM
   T
WHERE
   RNK=2 -- Here 2 can be replaced by any number
   

--second highest salary without CTE
SELECT
   emp.SecondHighestSalary
FROM
   (
      SELECT
         Salary SecondHighestSalary
       , DENSE_RANK() OVER (ORDER BY Salary Desc) rank
      FROM
         Employee
   )
   emp
WHERE
   emp.rank = 2;
   
 
-- Using an UDF
CREATE FUNCTION getNthHighestSalary(N IN NUMBER) 
	RETURN NUMBER IS
	result NUMBER;
	BEGIN
		SELECT
			emp.SecondHighestSalary
		INTO result
		FROM
		   (
			  SELECT
				 Salary SecondHighestSalary
			   , DENSE_RANK() OVER (ORDER BY Salary Desc) rank
			  FROM
				 Employee
		   )
		   emp
		WHERE
		   emp.rank = N
		   GROUP BY emp.SecondHighestSalary;
		RETURN result;
	END;
