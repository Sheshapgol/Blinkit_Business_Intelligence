USE blinkit_db;

-- Check product table structure
DESCRIBE blinkit_products;


-- Product data overview
SELECT
    COUNT(*) AS total_products,
    COUNT(DISTINCT product_id) AS unique_products,
    ROUND(AVG(price), 2) AS average_price,
    ROUND(MIN(price), 2) AS minimum_price,
    ROUND(MAX(price), 2) AS maximum_price
FROM blinkit_products;



-- Product count by category
SELECT
    category,
    COUNT(*) AS total_products
FROM blinkit_products
GROUP BY category
ORDER BY total_products DESC;



-- Top 10 best-selling products by quantity
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM blinkit_products AS p
JOIN blinkit_order_items AS oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_sold DESC
LIMIT 10;



-- Bottom 10 products by quantity sold
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM blinkit_products AS p
JOIN blinkit_order_items AS oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_sold ASC
LIMIT 10;




-- Revenue by product
SELECT
    p.product_id,
    p.product_name,
    ROUND(SUM(oi.quantity * p.price), 2) AS total_revenue
FROM blinkit_products AS p
JOIN blinkit_order_items AS oi
    ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC;


-- Top 10 products by revenue
SELECT
    p.product_id,
    p.product_name,
    ROUND(SUM(oi.quantity * p.price), 2) AS total_revenue
FROM blinkit_products AS p
JOIN blinkit_order_items AS oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY total_revenue DESC
LIMIT 10;


-- Average product price by category
SELECT
    category,
    ROUND(AVG(price), 2) AS average_price
FROM blinkit_products
GROUP BY category
ORDER BY average_price DESC;


-- Highest-priced product in each category
SELECT
    category,
    product_name,
    price
FROM (
    SELECT
        category,
        product_name,
        price,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY price DESC
        ) AS product_rank
    FROM blinkit_products
) AS ranked_products
WHERE product_rank = 1
ORDER BY price DESC;


-- Top 10 products by profit margin percentage
SELECT
    product_id,
    product_name,
    category,
    margin_percentage
FROM blinkit_products
ORDER BY margin_percentage DESC
LIMIT 10;

-- Average profit margin by category
SELECT
    category,
    ROUND(AVG(margin_percentage), 2) AS average_margin_percentage
FROM blinkit_products
GROUP BY category
ORDER BY average_margin_percentage DESC;


-- Products with the shortest shelf life
SELECT
    product_id,
    product_name,
    category,
    shelf_life_days
FROM blinkit_products
WHERE shelf_life_days IS NOT NULL
ORDER BY shelf_life_days ASC
LIMIT 10;


-- Product count by shelf life
SELECT
    shelf_life_days,
    COUNT(*) AS total_products
FROM blinkit_products
WHERE shelf_life_days IS NOT NULL
GROUP BY shelf_life_days
ORDER BY shelf_life_days;












