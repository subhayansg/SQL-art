6. table a               table b
col1                     col1
1                         1
2                         1
3                         2
5                         4
 what will be the output for the below query.?
 
select a.col1,b.col1 from table a inner join table b where a.col1=b.col1;
 what will be the output if we use full join for the above dataset.?
 

 
-- Given statement will fail due to missing On clause, also table b does not have col1

-- Assuming ON in place of WHERE and table b column name is col1:
select a.col1,b.col1 from a inner join b ON a.col1=b.col1;

This will give output like below

/*
+--------+-----------+
| col1   | col2  |
+--------+-----------+
| 1      | 1         |
| 1      | 1         |
| 2      | 2         |
+--------+-----------+
*/

The reason is: col1 from a will get matched against col1 of b. So, matching rows are 1, 1 (b col1). Similarly, 2, 2 gets matched once.

For full outer join we should see inner join + additional rows for left outer join(keeping a on left) + additional rows for right outer join (keeping a on left):
/*
+--------+-----------+
| col1   | col2  |
+--------+-----------+
| 1      | 1         |
| 1      | 1         |
| 2      | 2         |
+--------+-----------+
| 5      | null      |	additional rows for left outer join (keeping a on left)
| 3      | null      |
+--------+-----------+
| null   | 4         |  additional rows for right outer join (keeping a on left)
+--------+-----------+
*/


 
create table a(col1 INT);
create table b(col1 INT);
INSERT INTO a VALUES(1);
INSERT INTO a VALUES(2);
INSERT INTO a VALUES(3);
INSERT INTO a VALUES(5);
INSERT INTO b VALUES(1);
INSERT INTO b VALUES(1);
INSERT INTO b VALUES(2);
INSERT INTO b VALUES(4);