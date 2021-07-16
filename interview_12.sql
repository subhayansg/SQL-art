-- Print EVEN ODD
/* I/p - 

Number 
1
2
3
4
5
.
.
100
*/

/*
o/p - 

odd even
1      2
3      4
5      6
.        .
.        .
99    100
*/

CREATE TABLE t1 (num INT);

INSERT INTO t1 VALUES(1);
INSERT INTO t1 VALUES(2);
INSERT INTO t1 VALUES(3);
INSERT INTO t1 VALUES(4);
INSERT INTO t1 VALUES(5);
INSERT INTO t1 VALUES(6);
INSERT INTO t1 VALUES(7);
INSERT INTO t1 VALUES(8);
INSERT INTO t1 VALUES(9);
INSERT INTO t1 VALUES(10);


SELECT
   od.num AS ODD
 , (
      SELECT
         num
      FROM
         t1
      WHERE
         num = od.num + 1
   )
   AS EVEN
FROM
   t1 od
WHERE
   MOD(od.num, 2) <> 0