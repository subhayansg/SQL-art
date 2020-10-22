-- Cumulative total/sum of all employees
SELECT
	  employee_id
	, department_id
	, salary
	, SUM(salary) OVER(ORDER BY employee_id) cumulative_total
FROM 
	hr.employees;
----------------------------------------------------------------------
-- Cumulative total/sum of all employees in a department
SELECT
	  employee_id
	, department_id
	, salary
	, SUM(salary) OVER(PARTITION BY department_id ORDER BY employee_id) dept_wise_cum_total
FROM 
	hr.employees;
-----------------------------------------------------------------------
-- cum sum for transactions
-- CREATE table tx_account (tx_no NUMBER, tx_date DATE, acct_num NUMBER, amount NUMBER, tx_type VARCHAR2(1));
/*
INSERT INTO tx_account VALUES ();
*/
SELECT
	tx_no
	, tx_date
	, acct_num
	, tx_type
	, SUM(DECODE(tx_type, 'D', amount, 'C', amount*-1))
		OVER(PARTITION BY acct_num ORDER BY tx_date) cumulative_total_per_account
FROM
	tx_account;