-- Connect to database
USE maven_advanced_sql;

-- ASSIGNMENT 1: Basic Joins
-- Looking at the orders and products tables, which products exist in one table, but not the other?

-- View the orders and products tables
SELECT * FROM orders;
SELECT * FROM products;

SELECT count(DISTINCT product_id) FROM orders;
SELECT count(DISTINCT product_id) FROM products;

-- Join the tables using various join types & note the number of rows in the output
SELECT p.product_id, p.product_name, p.unit_price, o.transaction_id, o.order_id, o.units
FROM products p
INNER JOIN orders o ON p.product_id = o.product_id;
        
-- View the products that exist in one table, but not the other
SELECT p.product_id, p.product_name, o.product_id AS product_id_in_orders
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
WHERE o.product_id IS NULL;

-- Pick a final JOIN type to join products and orders


-- ASSIGNMENT 2: Self Joins
-- Which products are within 25 cents of each other in terms of unit price?

-- View the products table


-- Join the products table with itself so each candy is paired with a different candy

        
-- Calculate the price difference, do a self join, and then return only price differences under 25 cents


