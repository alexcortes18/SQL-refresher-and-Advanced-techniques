-- ---------------------------------------------------------------------------------------------------------------------------------------
-- Video 37: https://www.udemy.com/course/sql-advanced-queries/learn/lecture/47029243#overview

USE maven_advanced_sql;

SELECT * FROM happiness_scores;

SELECT AVG(happiness_score) FROM happiness_scores;

SELECT year, country, happiness_score,
		(SELECT AVG(happiness_score) from happiness_scores) as avg_hs,
        happiness_score - (SELECT AVG(happiness_score) from happiness_scores) as diff_from_avg
FROM happiness_scores;

-- ---------------------------------------------------------------------------------------------------------------------------------------
-- Video 38: Assignment

SELECT * FROM maven_advanced_sql.products;

SELECT product_id, product_name, unit_price,
		(SELECT AVG(unit_price) FROM products) as avg_unit_price,
        unit_price - (SELECT AVG(unit_price) FROM products) AS diff_price
FROM products
ORDER BY unit_price DESC;

-- ---------------------------------------------------------------------------------------------------------------------------------------
-- Video 40: Subqueries in the FROM clause

SELECT * FROM happiness_scores;

SELECT 	hs.year, hs.country, hs. happiness_score,
		country_hs.avg_hs
FROM 	happiness_scores hs LEFT JOIN
		(	SELECT country, AVG(happiness_score) as avg_hs
			FROM happiness_scores
            GROUP BY country
        ) as country_hs
ON 		hs.country = country_hs.country;


-- ---------------------------------------------------------------------------------------------------------------------------------------
-- Video 41: Multiple Subqueries
SELECT * FROM (
	SELECT hs.year, hs.country, hs.happiness_score,
			country_hs.avg_hs_by_country
	FROM 	(SELECT year, country, happiness_score FROM happiness_scores
				UNION ALL
			SELECT 2024, country, ladder_score FROM happiness_scores_current
			) AS hs
			LEFT JOIN
			(SELECT country, AVG(happiness_score) as avg_hs_by_country
				FROM happiness_scores
				GROUP BY country
			) AS country_hs
	ON 		hs.country = country_hs.country) as hs_country_hs
WHERE happiness_score > hs_country_hs.avg_hs_by_country + 1;

-- ---------------------------------------------------------------------------------------------------------------------------------------
-- Video 42: Assignment: Subqueries in the FROM Clause

-- Factories and products
SELECT factory, product_name
FROM products AS p1;

-- Factory and number of products
SELECT p2.factory, COUNT(product_name) AS num_products
FROM products AS p2
GROUP BY p2.factory;

-- --------------ANSWER:
SELECT p1.factory, p1.product_name, p2.num_products
FROM products AS p1 INNER JOIN
	(SELECT factory, COUNT(product_name) AS num_products
		FROM products
		GROUP BY factory
	) AS p2
ON p1.factory = p2.factory
ORDER BY p1.factory, p1.product_name ASC;

-- ---------------------------------------------------------------------------------------------------------------------------------------
-- Video 44: Subqueries in the WHERE & HAVING Clauses
-- Where example:
SELECT *
FROM happiness_scores
WHERE happiness_score > (SELECT AVG(happiness_score) FROM happiness_scores);

-- HAVING exmaple:
SELECT region, AVG(happiness_score) AS avg_hs
FROM happiness_scores
GROUP BY region
HAVING avg_hs > (SELECT AVG(happiness_score) FROM happiness_scores);

-- ---------------------------------------------------------------------------------------------------------------------------------------
-- Video 46: EXISTS and Correlated Subqueries
SELECT *
FROM happiness_scores h
WHERE EXISTS (
	SELECT i.country_name
    FROM inflation_rates i
    WHERE i.country_name = h.country);
    
-- Writing it as an Inner Join
SELECT *
FROM happiness_scores h
INNER JOIN inflation_rates i
ON i.country_name = h.country
AND  h.year = i.year; 






