-- ---------------------------------------------------------------------------------------------------------------------------------------
-- Video 76: Assignment: Statistical Functions

SELECT * FROM orders;
SELECT * FROM products;

WITH ts AS (SELECT	customer_id,
					SUM(o.units * p.unit_price) AS total_orders_price
					FROM 	orders o JOIN products p ON o.product_id = p.product_id
					GROUP BY 	customer_id
			),
	 sp AS (SELECT customer_id, total_orders_price,
					NTILE(100) OVER(ORDER BY total_orders_price DESC) AS spend_pct
			FROM	ts
            )
SELECT  customer_id, total_orders_price, spend_pct
FROM	sp
WHERE	spend_pct = 1
ORDER BY spend_pct ASC;
