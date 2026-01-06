USE maven_advanced_sql;

SELECT * FROM products;

SELECT p1.product_name, p1.unit_price,
		p2.product_name, p2.unit_price, abs(p1.unit_price - p2.unit_price) AS price_diff
FROM products p1 INNER JOIN products p2
WHERE ABS(p1.unit_price - p2.unit_price) < 0.25
		AND p1.product_name < p2.product_name
ORDER BY price_diff DESC;

-- Rewritten with a Cross Join
SELECT p1.product_name, p1.unit_price,
		p2.product_name, p2.unit_price, abs(p1.unit_price - p2.unit_price) AS price_diff
FROM products p1 CROSS JOIN products p2
WHERE ABS(p1.unit_price - p2.unit_price) < 0.25
		AND p1.product_name < p2.product_name
ORDER BY price_diff DESC;