-- a) Which players have the same birthday?

WITH same_birthdays AS (SELECT	p1.playerID, p1.nameGiven, p1.birthYear, p1.birthMonth, p1.birthDay
						FROM	players p1 INNER JOIN players p2
								ON p1.birthYear = p2.birthYear AND p1.birthMonth = p2.birthMonth AND p1.birthDay=p2.birthDay
						WHERE	p1.birthYear BETWEEN '1980' AND '2000'
						AND		p1.playerID != p2.playerID
						ORDER BY	p1.birthYear, p1.birthMonth, p1.birthDay DESC)
SELECT	birthYear, birthMonth, birthDay, GROUP_CONCAT(nameGiven SEPARATOR ', ') AS players, COUNT(nameGiven) AS number_people
FROM	same_birthdays
GROUP BY	birthYear, birthMonth, birthDay
HAVING number_people > 2;

-- b) Create a summary table that shows for each team, what percent of players bat right, left and both.
SELECT	s.teamID,
		ROUND(SUM(CASE WHEN p.bats = 'R' THEN 1 ELSE 0 END) / COUNT(s.playerID)*100,2)  AS bats_right_pct,
        ROUND(SUM(CASE WHEN p.bats = 'L' THEN 1 ELSE 0 END) / COUNT(s.playerID)*100,2)  AS bats_left_pct,
        ROUND(SUM(CASE WHEN p.bats = 'B' THEN 1 ELSE 0 END) / COUNT(s.playerID)*100,2)  AS bats_both_pct	
FROM	salaries s LEFT JOIN players p
		ON s.playerID = p.playerID
GROUP BY s.teamID;

-- c) How have average height and weight at debut game changed over the years, and what's the decade-over-decade difference?
WITH hw AS (SELECT	FLOOR(YEAR(debut)/10)*10 as decade, AVG(height) AS avg_height, AVG(weight) AS avg_weight
			FROM	players
			GROUP BY	decade)
SELECT	*,
		avg_height - LAG(avg_height) OVER(ORDER BY decade ASC) AS decade_height_diff,
        avg_weight - LAG(avg_weight) OVER(ORDER BY decade ASC) AS decade_weight_diff
FROM	hw
WHERE	decade IS NOT NULL;

