/* Input:
StudentName Subject
Ashutosh Maths
Ashutosh English
Ashutosh Science
Ram English
Ram Science
Rahul Maths
Mahendra Science
Vikas English

Find the names of students having Science and English in their course curriculum from the students table

Output:
Ashutosh
Ram
*/

CREATE TABLE students(studentname STRING, subject STRING);
INSERT INTO students VALUES('Ashutosh', 'Maths');
INSERT INTO students VALUES('Ashutosh', 'English');
INSERT INTO students VALUES('Ashutosh', 'Science');
INSERT INTO students VALUES('Ram', 'English');
INSERT INTO students VALUES('Ram', 'Science');
INSERT INTO students VALUES('Rahul', 'Maths');
INSERT INTO students VALUES('Mahendra', 'Science');
INSERT INTO students VALUES('Vikas', 'English');

SELECT
   studentname
FROM
   students
WHERE
   subject IN ('Science'
             ,'English')
GROUP BY
   subject
 , studentname
HAVING
   COUNT(DISTINCT subject) = 2
;