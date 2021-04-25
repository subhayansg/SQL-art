-- Window functions are functions that perform calculations across a set of rows related to the current row.
-- It is comparable to the type of calculation done with an aggregate function, but unlike regular aggregate functions,
-- window functions do not group several rows into a single output row — the rows retain their own identities.


-- =========================================== Aggregate Window Functions SUM(), MAX(), MIN(), AVG(), COUNT()

-- prepare the table and data
CREATE TABLE orders_24042021
(
	order_id INT,
	order_date DATE,
	customer_name VARCHAR2(250),
	city VARCHAR2(100),	
	order_amount INT
);
 
INSERT INTO orders_24042021 VALUES ('1001','01-APR-2017','David Smith','GuildFord',10000);
INSERT INTO orders_24042021 VALUES ('1002','02-APR-2017','David Jones','Arlington',20000);
INSERT INTO orders_24042021 VALUES ('1003','03-APR-2017','John Smith','Shalford',5000);
INSERT INTO orders_24042021 VALUES ('1004','04-APR-2017','Michael Smith','GuildFord',15000);
INSERT INTO orders_24042021 VALUES ('1005','05-APR-2017','David Williams','Shalford',7000);
INSERT INTO orders_24042021 VALUES ('1006','06-APR-2017','Paum Smith','GuildFord',25000);
INSERT INTO orders_24042021 VALUES ('1007','10-APR-2017','Andrew Smith','Arlington',15000);
INSERT INTO orders_24042021 VALUES ('1008','11-APR-2017','David Brown','Arlington',2000);
INSERT INTO orders_24042021 VALUES ('1009','20-APR-2017','Robert Smith','Shalford',1000);
INSERT INTO orders_24042021 VALUES ('1010','25-APR-2017','Peter Smith','GuildFord',500);




-- =================== SUM()

SELECT
   city
 , SUM(order_amount) total_order_amount
FROM
   orders_24042021
GROUP BY
   city;
-- It sums the order amount for each city.
-- You can see from the result set that a regular aggregate function groups multiple rows into a single output row, which causes individual rows to lose their identity.

-- This does not happen with window aggregate functions.
-- Rows retain their identity and also show an aggregated value for each row. 
-- In the example below the query does the same thing, namely it aggregates the data for each city and shows the sum of total order amount for each of them. 
-- However, the query now inserts another column for the total order amount so that each row retains its identity. 
-- The column marked city_grand_total is the new column in the example below.
SELECT
   order_id
 , order_date
 , customer_name
 , city
 , order_amount
 , SUM(order_amount) OVER(PARTITION BY city) as city_grand_total
FROM
   orders_24042021;
-- A window function call always contains an OVER clause directly following the window function's name and argument(s).
-- This is what syntactically distinguishes it from a regular function or aggregate function. 

-- The OVER clause determines exactly how the rows of the query are split up for processing by the window function. 

-- There is no GROUP BY clause for the AVG function, but how does the SQL engine know which rows to use to compute the average? 
-- The answer is the PARTITION BY clause inside the OVER() utility

-- The PARTITION BY list within OVER specifies dividing the rows into groups, or partitions, that share the same values of the PARTITION BY expression(s).
-- For each row, the window function is computed across the rows that fall into the same partition as the current row.

-- You can also control the order in which rows are processed by window functions using ORDER BY within OVER. 

   
-- POINT TO NOTE:
-- Removing the PARTITION BY clause in the OVER() clause effectively treats the entire data set as a single window
-- So, it will give the SUM() of all the order_amount as output
SELECT
   order_id
 , order_date
 , customer_name
 , city
 , order_amount
 , SUM(order_amount) OVER() as grand_total
FROM
   orders_24042021;
   

   
-- ================= AVG()

-- AVG or Average works in exactly the same way with a Window function as SUM() did.
-- So, we can use AVG() to get the average order amount for each city
SELECT
   order_id
 , order_date
 , customer_name
 , city
 , order_amount
 , AVG(order_amount) OVER(PARTITION BY city) as avg_ordr_amt_per_city
FROM
   orders_24042021;

