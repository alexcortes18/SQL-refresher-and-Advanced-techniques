-- a) Return the top 20% of teams in terms of average annual spending
use maven_advanced_sql;
SELECT	*
FROM	salaries;

SELECT	teamID, annual_spending, top_20, top_20_ntile
FROM (
	SELECT  teamID, annual_spending,
			PERCENT_RANK() OVER(ORDER BY annual_spending) AS top_20,
			NTILE(5) OVER(ORDER BY annual_spending) AS top_20_ntile
	FROM (
		SELECT	teamID, AVG(salary) AS annual_spending
		FROM	salaries
		GROUP BY teamID
	) as annual_spending
) AS top_20_pct
WHERE	top_20 >= 0.8;
-- WHERE	top_20_ntile = 5

-- b) For each team, show the cumulative sum of spending over the years
WITH yts AS (
	SELECT	yearID, teamID, sum(salary) as yearly_team_spending
	FROM	salaries
	GROUP BY	yearID, teamID
)
SELECT	yearID, teamID, -- yearly_team_spending,
		SUM(yearly_team_spending) OVER(PARTITION BY teamID ORDER BY yearID ASC) AS cum_sum
FROM 	yts
ORDER BY teamID, yearID

-- c) Return the first year that each team's cumulative spending surpassed 1 billion







