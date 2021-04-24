CREATE TABLE customers_1
   (
      customer_id     INT
    , customer_number VARCHAR2(3)
    , customer_type   VARCHAR2(3)
   )
;

INSERT INTO customers_1 VALUES (101, 'A01', 'ABC');
INSERT INTO customers_1 VALUES (102, 'A02', 'ABC');
INSERT INTO customers_1 VALUES (103, 'A03', 'DEF');
INSERT INTO customers_1 VALUES (104, 'A04', 'XYZ');


CREATE TABLE contracts_1
   (
      customer_id INT
    , contract_id INT
    , status      VARCHAR2(10)
   )
;

INSERT INTO contracts_1 VALUES (102, 001, 'Active');
INSERT INTO contracts_1 VALUES (102, 002, 'Active');
INSERT INTO contracts_1 VALUES (102, 003, 'InActive');
INSERT INTO contracts_1 VALUES (103, 001, 'Active');

-- Query the customer_number with more than 1 active contracts

SELECT
   c.customer_number
FROM
   customers_1 c
   JOIN
      (
         SELECT
            customer_id
         FROM
            contracts_1
         GROUP BY
            customer_id
          , status
         HAVING
            count(status) > 1
      )
      cn
      ON
         c.customer_id = cn.customer_id