-- ---------------------------------------------------------------------------------------------------------------------------------------
-- Video 57: Recursive CTE

CREATE TABLE IF NOT EXISTS stock_prices (
	date DATE,
    price DECIMAL(10,2)
);

INSERT INTO stock_prices (date, price) VALUES
	('2024-11-01', 678.27),
    ('2024-11-03', 688.83),
    ('2024-11-04', 645.40),
    ('2024-11-06', 591.01);

WITH RECURSIVE my_dates(dt) AS
( SELECT '2024-11-01'
  UNION ALL
  SELECT dt + INTERVAL 1 DAY
  FROM my_dates
  WHERE dt < '2024-11-06'
)
-- SELECT * FROM my_dates;

SELECT md.dt, sp.price
FROM my_dates md
LEFT JOIN stock_prices sp
ON md.dt = sp.date;