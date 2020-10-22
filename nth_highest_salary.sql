--secondhighestsalary
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