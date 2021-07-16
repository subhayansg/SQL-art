/* Input
ID
1
2
3
4
5
6
7
8
9
10
*/

/* Output
ID	ID2
1	10
2	9
3	8
4	7
5	6
*/
CREATE TABLE t1(id INT);
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


WITH cte AS
   (
      SELECT
         COUNT(*) AS cnt
      FROM
         t1
   )
SELECT
   id
 , (
   (
      SELECT
         cnt
      FROM
         cte
   )
   +1-id)
FROM
   t1
WHERE
   id < (
   (
      SELECT
         cnt
      FROM
         cte
   )
   +1-id)
;