-- How do we get the average order amount for each city and for each month?
-- As of now, our dataset has data for only a single month.
-- Let's insert daata for another month for this.
INSERT INTO orders_24042021 VALUES ('1011','11-MAY-2017','Alan Brown','Arlington',5000);
INSERT INTO orders_24042021 VALUES ('1012','20-MAY-2017','Bobby Smith','Shalford',5000);
INSERT INTO orders_24042021 VALUES ('1013','25-MAY-2017','Walter White','GuildFord',5000);

-- To get the average order amount for each city and for each month
-- We need to partition two times, one for city, one for month
-- avg_ordr_amt_per_cty_per_mon column does exactly that
-- So, we specify more than one average by specifying multiple fields in the partition list.
SELECT
   order_id
 , order_date
 , customer_name
 , city
 , order_amount
 , AVG(order_amount) OVER(PARTITION BY city)                                 as avg_ordr_amt_per_city
 , AVG(order_amount) OVER(PARTITION BY city, EXTRACT(MONTH FROM order_date)) as avg_ordr_amt_per_cty_per_mon
FROM
   orders_24042021
;
-- It is also worth noting that that you can use expressions in the lists like EXTRACT(MONTH FROM order_date) as shown in below query.
-- You can make these expressions as complex as you want so long as the syntax is correct!



-- ================== Preceding and Following
-- Preceding and Following allow us to perform aggregate functions on the rows just before and after the current row.
SELECT
   order_id
 , order_date
 , customer_name
 , city
 , order_amount
 , AVG(order_amount) OVER(PARTITION BY city ORDER BY
                          order_date ROWS BETWEEN 1 preceding AND 1 following) as avg_ordr_amt_per_city
FROM
   orders_24042021
;

-- =================== MIN(), MAX()

-- The MIN() aggregate function will find the minimum value for a specified group or for the entire table if group is not specified.
-- The MAX() function will identify the largest value of a specified field for a specified group of rows or for the entire table if a group is not specified.



-- =================== COUNT()

-- When used as a normal aggregate function, COUNT() gives total number of occurrence of a value in a column for which we are grouping it.
-- e.g., the below query will give the number of customers for each city.
SELECT
   city
 , COUNT(customer_name) number_of_customers
FROM
   orders_24042021
GROUP BY
   city
;

-- Same can be achieved by using COUNT() as a window function
-- Only catch here is, since window function retains the identity of each row, we need to use a DISTINCT clause to get the distinct result as we got in the above case
SELECT DISTINCT
                                                city
 , COUNT(customer_name) OVER(PARTITION BY city) number_of_customers
FROM
   orders_24042021
;

-- Also, as of now our dataset has 13 distinct customer_name for all 13 rows in the dataset.
-- Let's update this to have 1 customer_name with two different orders in a single city
UPDATE
   orders_24042021
SET customer_name = 'Walter White'
 , city           = 'GuildFord'
WHERE
   order_id = 1012;
   
-- Now if we want to get count of distinct customer_name, we can do it like below
SELECT
   city
 , COUNT(DISTINCT customer_name) number_of_customers
FROM
   orders_24042021
GROUP BY
   city
;


SELECT DISTINCT
                                                         city
 , COUNT(DISTINCT customer_name) OVER(PARTITION BY city) number_of_customers
FROM
   orders_24042021
;

-- Now, let’s find the total number of orders and total order amount for each city using window function.
SELECT DISTINCT
                                                city
 , SUM(order_amount) OVER(PARTITION BY city) as tot_ordr_amt_per_city
 , COUNT(order_id) OVER(PARTITION BY city)   as num_ordr_per_city
FROM
   orders_24042021;
   
-- =================== ORDER BY and running(cumulative) total
-- If we add the ORDER BY clause in the OVER() clause along with PARTITION BY
-- We would get cumulative average per city
SELECT
   order_id
 , order_date
 , customer_name
 , city
 , order_amount
 , AVG(order_amount) OVER(PARTITION BY city ORDER BY
                          order_date) as cum_avg_per_city
FROM
   orders_24042021
