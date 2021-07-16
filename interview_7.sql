/*
Input 
-------------
virat kohli
mohan krishna
mani shankar
venkatesh sai

Output
--------------------
VIrat Kohli
MOhan Krishna
MAni Shankar
VEnkatesh Sai

*/

CREATE TABLE cric(name VARCHAR(20));
INSERT INTO cric VALUES('virat kohli');
INSERT INTO cric VALUES('mohan krishna');
INSERT INTO cric VALUES('mani shankar');
INSERT INTO cric VALUES('venkatesh sai');

SELECT
   UPPER(SUBSTR(name, 1,2))
      ||SUBSTR(name,3) AS name
FROM
   cric
;


