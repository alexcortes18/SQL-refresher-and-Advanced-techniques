-- ---------------------------------------------------------------------------------------------------------------------------------------
-- Video 50: Subqueries vs CTEs
-- Old Subquery:

SELECT 	hs.year, hs.country, hs.happiness_score,
		country_hs.avg_hs
FROM 	happiness_scores hs LEFT JOIN
		(	SELECT country, AVG(happiness_score) as avg_hs
			FROM happiness_scores
            GROUP BY country
        ) as country_hs
ON 		hs.country = country_hs.country;

-- Rewriting to use a CTE:

WITH country_hs AS (SELECT 	country, AVG(happiness_score) as avg_hs
					FROM 		happiness_scores
					GROUP BY 	country)
            
SELECT 	hs.year, hs.country, hs.happiness_score, country_hs.avg_hs
FROM 	happiness_scores AS hs LEFT JOIN country_hs
ON 		hs.country = country_hs.country;

-- ---------------------------------------------------------------------------------------------------------------------------------------
-- Video 51: Referencing a CTE multiple times
WITH hs AS (SELECT * FROM happiness_scores WHERE year = 2023)

SELECT hs1.region, hs1.country, hs1.happiness_score,
	   hs2.country, hs2.happiness_score
FROM   hs hs1 INNER JOIN hs hs2
ON 	   hs1.region = hs2.region
WHERE  hs1.country < hs2.country;



