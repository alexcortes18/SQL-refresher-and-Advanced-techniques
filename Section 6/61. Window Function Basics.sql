-- ---------------------------------------------------------------------------------------------------------------------------------------
-- Video 61: Window Function Basics

USE maven_advanced_sql;

-- ROW_NUMBER() OVER(PARTITION BY country ORDER BY happiness_score) AS row_num:
-- ROW_NUMBER(): one of the many window functions available
-- OVER(): states that this is a window function
-- PARTITION BY: to state that group in which we want the windows to be created. If left empty it will take place in the whole table
-- ORDER BY: to give a specific order in which to apply the window function to that specific group.

SELECT 		country, year, happiness_score,
			ROW_NUMBER() OVER(PARTITION BY country ORDER BY happiness_score) AS row_num
FROM 		happiness_scores
ORDER BY	country, row_num;

-- ---------------------------------------------------------------------------------------------------------------------------------------
-- Video 66: Functions for Window Functions

-- ROW_NUMBER(): gives every row a unique number
-- RANK(): accounts for ties
-- DENSE_RANK(): accounts for ties and leaves no missing numbers in between

CREATE TABLE IF NOT EXISTS baby_girl_names (
	name 	VARCHAR(50),
    babies	int
);

INSERT INTO baby_girl_names (name, babies) VALUES
	('Olivia', 99),
    ('Emma', 80),
    ('Charlotte', 80),
    ('Amelia', 75),
    ('Sophia', 72),
    ('Isabella', 70),
    ('Ava', 70),
    ('Mia', 64);
    
-- Compare ROW_NUMBER, RANL, DENSE_RANK

SELECT 	name, babies,
		ROW_NUMBER() OVER (ORDER BY babies DESC) AS row_f,
        RANK() OVER (ORDER BY babies DESC) AS rank_f,
        DENSE_RANK() OVER (ORDER BY babies DESC) AS dense_rank_f
FROM 	baby_girl_names
ORDER 	BY babies DESC;
    










