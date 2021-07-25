-- Find min 3 consecutive record where people strength is greater than 100
CREATE TABLE people (id INT, "date" DATE, num_people INT);

INSERT INTO people VALUES(1, '01/SEP/2020', 101);
INSERT INTO people VALUES(2, '02/SEP/2020', 102);
INSERT INTO people VALUES(3, '03/SEP/2020', 97);
INSERT INTO people VALUES(4, '04/SEP/2020', 153);
INSERT INTO people VALUES(5, '05/SEP/2020', 164);
INSERT INTO people VALUES(6, '06/SEP/2020', 187);
INSERT INTO people VALUES(7, '07/SEP/2020', 86);
INSERT INTO people VALUES(8, '08/SEP/2020', 197);
INSERT INTO people VALUES(9, '09/SEP/2020', 54);
INSERT INTO people VALUES(10, '10/SEP/2020', 105);


SELECT
   id
 , "date"
 , num_people
FROM
   people 
   MATCH_RECOGNIZE ( ALL ROWS PER MATCH 
					 PATTERN(a{3, }) 
					 DEFINE a AS num_people > 100 
				   )
;