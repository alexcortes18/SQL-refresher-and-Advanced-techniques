USE maven_advanced_sql;


SELECT * FROM orders;
SELECT * FROM products;

SELECT *
FROM orders o
INNER JOIN products p
ON o.product_id = p.product_id;

WITH order_amounts AS ( SELECT o.order_id,
					    SUM(o.units*p.unit_price) AS total_amount_spent
                        FROM orders o
						INNER JOIN products p
						ON o.product_id = p.product_id
                        GROUP BY o.order_id
						HAVING total_amount_spent > 200
					  )
SELECT * FROM order_amounts;
-- SELECT COUNT(*) FROM order_amounts;

           




