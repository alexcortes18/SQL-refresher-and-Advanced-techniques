-- my own practice for recalling basics...

-- Connect to database
USE maven_advanced_sql;

--
Select * FROM students;

--  Basics 6 clauses
SELECT grade_level, AVG(gpa) as average_gpa
FROM students
WHERE school_lunch = 'YES'
GROUP BY grade_level
HAVING average_gpa < 3.3
ORDER by grade_level;

-- Distinct
SELECT Distinct grade_level
FROM students;

-- Count
SELECT COUNT(DISTINCT grade_level)
FROM students;

-- Max and Min
SELECT MAX(gpa) - MIN(gpa) AS gpa_range
FROM students;

-- AND
SELECT *
FROM students
WHERE grade_level < 12 and school_lunch = 'Yes';

-- IN
SELECT *
FROM students
WHERE grade_level IN (9,10,11);

-- IS NULL
SELECT *
FROM students
WHERE email IS NOT NULL;

-- LIKE
SELECT *
FROM students
WHERE email LIKE '%.edu';

-- ORDER BY
SELECT *
FROM students
ORDER BY gpa DESC;

-- LIMIT
SELECT *
FROM students
LIMIT 5;

-- CASE Statements
SELECT student_name, grade_level
FROM students;



