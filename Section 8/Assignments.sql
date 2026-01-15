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

-- 105: Min / Max Value Filtering
SELECT * FROM students;

WITH grades AS (
	SELECT 	id, student_name, final_grade, class_name
	FROM	students INNER JOIN student_grades ON id = student_id
)
SELECT id, student_name, final_grade AS top_grade, class_name
FROM
	(SELECT 	id, student_name, final_grade, class_name,
			ROW_NUMBER() OVER(PARTITION BY id ORDER BY final_grade DESC) AS top_ranking_scores
	FROM	grades) AS ranking
WHERE ranking.top_ranking_scores = 1;

-- 108: Pivoting
SELECT * FROM student_grades;

SELECT 	department,
		ROUND(AVG(CASE WHEN grade_level = 9 THEN final_grade END),0) AS freshmen,
        ROUND(AVG(CASE WHEN grade_level = 10 THEN final_grade END),0) AS sophomore,
        ROUND(AVG(CASE WHEN grade_level = 11 THEN final_grade END),0) AS junior,
        ROUND(AVG(CASE WHEN grade_level = 12 THEN final_grade END),0) AS senior
FROM (
	SELECT 	department, student_id, grade_level, final_grade
	FROM	student_grades INNER JOIN students ON student_id = id
) AS grades_by_department
GROUP BY 	department
ORDER BY 	department;

-- 112. Rolling Calculations
SELECT * FROM orders;
SELECT * FROM products;

WITH tp AS (
	SELECT 	order_id, order_date, units * unit_price AS total_price_product,
			YEAR(order_date) AS yr,
			MONTH(order_date) as mnth
	FROM	orders o INNER JOIN products p ON o.product_id = p.product_id
    )
SELECT 	yr, mnth, total_sales,
		SUM(total_sales) OVER(ORDER BY yr, mnth ASC) AS cumulative_sum,
        AVG(total_sales) OVER(
			ORDER BY yr, mnth ASC
            ROWS BETWEEN 5 PRECEDING AND CURRENT ROW) AS six_month_ma
FROM(
	SELECT 	yr, mnth, SUM(total_price_product) AS total_sales
	FROM 	tp
	GROUP BY yr, mnth
    ) AS ym




    