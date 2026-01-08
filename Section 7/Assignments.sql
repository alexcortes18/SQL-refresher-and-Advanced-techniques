USE maven_advanced_sql;

-- Assignments:

-- Numeric Functions

SELECT * FROM orders;
SELECT * FROM products;

WITH bin AS (
	SELECT 	o.customer_id,
			SUM(o.units * p.unit_price) AS total_product_price_order,
			FLOOR(SUM(o.units * p.unit_price)/10)*10 as total_spend_bin
	FROM 	orders o LEFT JOIN products p ON o.product_id = p.product_id
	GROUP BY	o.customer_id
)
SELECT  total_spend_bin, COUNT(customer_id) AS num_customers
FROM	bin
GROUP BY	total_spend_bin
ORDER BY	total_spend_bin; 