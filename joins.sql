CREATE TABLE t1(id INT);
INSERT INTO t1 VALUES(10);
INSERT INTO t1 VALUES(20);
INSERT INTO t1 VALUES(30);
INSERT INTO t1 VALUES(40);
INSERT INTO t1 VALUES(50);

CREATE TABLE t2(id INT);
INSERT INTO t2 VALUES(10);
INSERT INTO t2 VALUES(20);
INSERT INTO t2 VALUES(70);
INSERT INTO t2 VALUES(80);
INSERT INTO t2 VALUES(90);


-- CROSS JOIN
SELECT *
FROM
   t1
   CROSS JOIN
      t2
;
-- Number of rows: 		5*5 = 25
-- Number of columns:	2 (1 from each table)


-- LEFT OUTER JOIN (t1 LEFT OUTER JOIN t2)
SELECT *
FROM
   t1
   LEFT OUTER JOIN -- LEFT JOIN, both means the same
      t2
      ON
         t1.id = t2.id
;
/* Output
ID	ID
-------
10	10
20	20
50	 - 
40	 - 
30	 -
*/

-- LEFT OUTER JOIN (t2 LEFT OUTER JOIN t1)
SELECT *
FROM
   t2
   LEFT OUTER JOIN
      t1
      ON
         t1.id = t2.id
;
/* Output
ID	ID
-------
10	10
20	20
70	 - 
90	 - 
80	 - 
*/

-- RIGHT OUTER JOIN (t1 RIGHT OUTER JOIN t2)
SELECT *
FROM
   t1
   RIGHT OUTER JOIN -- RIGHT JOIN,  both means the same
      t2
      ON
         t1.id = t2.id
;
/* Output
ID	ID
-------
10	10
20	20
 - 	70
 - 	90
 - 	80
*/

-- RIGHT OUTER JOIN (t2 RIGHT OUTER JOIN t1)
SELECT *
FROM
   t2
   RIGHT OUTER JOIN
      t1
      ON
         t1.id = t2.id
;
/* Output
ID	ID
-------
10	10
20	20
 - 	50
 - 	40
 - 	30
*/

-- Equi join
SELECT *
FROM
   t2
   JOIN
      t1
      ON
         t1.id = t2.id
;
/* Output
ID	ID
-------
10	10
20	20
*/

-- Non-equi join
SELECT *
FROM
   t2
   JOIN
      t1
      ON
         t1.id <> t2.id
;
-- Number of rows: 		23, 25 rows by CROSS JOIN - 2 records for which id values matched in t1 and t2
-- Number of columns:	2 (1 from each table)
-- So this is same as doing:
SELECT *
FROM
   t1
   CROSS JOIN
      t2
WHERE
   t1.id <> t2.id
;



-----------------
/*
TableA     TableB
ID               ID
1                 1
1                 1 
1                 2
2                 2
3                 4
Null            Null
                   Null 


Numbers of rows as output when I put. 
1. Inner Join 
2. Left Join
3. Right Join
4. Cross Join
5. Full Outer Join
6. Cross Apply
*/
---------------------

---------------------
Say we have table1 with only one column A, it has 10 rows, all the values are 1.

And we have another table2, with column A, it has 5 rows, all are values 1.

What would be the number for rows in the table after we apply the following joins.

1. Inner Join
2. Right Join
3. Left Join
4. Cross Join

CREATE TABLE t1(a INT);
CREATE TABLE t2(a INT);

INSERT INTO t1 VALUES(1);
INSERT INTO t1 VALUES(1);
INSERT INTO t1 VALUES(1);
INSERT INTO t1 VALUES(1);
INSERT INTO t1 VALUES(1);
INSERT INTO t1 VALUES(1);
INSERT INTO t1 VALUES(1);
INSERT INTO t1 VALUES(1);
INSERT INTO t1 VALUES(1);
INSERT INTO t1 VALUES(1);


INSERT INTO t2 VALUES(1);
INSERT INTO t2 VALUES(1);
INSERT INTO t2 VALUES(1);
INSERT INTO t2 VALUES(1);
INSERT INTO t2 VALUES(1);
1. 50
2. 50
3. 50
4. 50