/* Input
ID	INVOICE	DEBT_AGE	BALANCE
10	1a		60			80
10	1b		30			80
10	1c		10			80
20	1d		90			60
20	1e		40			60
20	1f		20			50
*/

/* Output
ID	INVOICE	DEBT_AGE	BALANCE
10	1a		60			240
20	1d		90			170
*/

CREATE TABLE t1 (id INT, invoice VARCHAR2(2), debt_age INT, balance INT);

INSERT INTO t1 VALUES(10, '1a', 60, 80);
INSERT INTO t1 VALUES(10, '1b', 30, 80);
INSERT INTO t1 VALUES(10, '1c', 10, 80);
INSERT INTO t1 VALUES(20, '1d', 90, 60);
INSERT INTO t1 VALUES(20, '1e', 40, 60);
INSERT INTO t1 VALUES(20, '1f', 20, 50);


SELECT
   id
 , invoice
 , debt_age
 , balance
FROM
   (
      SELECT
         id
       , invoice
       , debt_age
       , SUM(balance) OVER (PARTITION BY id)        AS balance
       , ROW_NUMBER() OVER (PARTITION BY id ORDER BY debt_age DESC) AS rn
      FROM
         t1
   )
WHERE
   rn =1
;