SET SERVEROUTPUT ON
DECLARE
   l_dept_no NUMBER :=10;
BEGIN
    FOR i IN 
	(
        SELECT 
			ename
        FROM 
			emp
        WHERE 
			deptno = l_dept_no
    ) LOOP
        dbms_output.put_line(i.ename);
    END LOOP;
END;
/

-------------------------------------------------------------
SET SERVEROUTPUT ON
DECLARE
   l_dept_no NUMBER :=100;
   l_ename hr.employees.first_name%TYPE;
   CURSOR c1 IS 
	SELECT 
		first_name
    FROM 
		hr.employees
	WHERE 
		department_id= l_dept_no;
BEGIN
   OPEN c1;
   LOOP
       FETCH c1 INTO l_ename;
       EXIT WHEN c1%notfound;
       dbms_output.put_line(l_ename);
   END LOOP;
END;
/

-------------------------------------------------------------
SET SERVEROUTPUT ON
DECLARE
  TYPE lv_name_list_type is table of hr.employees.first_name%TYPE;
  lv_emp_name_list lv_name_list_type := lv_name_list_type();
BEGIN
    SELECT first_name
    bulk collect into lv_emp_name_list
    from hr.employees
    where department_id =100;
 
    for i in lv_emp_name_list.first..lv_emp_name_list.last loop
    dbms_output.put_line(lv_emp_name_list(i));
    end loop;
END;
/