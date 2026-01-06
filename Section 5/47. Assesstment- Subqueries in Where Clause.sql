SELECT * FROM products;

SELECT *
FROM products
WHERE unit_price < ALL (
	SELECT unit_price
    FROM products
    WHERE factory = 'Wicked Choccy\'s'
) ;