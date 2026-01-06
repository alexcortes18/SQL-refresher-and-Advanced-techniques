-- ---------------------------------------------------------------------------------------------------------------------------------------
-- Video 55: Multiple CTEs
-- Rewrite the following code with multiple CTEs:

SELECT p1.factory, p1.product_name, p2.num_products
FROM products AS p1 INNER JOIN
	(SELECT factory, COUNT(product_name) AS num_products
		FROM products
		GROUP BY factory
	) AS p2
ON p1.factory = p2.factory
ORDER BY p1.factory, p1.product_name ASC;

-- Answer with Multiple CTEs:

WITH 	products_1 AS (SELECT factory, product_name FROM products),
		products_2 AS (SELECT factory, COUNT(product_name) AS num_products
					   FROM products
					   GROUP BY factory)
SELECT products_1.factory, products_1.product_name, products_2.num_products
FROM products_1
INNER JOIN products_2 
ON products_1.factory = products_2.factory;






