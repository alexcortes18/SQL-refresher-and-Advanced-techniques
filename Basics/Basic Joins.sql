USE maven_advanced_sql;

SELECT * FROM happiness_score;
SELECT * FROM country_stats;

SELECT hs.year, hs.country, hs.happiness_score,
	cs.country, cs.continent
FROM happiness_scores as hs 
LEFT JOIN country_stats cs ON hs.country = cs.country
WHERE cs.country IS NULL;

-- Unique countries in the left table:
SELECT Distinct hs.country
FROM happiness_scores as hs 
LEFT JOIN country_stats cs ON hs.country = cs.country
WHERE cs.country IS NULL;

--
SELECT *
FROM happiness_scores hs
INNER JOIN inflation_rates ir
ON hs.year = ir.year AND hs.country = ir.country_name;

-- ------------------------------------------------------------------------------------------------------------------------
SELECT * FROM happiness_scores;
SELECT * FROM country_stats;
SELECT * FROM inflation_rates;

SELECT	hs.year, hs.country, hs.happiness_score, cs.continent, ir.inflation_rate
FROM 	happiness_scores hs
		LEFT JOIN country_stats cs
			ON hs.country = cs.country
		LEFT JOIN inflation_rates ir
            ON hs.year = ir.year AND hs.country = ir.country_name;
-- ------------------------------------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS employees (
	employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    salary INT,
	manager_id INT
);

INSERT INTO employees (employee_id, employee_name, salary, manager_id) VALUES
	(1, 'Ava', 85000, NULL),
    (2, 'Bob', 72000, 1),
	(3, 'Cat', 59000, 1),
	(4, 'Dan', 85000, 2);
    
SELECT * FROM employees;

-- Employees with the same salary:
SELECT e1.employee_id, e1.employee_name, e1.salary,
	   e2.employee_id, e2.employee_name, e2.salary
FROM employees e1
INNER JOIN employees e2
ON e1.salary = e2.salary
WHERE e1.employee_id > e2.employee_id;

-- Employees that have a greater salary:
SELECT e1.employee_id, e1.employee_name, e1.salary,
	   e2.employee_id, e2.employee_name, e2.salary
FROM employees e1
INNER JOIN employees e2
ON e1.salary > e2.salary
WHERE e1.employee_id <> e2.employee_id
ORDER BY e1.employee_id DESC;

-- Employees and their managers
SELECT *
FROM employees;

SELECT e1.employee_id, e1.employee_name, e1.manager_id, e2.employee_name as manager
FROM employees e1
LEFT JOIN employees e2
ON e1.manager_id = e2.employee_id;

-- ------------------------------------------------------------------------------------------------------------------------
-- Cross Joins

CREATE TABLE tops(
	id INT,
    item VARCHAR(50)
);
CREATE TABLE sizes(
	id INT,
    size VARCHAR(50)
);
CREATE TABLE outerwear(
	id INT,
    item VARCHAR(50)
);
INSERT INTO tops (id,item) VALUES
	(1, 'T-Shirt'),
    (2, 'Hoodie');
INSERT INTO sizes (id,size) VALUES
	(1, 'Small'),
    (2, 'Medium'),
    (3, 'Large');
INSERT INTO outerwear (id,item) VALUES
	(2, 'Hoodie'),
    (3, 'Jacket'),
    (4, ' Coat');
    
SELECT * FROM tops;

-- Cros joint the tables
SELECT *
FROM tops CROSS JOIN sizes;








