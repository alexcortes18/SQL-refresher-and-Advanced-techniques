-- a) Return the top 20% of teams in terms of average annual spending
use maven_advanced_sql;
SELECT	*
FROM	salaries;

WITH annual_spending AS (
		SELECT	yearID, teamID, SUM(salary) AS annual_spending
		FROM	salaries
		GROUP BY	yearID, teamID
),
	avg_spending AS(
		SELECT	teamID, AVG(annual_spending) AS avg_annual_spending,
				NTILE(5) OVER(ORDER BY AVG(annual_spending) DESC) AS n_tile
        FROM	annual_spending
        GROUP BY teamID
)
SELECT	*
FROM	avg_spending
WHERE n_tile = 1
ORDER BY avg_annual_spending DESC;

-- b) For each team, show the cumulative sum of spending over the years
WITH yts AS (
	SELECT	yearID, teamID, sum(salary) as yearly_team_spending
	FROM	salaries
	GROUP BY	yearID, teamID
)
SELECT	yearID, teamID, -- yearly_team_spending,
		ROUND(SUM(yearly_team_spending) OVER(PARTITION BY teamID ORDER BY yearID ASC)/1000000,1) AS cum_sum_millions
FROM 	yts
ORDER BY teamID, yearID;

-- c) Return the first year that each team's cumulative spending surpassed 1 billion
WITH yts AS (SELECT	yearID, teamID, sum(salary) as yearly_team_spending
			FROM	salaries
			GROUP BY	yearID, teamID),
	csm AS(SELECT	yearID, teamID,
					ROUND(SUM(yearly_team_spending) OVER(PARTITION BY teamID ORDER BY yearID ASC)/1000000000,2) AS cum_billions
			FROM 	yts),
	rn AS (SELECT 	yearID, teamID,cum_billions,
					ROW_NUMBER() OVER(PARTITION BY teamID ORDER BY cum_billions ASC) as rn
			FROM 	csm
			WHERE	cum_billions > 1)
SELECT 	yearID, teamID, cum_billions
FROM	rn
WHERE	rn = 1;
	






