-- SQL Section 9 Final Project

-- Baseball Database

-- School Analysis:
-- a)  In each decade, how many schools were there that produced MLB players?
SELECT * FROM maven_advanced_sql.schools;

SELECT COUNT(*) AS schools_produced, decade
FROM(
	SELECT 	playerID, schoolID, decade
	FROM(
		SELECT 	p.playerID, s.schoolID, FLOOR(s.yearID/10)*10 AS decade,
				ROW_NUMBER() OVER(PARTITION BY s.schoolID, FLOOR(s.yearID/10)*10 ORDER BY FLOOR(s.yearID/10)*10 ASC) AS ordering
		FROM 	players p INNER JOIN schools s ON p.playerID = s.playerID
        ORDER BY decade, s.schoolID, ordering ASC
		) as temp
	WHERE ordering = 1
	ORDER BY decade ASC
) as decades_temp
-- WHERE decade IS NOT NULL
GROUP BY decade
ORDER BY decade;

-- Udemy solution. Much simpler. I overcomplicated it.
SELECT 	FLOOR(yearID/10)*10 AS decade, COUNT(DISTINCT schoolID) AS num_schools
FROM	schools
GROUP BY decade
ORDER BY decade;

-- b) What are the names of the top 5 schools that produced the most players?
WITH unique_player_school AS(
		SELECT 	playerID, schoolID, decade, ordering
		FROM(
			SELECT 	p.playerID, s.schoolID, FLOOR(s.yearID/10)*10 AS decade,
					ROW_NUMBER() OVER(PARTITION BY s.schoolID, p.playerID ORDER BY s.yearID ASC) AS ordering
			FROM 	players p INNER JOIN schools s ON p.playerID = s.playerID
			) as temp
		WHERE ordering = 1
		ORDER BY decade ASC
)
SELECT	schoolID, COUNT(*) AS number_players_produced
FROM 	unique_player_school
GROUP BY	schoolID
ORDER BY	number_players_produced DESC
LIMIT 5;

-- c) For each decade, what were the names of the top 3 schools that produced the most players?
WITH unique_player_school AS(
		SELECT 	FLOOR(s.yearID/10)*10 AS decade, s.schoolID, COUNT(DISTINCT p.playerID) as num_players
		FROM 	schools s LEFT JOIN players p
				ON p.playerID = s.playerID
        GROUP BY decade, s.schoolID
		ORDER BY decade ASC
),
	schools_by_decade AS(
		SELECT	schoolID, decade, num_players,
				DENSE_RANK() OVER(PARTITION BY decade ORDER BY num_players DESC) AS schools_produced
		FROM 	unique_player_school
)
SELECT * FROM schools_by_decade
WHERE schools_produced <=3
ORDER by decade DESC, schools_produced ASC








