-- Section 8: Data Analysis Applications

-- 1. DUPLICATE VALUES

CREATE TABLE employee_details (
    region VARCHAR(50),
    employee_name VARCHAR(50),
    salary INTEGER
);

INSERT INTO employee_details (region, employee_name, salary) VALUES
	('East', 'Ava', 85000),
	('East', 'Ava', 85000),
	('East', 'Bob', 72000),
	('East', 'Cat', 59000),
	('West', 'Cat', 63000),
	('West', 'Dan', 85000),
	('West', 'Eve', 72000),
	('West', 'Eve', 75000);

-- View the employee details table
SELECT * FROM employee_details;

-- 1. Exclude fully duplicate rows
SELECT	DISTINCT region, employee_name, salary
FROM	employee_details;

-- 2. Exclude partially duplicate rows (unique employee name for each row)
SELECT * FROM

(SELECT	region, employee_name, salary,
		ROW_NUMBER() OVER(PARTITION BY employee_name ORDER BY salary DESC) AS top_sal
FROM	employee_details) AS ts

WHERE top_sal = 1;

-- 3. Exclude partially duplicate rows (unique region + employee name for each row)
SELECT * FROM

(SELECT	region, employee_name, salary,
		ROW_NUMBER() OVER(PARTITION BY region, employee_name ORDER BY salary DESC) AS top_sal
FROM	employee_details) AS ts

WHERE top_sal = 1;







