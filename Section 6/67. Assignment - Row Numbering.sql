USE maven_advanced_sql;

SELECT 		order_id, product_id, units,
			DENSE_RANK() OVER (PARTITION BY order_id ORDER BY units DESC) AS product_rank
FROM		orders
ORDER BY	order_id, product_rank;