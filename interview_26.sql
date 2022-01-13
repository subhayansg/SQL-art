City
-----------
Delhi
Noida
Mumbai
Pune
Agra
Kashmir
Kolkata

Write a SQL to get the city name with the largest and smallest length order by the city?

O/P
City Length
----------------
Kashmir 7
Agra 4


CREATE TABLE city (names VARCHAR((10));
INSERT INTO city VALUES('Delhi');
INSERT INTO city VALUES('Noida');
INSERT INTO city VALUES('Mumbai');
INSERT INTO city VALUES('Pune');
INSERT INTO city VALUES('Agra');
INSERT INTO city VALUES('Kashmir');
INSERT INTO city VALUES('Kolkata');

select names as city, len
from
(select length(names) as len, names from city)
where len IN (select max(length(names)) from city)  or len = (select min(length(names)) from city);

select names, cnt from (SELECT names,length(names) as cnt,
dense_rank()over(order by length(names),names) rk1,
dense_rank()over(order by length(names) desc,names) rk2
FROM city)
where rk1 = 1 OR rk2 = 1;