-- The window ORDER BY does not sort the entire result set instead of that in sorts the result in each partition
-- and we get cumulative/running average of order_amount for each city



   
   
-- =========================================== Ranking Window Functions RANK(), DENSE_RANK(), ROW_NUMBER(), NTILE()
-- Note: ORDER BY clause is mandatory for Ranking Window Functions

-- prepare table and data
CREATE TABLE orders_24042021
(
	order_id INT,
	order_date DATE,
	customer_name VARCHAR2(250),
	city VARCHAR2(100),	
	order_amount INT
);
 
INSERT INTO orders_24042021 VALUES ('1001','01-APR-2017','David Smith','GuildFord',10000);
INSERT INTO orders_24042021 VALUES ('1002','02-APR-2017','David Jones','Arlington',20000);
INSERT INTO orders_24042021 VALUES ('1003','03-APR-2017','John Smith','Shalford',5000);
INSERT INTO orders_24042021 VALUES ('1004','04-APR-2017','Michael Smith','GuildFord',15000);
INSERT INTO orders_24042021 VALUES ('1005','05-APR-2017','David Williams','Shalford',7000);
INSERT INTO orders_24042021 VALUES ('1006','06-APR-2017','Paum Smith','GuildFord',25000);
INSERT INTO orders_24042021 VALUES ('1007','10-APR-2017','Andrew Smith','Arlington',15000);
INSERT INTO orders_24042021 VALUES ('1008','11-APR-2017','David Brown','Arlington',2000);
INSERT INTO orders_24042021 VALUES ('1009','20-APR-2017','Robert Smith','Shalford',1000);
INSERT INTO orders_24042021 VALUES ('1010','25-APR-2017','Peter Smith','GuildFord',500);


-- ======================== RANK()
-- Ties are assigned same rank with next ranks skipped

-- Let’s rank each order by their order amount in an desc order.
SELECT
   order_id
 , order_date
 , customer_name
 , city
 , order_amount
 , RANK() OVER(ORDER BY order_amount DESC) as rank_of_ordr_amt
FROM
   orders_24042021
;

-- ======================== DENSE_RANK()
-- Ties are assigned same rank with next ranks not skipped

-- Let’s rank each order by their order amount in an desc order.
SELECT
   order_id
 , order_date
 , customer_name
 , city
 , order_amount
 , DENSE_RANK() OVER(ORDER BY order_amount DESC) as rank_of_ordr_amt
FROM
   orders_24042021
;

-- Specifying PARTITION BY clause changes the window.
SELECT
   order_id
 , order_date
 , customer_name
 , city
 , order_amount
 , DENSE_RANK() OVER(PARTITION BY city ORDER BY order_amount DESC) as rank_of_ordr_amt
FROM
   orders_24042021
;
-- This simply assign ranks for each city, we can have the same effect in case of RANK() function as well



-- ====================== Filtering data
-- If there is a need to filter or group rows after the window calculations are performed, you can use a subquery like below
-- Let's say we want the second highest order_amount of each city
SELECT
   order_id
 , order_date
 , customer_name
 , city
 , order_amount
FROM
   (
      SELECT
         order_id
       , order_date
       , customer_name
       , city
       , order_amount
       , RANK() OVER(PARTITION BY city ORDER BY order_amount DESC) as rank_of_ordr_amt
      FROM
         orders_24042021
   )
WHERE
   rank_of_ordr_amt= 2
;

-- ======================== ROW_NUMBER()
-- This function assigns a unique row number to each record.

-- The row number will be reset for each partition if PARTITION BY is specified. 
-- Let’s see how ROW_NUMBER() works without PARTITION BY and then with PARTITION BY.

-- ROW_NUMBER() without PARTITION BY
SELECT
   order_id
 , order_date
 , customer_name
 , city
 , order_amount
 , ROW_NUMBER() OVER(ORDER BY order_amount DESC) as rank_of_ordr_amt
FROM
   orders_24042021
;

-- ROW_NUMBER() with PARTITION BY
SELECT
   order_id
 , order_date
 , customer_name
 , city
 , order_amount
 , ROW_NUMBER() OVER(PARTITION BY city ORDER BY order_amount DESC) as rank_of_ordr_amt
