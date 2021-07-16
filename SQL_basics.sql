SELECT 1+null, 1-null, 1*null 
FROM dual;
-- all results in null

SELECT 'A'+1
FROM dual;
-- ORA-01722: invalid number

SELECT 'A''1'
FROM dual;
-- A'1

SELECT 'A'+'B'
FROM dual;
-- ORA-01722: invalid number

/*
A table t1 has single column id with 5 rows

ID
1
1
1
1
1

What will output of the following?
*/
SELECT SUM(1), SUM(2), SUM(3) 
FROM t1;
/*
SUM(1)	SUM(2)	SUM(3)
5		10		15
*/

-- =========================================== Understanding rownum
select rownum, first_name, salary
from hr.employees
where rownum = (Below options)
a) =1
b) = 5
c) < 5
d) > 5
What do you think is the O/P for this Query?
Ans:
a.	1 row, Output will be found
b.	No data found
c.	4 rows
d.	No data found
