CREATE TABLE emp(
emp_no NUMBER,
emp_name VARCHAR2(50),
salary NUMBER,
manager VARCHAR2(50),
dept_no NUMBER);
/

CREATE TABLE dept( 
Dept_no NUMBER, 
Dept_name VARCHAR2(50),
LOCATION VARCHAR2(50));
/

BEGIN
INSERT INTO DEPT VALUES(10,'HR','USA');
INSERT INTO DEPT VALUES(20,'SALES','UK');
INSERT INTO DEPT VALUES(30,'FINANCIAL','JAPAN'); 
COMMIT;
END;
/

BEGIN
INSERT INTO EMP VALUES(1000,'XXX5',15000,'AAA',30);
INSERT INTO EMP VALUES(1001,'YYY5',18000,'AAA',20) ;
INSERT INTO EMP VALUES(1002,'ZZZ5',20000,'AAA',10); 
COMMIT;
END;
/

CREATE VIEW emp_view(
Employee_name,dept_name,location) AS
SELECT emp.emp_name,dept.dept_name,dept.location
FROM emp,dept
WHERE emp.dept_no=dept.dept_no;
/

-- Update of view before instead-of trigger.
BEGIN
UPDATE emp_view SET location='FRANCE' WHERE employee_name='XXX5';
COMMIT;
END;
/
-- ORA-01779: cannot modify a column which maps to a non key-preserved table ORA-06512: at line 2
-- ORA-06512: at "SYS.DBMS_SQL", line 1721
---------------------------------------------------------------------
-- With INSTEAD OF trigger
CREATE TRIGGER emp_view_modify_trg
INSTEAD OF UPDATE
ON emp_view
FOR EACH ROW
BEGIN
UPDATE dept
SET location=:new.location
WHERE dept_name=:old.dept_name;
END;
/
-- Creation of INSTEAD OF trigger for 'UPDATE' event on the 'guru99_emp_view' view at the ROW level. It contains the update statement to update the location in the base table 'dept'.
-- Update statement uses ':NEW' and ': OLD' to find the value of columns before and after the update.

