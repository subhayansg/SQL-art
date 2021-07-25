-- Based on col1 we have to count the records where col2 having 1000 value and at the same time count all the records of the table
/*
+---------+-------+
| h.work  |  h.s  |
+---------+-------+
| w1      | 20    |
| w1      | 1000  |
| w1      | 10    |
| w1      | 0     |
| w1      | 1000  |
| w1      | 18    |
| w1      | 1000  |
+---------+-------+


WORK	SGT1000	COUNT
w1	3	7
*/

CREATE TABLE h (work VARCHAR2(2), s int);
INSERT INTO h VALUES('w1', 20);
INSERT INTO h VALUES('w1', 1000);
INSERT INTO h VALUES('w1', 10);
INSERT INTO h VALUES('w1', 0);
INSERT INTO h VALUES('w1', 1000);
INSERT INTO h VALUES('w1', 18);
INSERT INTO h VALUES('w1', 1000);



SELECT
   work
 , SUM(id) sgt1000
 , COUNT(*) count
FROM
   (
      SELECT
         work
       , CASE
            WHEN s=1000
               THEN 1
               ELSE 0
         END AS id
      FROM
         h
   )
   t
GROUP BY
   WORK
;
