CREATE TABLE account_1 (account_number NUMBER, transaction_time date, transaction_id NUMBER, amount number);

INSERT INTO account_1 VALUES(123, TO_DATE('01/01/2019 08:00:00', 'dd/mm/yyyy hh24:mi:ss'), 101, 1000);
INSERT INTO account_1 VALUES(123, TO_DATE('01/02/2019 08:00:00', 'dd/mm/yyyy hh24:mi:ss'), 102, 2000);
INSERT INTO account_1 VALUES(123, TO_DATE('01/03/2019 08:00:00', 'dd/mm/yyyy hh24:mi:ss'), 103, 3000);
INSERT INTO account_1 VALUES(789, TO_DATE('01/04/2019 08:00:00', 'dd/mm/yyyy hh24:mi:ss'), 104, 1000);
INSERT INTO account_1 VALUES(789, TO_DATE('01/05/2019 08:00:00', 'dd/mm/yyyy hh24:mi:ss'), 105, 500);
INSERT INTO account_1 VALUES(123, TO_DATE('01/06/2019 08:00:00', 'dd/mm/yyyy hh24:mi:ss'), 106, 4000);

-- Find the latest transaction_id and amount for each account_number
SELECT
   account_number
 , transaction_id
 , amount
FROM
   (
      SELECT
         account_number
       , transaction_id
       , amount
       , DENSE_RANK() over(PARTITION BY account_number ORDER BY
                           transaction_time DESC) AS rank
      FROM
         account_1
   )
WHERE
   rank = 1
;
