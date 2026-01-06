-- ---------------------------------------------------------------------------------------------------------------------------------------
-- Video 57: Subqueries vs CTE vs Temp Tables vs Views

-- Temporary Table: To have a temporary table that might be used more than a CTE through a session.
CREATE TEMPORARY TABLE my_temp_table AS
SELECT year, country, happiness_score FROM happiness_scores
UNION ALL
SELECT 2024, country, ladder_score FROM happiness_scores_current;

SELECT * FROM my_temp_table;

-- View: For something like a Temp Table that needs to persist among sessions. This Does not store a table, rather creates
-- a query that is run when you want to access the View.
CREATE VIEW my_view AS
SELECT year, country, happiness_score FROM happiness_scores
UNION ALL
SELECT 2024, country, ladder_score FROM happiness_scores_current;

SELECT * FROM my_view;