-- ---------------------------------------------------------------------------------------------------------------------------------------
-- Video 72: Assignment: Value Relative to a Row

SELECT * FROM orders;

WITH total_units AS (
	SELECT 		customer_id, order_id,
				SUM(units) AS total_units,
                MIN(transaction_id) AS min_tid
	FROM 		orders
    GROUP BY	customer_id, order_id
),
prior_units AS (
	SELECT		customer_id, order_id, total_units,
				LAG(total_units) OVER(PARTITION BY customer_id ORDER BY min_tid ASC) AS prior_units
	FROM 		total_units
)
SELECT  customer_id, order_id, total_units,
		total_units - prior_units AS diff_units
FROM 	prior_units;
