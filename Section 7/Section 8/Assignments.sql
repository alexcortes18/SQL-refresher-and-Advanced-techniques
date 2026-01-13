-- Assignments:

-- 102: Duplicate Values

SELECT 	*
FROM	students;

SELECT 	COUNT(DISTINCT(student_name))
FROM	students;

SELECT 	student_name, COUNT(*)
FROM	students
GROUP BY	student_name;

SELECT	id, student_name, email
FROM (
	SELECT	id, student_name, email,
			ROW_NUMBER() OVER(PARTITION BY student_name ORDER BY ID DESC) AS student_original
	FROM	students
    ) AS temp
WHERE student_original = 1
ORDER BY id;
    