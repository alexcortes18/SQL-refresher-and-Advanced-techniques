-- a) For each player, calculate their age at their first (debut) game, their last game, and their career length (all in years). 
-- Sort from longest career to shortest career.

WITH birthdate AS	(SELECT 	playerID, debut, finalGame,
							CONVERT(CONCAT(birthYear,"-",birthMonth,"-",birthDay),DATE) as birthdate
					FROM	players)
SELECT	playerID, debut, finalGame, birthdate,
		-- DATEDIFF(debut,birthdate)/365 AS debut_age_decimal,
        TIMESTAMPDIFF(YEAR, birthdate,debut) AS debut_age2,
		-- DATEDIFF(finalGame,birthdate)/365 AS finalGame_age_decimal,
        TIMESTAMPDIFF(YEAR,birthdate,finalGame) AS finalGame_age2,
        -- DATEDIFF(finalGame,debut)/365 AS career_len_decimal,
        TIMESTAMPDIFF(YEAR,debut,finalGame) AS career_len_decimal2
FROM	birthdate
ORDER BY	career_len_decimal2 DESC;

-- b) What team did each player play on for their starting and ending years?
WITH debut_team AS	(SELECT 	playerID, teamID, yearID,
									ROW_NUMBER() OVER(PARTITION BY playerID ORDER BY yearID ASC) AS rn
							FROM	salaries),
	final_team AS		(SELECT 	playerID, teamID, yearID,
									ROW_NUMBER() OVER(PARTITION BY playerID ORDER BY yearID DESC) AS rn
							FROM	salaries)
SELECT	p.playerID, YEAR(p.debut) AS debut_year, YEAR(p.finalGame) AS final_year,
		s1.teamID AS debut_team,
        s2.teamID AS final_team
FROM	players p 
LEFT JOIN debut_team s1 ON p.playerID = s1.playerID
LEFT JOIN final_team s2 ON p.playerID = s2.playerID
WHERE	s1.rn = 1 AND s2.rn = 1;

-- c) How many players started and ended on the same team and also played for over a decade?
WITH debut_team AS	(SELECT 	playerID, teamID, yearID,
									ROW_NUMBER() OVER(PARTITION BY playerID ORDER BY yearID ASC) AS rn
							FROM	salaries),
	final_team AS		(SELECT 	playerID, teamID, yearID,
									ROW_NUMBER() OVER(PARTITION BY playerID ORDER BY yearID DESC) AS rn
							FROM	salaries)
SELECT	p.playerID, YEAR(p.debut) AS debut_year, YEAR(p.finalGame) AS final_year,
		s1.teamID AS debut_team,
        s2.teamID AS final_team
FROM	players p 
LEFT JOIN debut_team s1 ON p.playerID = s1.playerID
LEFT JOIN final_team s2 ON p.playerID = s2.playerID
WHERE	s1.rn = 1 AND s2.rn = 1
AND 	s1.teamID = s2.teamID
AND		s2.yearID - s1.yearID > 10;



        
        
        