FROM
   orders_24042021
;

/*
Similarities between RANK, DENSE_RANK, and ROW_NUMBER Functions
===============================================================
The RANK, DENSE_RANK and ROW_NUMBER Functions have the following similarities:
1- All of them require an order by clause.
2- All of them return an increasing integer with a base value of 1.
3- When combined with a PARTITION BY clause, all of these functions reset the returned integer value to 1 as we have seen.
4- If there are no duplicated values in the column used by the ORDER BY clause, these functions return the same output.

Difference between RANK, DENSE_RANK and ROW_NUMBER Functions
============================================================
The only difference between RANK, DENSE_RANK and ROW_NUMBER function is when there are duplicate values in the column being used in ORDER BY Clause.
*/


-- ======================== NTILE(n)

-- NTILE(n) is a very helpful window function. It helps you to identify what percentile (or quartile, or any other subdivision, depends on 'n') a given row falls into.
-- This means that if you have 100 rows and you want to create 4 quartiles based on a specified value field you can do so easily and see how many rows fall into each quartile.
-- Also, if you need to divide specific data rows of the table into 3 groups, based on particular column values, the NTILE(3) ranking window function will help you to achieve this easily.

-- create four quartiles based on order amount. We then want to see how many orders fall into each quartile.
SELECT
   order_id
 , order_date
 , customer_name
 , city
 , order_amount
 , NTILE(4) OVER(ORDER BY order_amount) as quartile
FROM
   orders_24042021
;
-- NTILE creates tiles based on following formula: No of rows in each tile = number of rows in result set / number of tiles specified (n)

-- In our example, we have total 10 rows and 4 tiles are specified in the query so number of rows in each tile will be 2.5 (10/4). 
-- As number of rows should be whole number, not a decimal. SQL engine will assign 3 rows for first two groups and 2 rows for remaining two groups.




-- ===========================================  Value Window Functions LAG(), LEAD(), FIRST_VALUE(), LAST_VALUE()

-- Value window functions are used to find first, last, previous and next values.
-- Note: ORDER BY clause is mandatory for Value Window Functions

-- ======================== LAG()
-- The LAG function allows to access data from the previous row in the same result set without use of any SQL joins. 
-- You can see in below example, using LAG() function we found previous order date.
SELECT
   order_id
 , customer_name
 , city
 , order_amount
 , order_date
 ,
    --in below line, 1 indicates check for previous row of the current row
   LAG(order_date,1) OVER(ORDER BY order_date) prev_order_date
FROM
   orders_24042021;
   
-- Similarly we can find last to last order date using the following
SELECT
   order_id
 , customer_name
 , city
 , order_amount
 , order_date
 , LAG(order_date,2) OVER(ORDER BY order_date) last_to_last_order_date
FROM
   orders_24042021;
   
   
-- ======================== LEAD()
-- The LAG function allows to access data from the previous row in the same result set without use of any SQL joins. 
-- You can see in below example, using LAG() function we found previous order date.
SELECT
   order_id
 , customer_name
 , city
 , order_amount
 , order_date
 ,
    --in below line, 1 indicates check for next row of the current row
   LEAD(order_date,1) OVER(ORDER BY order_date) next_order_date
FROM
   orders_24042021;
   
   
-- ======================== FIRST_VALUE()
-- This function help you to identify first record within a partition or entire table if PARTITION BY is not specified.

-- ======================== LAST_VALUE()
-- This function help you to identify last record within a partition or entire table if PARTITION BY is not specified.

-- Let’s find the first and last order of each city from our existing dataset. 
-- Note: ORDER BY clause is mandatory for FIRST_VALUE() and LAST_VALUE() function
SELECT
   order_id
 , customer_name
 , city
 , order_amount
 , order_date
 , FIRST_VALUE(order_date) OVER(PARTITION BY city ORDER BY
                                city) first_order_date
 , LAST_VALUE(order_date) OVER(PARTITION BY city ORDER BY
                               city) last_order_date
FROM
   orders_24042021
;
