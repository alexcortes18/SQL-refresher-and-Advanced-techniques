-- ---------------------------------------------------------------------------------------------------------------------------------------
-- Video 54: Multiple CTEs

SELECT * FROM
	(WITH hs23 AS (SELECT * FROM happiness_scores WHERE year = 2023),
		 hs24 AS (SELECT * FROM happiness_scores_current)
		 
	SELECT  hs23.country,
			hs23.happiness_score AS hs_2023,
			hs24.ladder_score AS hs_2024
	FROM hs23 LEFT JOIN hs24
	ON hs23.country = hs24.country) AS hs_23_24

WHERE hs_2024 > hs_2023;