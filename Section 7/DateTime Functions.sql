use maven_advanced_sql;

SELECT CURRENT_DATE(), CURRENT_TIMESTAMP();

-- Create a my events table
CREATE TABLE my_events (
    event_name VARCHAR(50),
    event_date DATE,
    event_datetime DATETIME,
    event_type VARCHAR(20),
    event_desc TEXT);

INSERT INTO my_events (event_name, event_date, event_datetime, event_type, event_desc) VALUES
('New Year\'s Day', '2025-01-01', '2025-01-01 00:00:00', 'Holiday', 'A global celebration to mark the beginning of the New Year. Festivities often include fireworks, parties, and various cultural traditions as people reflect on the past year and set resolutions for the upcoming one.'),
('Lunar New Year', '2025-01-29', '2025-01-29 10:00:00', 'Holiday', 'A significant cultural event in many Asian countries, the Lunar New Year, also known as the Spring Festival, involves family reunions, feasts, and various rituals to welcome good fortune and happiness for the year ahead.'),
('Persian New Year', '2025-03-20', '2025-03-20 12:00:00', 'Holiday', 'Known as Nowruz, this celebration marks the first day of spring and the beginning of the year in the Persian calendar. It is a time for family gatherings, traditional foods, and cultural rituals to symbolize renewal and rebirth.'),
('Birthday', '2025-05-13', '2025-05-13 18:00:00', ' Personal!', 'A personal celebration marking the anniversary of one\'s birth. This special day often involves gatherings with family and friends, cake, gifts, and reflecting on personal growth and achievements over the past year.'),
('Last Day of School', '2025-06-12', '2025-06-12 15:30:00', ' Personal!', 'The final day of the academic year, celebrated by students and teachers alike. It often includes parties, awards, and a sense of excitement for the upcoming summer break, marking the end of a year of hard work and learning.'),
('Vacation', '2025-08-01', '2025-08-01 08:00:00', ' Personal!', 'A much-anticipated break from daily routines, this vacation period allows individuals and families to relax, travel, and create memories. It is a time for adventure and exploration, often enjoyed with loved ones.'),
('First Day of School', '2025-08-18', '2025-08-18 08:30:00', ' Personal!', 'An exciting and sometimes nerve-wracking day for students, marking the beginning of a new academic year. This day typically involves meeting new teachers, reconnecting with friends, and setting goals for the year ahead.'),
('Halloween', '2025-10-31', '2025-10-31 18:00:00', 'Holiday', 'A festive occasion celebrated with costumes, trick-or-treating, and various spooky activities. Halloween is a time for fun and creativity, where people of all ages dress up and participate in themed events, parties, and community gatherings.'),
('Thanksgiving', '2025-11-27', '2025-11-27 12:00:00', 'Holiday', 'A holiday rooted in gratitude and family, Thanksgiving is celebrated with a large feast that typically includes turkey, stuffing, and various side dishes. It is a time to reflect on the blessings of the year and spend quality time with loved ones.'),
('Christmas', '2025-12-25', '2025-12-25 09:00:00', 'Holiday', 'A major holiday celebrated around the world, Christmas commemorates the birth of Jesus Christ. It is marked by traditions such as gift-giving, festive decorations, and family gatherings, creating a warm and joyous atmosphere during the holiday season.');

SELECT * FROM my_events;

SELECT 	event_name, event_date, event_datetime,
		YEAR(event_date) AS event_year,
        MONTH(event_date) AS event_month,
        DAYOFWEEK(event_date) AS event_dow
FROM	my_events;

-- Spell out the full days of the week using CASE statements
WITH dow AS (SELECT	event_name, event_date, event_datetime,
					YEAR(event_date) AS event_year,
					MONTH(event_date) AS event_month,
					DAYOFWEEK(event_date) AS event_dow
			 FROM	my_events)
             
SELECT	*, CASE WHEN event_dow = 1 THEN 'Sunday'
				WHEN event_dow = 2 THEN 'Monday'
				WHEN event_dow = 3 THEN 'Tuesday'
				WHEN event_dow = 4 THEN 'Wednesday'
				WHEN event_dow = 5 THEN 'Thursday'
				WHEN event_dow = 6 THEN 'Friday'
				WHEN event_dow = 7 THEN 'Saturday'
				ELSE 'Unknown' END AS event_dow_name
FROM	dow;

-- Calculate an interval between datetime values
SELECT		event_name, event_date, event_datetime, CURRENT_DATE(),
			DATEDIFF(event_date, CURRENT_DATE()) AS time_diff
FROM		my_events;

-- Add / Subtraxt an interval from a datetime value
SELECT	event_name, event_date, event_datetime,
		DATE_ADD(event_datetime, INTERVAL 1 HOUR) AS plus_one_hour
FROM	my_events;

-- 92. Demo
-- Return the first word of each event
SELECT	event_name,
		CASE	WHEN INSTR(event_name, ' ') = 0 THEN event_name
				-- WHEN INSTR(event_name, ' ') != 0 THEN SUBSTR(event_name,1,INSTR(event_name, ' ')-1) END AS first_word
				ELSE SUBSTR(event_name,1,INSTR(event_name, ' ')-1) END AS first_word
FROM	my_events;

-- Return descriptions that contain 'family'
SELECT *
FROM	my_events
WHERE	event_desc LIKE '%family%';

-- Return students with 3 letter first names
SELECT 	*
FROM	students
WHERE	student_name LIKE '___ %';

-- Note any celebration word in the sentence
SELECT 	event_desc,
		REGEXP_SUBSTR(event_desc, 'celebration|festival|holiday') AS celebration_word
FROM	my_events
WHERE	REGEXP_SUBSTR(event_desc, 'celebration|festival|holiday') IS NOT NULL;

-- Return words with hyphens in them
SELECT	event_desc,
		REGEXP_SUBSTR(event_desc, '[A-Z][a-z]+(-[A-Za-z]+)+') AS hyphen_phrase
FROM	my_events;

-- 96. Null Functions
CREATE TABLE contacts (
    name VARCHAR(50),
    email VARCHAR(100),
    alt_email VARCHAR(100));

INSERT INTO contacts (name, email, alt_email) VALUES
	('Anna', 'anna@example.com', NULL),
	('Bob', NULL, 'bob.alt@example.com'),
	('Charlie', NULL, NULL),
	('David', 'david@example.com', 'david.alt@example.com');

SELECT * FROM contacts;

SELECT  name, COALESCE(email, 'no email') AS email, COALESCE(alt_email, 'no alt email') AS alt_email
FROM	contacts;











