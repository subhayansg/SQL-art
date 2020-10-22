CREATE TABLE order_1 (order_id NUMBER, customer_name VARCHAR2(10), year NUMBER);

INSERT INTO order_1 VALUES(12, 'Sohan', 2017);
INSERT INTO order_1 VALUES(34, 'Thiru', 2017);
INSERT INTO order_1 VALUES(45, 'Sohan', 2017);
INSERT INTO order_1 VALUES(79, 'Sohan', 2017);
INSERT INTO order_1 VALUES(76, 'Poonam', 2018);
INSERT INTO order_1 VALUES(77, 'Poonam', 2018);
INSERT INTO order_1 VALUES(98, 'Poonam', 2018);
INSERT INTO order_1 VALUES(101, 'Poonam', 2017);
INSERT INTO order_1 VALUES(103, 'Poonam', 2018);
INSERT INTO order_1 VALUES(109, 'Poonam', 2018);
INSERT INTO order_1 VALUES(83, 'Thiru', 2017);
INSERT INTO order_1 VALUES(19, 'Thiru', 2017);

-- Find number of customers who have ordered > 3 in 2017 and > 2 in 2018
SELECT
   a.year
 , COUNT(a.no_of_orders) order_per_year
FROM
   (
      SELECT
         customer_name
       , year
       , COUNT(order_id) no_of_orders
      FROM
         order_1
      GROUP BY
         customer_name
       , year
   )
   a
WHERE
   (
      a.year             = 2018
      AND a.no_of_orders > 3
   )
   or
   (
      a.year             = 2017
      AND a.no_of_orders > 2
   )
GROUP BY
   a.year
;