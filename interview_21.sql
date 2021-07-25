sql query to print id and sales from Table A for rows where sales of current year is greater than last year?

id,sales,year
1,20k,1991
1,21k,1992
2,30k,1992
2,20k,1993


First get the previous year and previos sales
select a.*,
             lag(year) over (partition by id order by year) as prev_year,
             lag(sales) over (partition by id order by year) as prev_sales
      from a
ID	SALES	YEAR	PREV_YEAR	PREV_SALES
1	20000	1991	 - 	 			- 
1	21000	1992	1991		20000
2	30000	1992	 - 	 			- 
2	20000	1993	1992		30000

Then we need only the previous year sales > current year sales
previous year = year -1 and sales > prev_sales

select a.*
from (select a.*,
             lag(year) over (partition by id order by year) as prev_year,
             lag(sales) over (partition by id order by year) as prev_sales
      from a
     ) a
where prev_year = year - 1 and sales > prev_sales;

ID	SALES	YEAR	PREV_YEAR	PREV_SALES
1	21000	1992	1991		20000


CREATE TABLE a(id INT, sales INT, year INT);
INSERT INTO a VALUES(1, 20000, 1991);
INSERT INTO a VALUES(1, 21000, 1992);
INSERT INTO a VALUES(2, 30000, 1992);
INSERT INTO a VALUES(2, 20000, 1993);

--===================================================== Without window functions
select
  b.id, b.sales, b.year
from a a
  join a b
    on a.id = b.id
   and a.year = b.year-1
where a.sales < b.sales
