/* Input

TEAMNAME
-------
IND
AUS
ENG
NZL
give a query to find out how many matches can be played between teams

Output
-----
AUSvsENG
AUSvsIND
AUSvsNZL
ENGvsIND
ENGvsNZL
INDvsNZL
*/
CREATE TABLE cric (teamname VARCHAR2(10));

INSERT INTO cric VALUES('IND');
INSERT INTO cric VALUES('AUS');
INSERT INTO cric VALUES('ENG');
INSERT INTO cric VALUES('NZL');


SELECT
   a.teamname
      || 'vs'
      || b.teamname
FROM
   cric a
   JOIN
      cric b
      ON
         a.teamname > b.teamname
;
