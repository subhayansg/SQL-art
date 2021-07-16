CREATE TABLE d (id INT, dept VARCHAR2(2), sal INT);

INSERT INTO d VALUES(1, 'd1', 200);
INSERT INTO d VALUES(2, 'd1', 100);
INSERT INTO d VALUES(3, 'd2', 200);
INSERT INTO d VALUES(4, 'd3', 300);
INSERT INTO d VALUES(5, 'd2', 500);
INSERT INTO d VALUES(6, 'd3', 600);

/* Expected output:
id dept 	sal 	min
1	d1		200		100
2	d1		100		100
3	d2		200		200
4	d3		500		200
5	d2		300		300
6	d3		600		300
*/
SELECT
   id
 , dept
 , sal
 , MIN(sal) OVER(PARTITION BY dept) AS min
FROM
   d
ORDER BY
   id
;