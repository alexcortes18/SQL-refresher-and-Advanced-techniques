
-- ---------------------------------------------------------------------------------------------------------------------------------------
-- Video 71: LEAD AND LAG

SELECT 	* 
FROM 	happiness_scores;


WITH hs_prior AS
	(SELECT 	country, year, happiness_score,
				LAG(happiness_score) OVER(PARTITION BY country ORDER BY year) AS prior_hs
	 FROM 		happiness_scores)

SELECT 		country, year, happiness_score, prior_hs,
			happiness_score - prior_hs AS hs_change
FROM		hs_prior;
