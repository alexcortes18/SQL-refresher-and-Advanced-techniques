USE maven_advanced_sql;

SELECT 		order_id, product_id, units
FROM		(	SELECT 	order_id, product_id, units,
					NTH_VALUE(product_id,2) OVER (PARTITION BY order_id ORDER BY units DESC) AS second_popular
				FROM 	orders
			) as second_popular
WHERE		product_id = second_popular
ORDER BY	order_id, product_id DESC;
	