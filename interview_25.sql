emp-id   salary

   1             1,00,000
   1             60,000
   2            50,000
   3            40,000
   3           30,000
   2            35,000  

For every emp id find second highest salary

CREATE TABLE emp(emp_id INT, salary INT);
INSERT INTO emp VALUES(1, 100000);
INSERT INTO emp VALUES(1, 60000);
INSERT INTO emp VALUES(2, 50000);
INSERT INTO emp VALUES(3, 40000);
INSERT INTO emp VALUES(3, 30000);
INSERT INTO emp VALUES(2, 35000);


SELECT
   emp_id
 , salary
FROM
   (
      SELECT
         emp_id
       , salary
       , DENSE_RANK() OVER(PARTITION BY emp_id ORDER BY
                           salary DESC) rnk
      FROM
         emp
   )
WHERE
   rnk = 2
;
