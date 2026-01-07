-- ---------------------------------------------------------------------------------------------------------------------------------------
-- Video 75: NTILE

-- Add a percentile to each row of data:
WITH hs_pct AS (SELECT 	region, country, happiness_score,
						NTILE(4) OVER(PARTITION BY region ORDER BY happiness_score DESC) hs_percentile
				FROM 	happiness_scores
				WHERE	year = 2023
				ORDER BY region, happiness_score DESC) -- an ORDER BY inside a CTE DOES NOT get applied to the outermost SELECT.
SELECT *
FROM 	hs_pct
WHERE	hs_percentile = 1;







