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
