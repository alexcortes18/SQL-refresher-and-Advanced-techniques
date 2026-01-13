USE maven_advanced_sql;

-- 84. Numeric Functions

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

-- 87. DateTime Functions

SELECT 	order_id, order_date,
		DATE_ADD(order_date, INTERVAL 2 DAY) AS ship_date
FROM	orders
WHERE	order_date >= '2024-04-01' AND order_date < '2024-07-01'
ORDER BY	order_date;

-- 90. String Functions
SELECT 	factory, product_id, REPLACE(CONCAT(factory,'-',product_id),' ','') AS factory_product_id
FROM 	products
ORDER BY	factory;

-- 94. Pattern Matching
SELECT  product_name,
		replace(product_name, 'Wonka Bar - ', '') AS new_product_name
FROM	products
ORDER BY	 product_name;

-- 97. Null Functions
SELECT 	*
FROM	products;

WITH division_cts AS (
	SELECT	factory, division, COUNT(*) AS division_counts
	FROM	products
	GROUP BY	factory, division
    ORDER BY	factory
),
	division_final AS (
	SELECT dc1.factory, dc1.division, dc1.division_counts
	FROM division_cts dc1
	JOIN division_cts dc2 ON dc1.factory = dc2.factory
	WHERE dc1.division_counts > dc2.division_counts

	UNION ALL

	SELECT factory, division, division_counts
	FROM division_cts
	WHERE factory IN (
		SELECT factory
		FROM division_cts
		GROUP BY factory
		HAVING COUNT(*) = 1
	)
)
SELECT  p.product_name, p.factory, p.division,
		COALESCE(p.division, "Other") AS division_other,
        COALESCE(p.division, df.division) as division_top
FROM	products p
JOIN	division_final df ON p.factory = df.factory; 







