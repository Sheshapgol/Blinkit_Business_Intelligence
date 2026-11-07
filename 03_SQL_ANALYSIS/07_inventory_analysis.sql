USE blinkit_db;

DESCRIBE blinkit_inventory;

SELECT
    `date`,
    STR_TO_DATE(TRIM(`date`), '%d-%m-%Y') AS converted_date
FROM blinkit_inventory
LIMIT 15;

-- Inventory data overview
SELECT
    COUNT(*) AS total_records,
    SUM(stock_received) AS total_stock_received,
    SUM(damaged_stock) AS total_damaged_stock
FROM blinkit_inventory;

-- Damaged stock by product
SELECT
    product_id,
    SUM(damaged_stock) AS total_damaged_stock
FROM blinkit_inventory
GROUP BY product_id
ORDER BY total_damaged_stock DESC
LIMIT 10;


-- Stock received by product
SELECT
    product_id,
    SUM(stock_received) AS total_stock_received
FROM blinkit_inventory
GROUP BY product_id
ORDER BY total_stock_received DESC
LIMIT 10;


-- Inventory records by date
SELECT
    date,
    COUNT(*) AS total_records
FROM blinkit_inventory
GROUP BY date
ORDER BY date
LIMIT 10;


-- Total stock received by date
SELECT
    date,
    SUM(stock_received) AS total_stock_received
FROM blinkit_inventory
GROUP BY date
ORDER BY date
LIMIT 10;


-- Total damaged stock by date
SELECT
    date,
    SUM(damaged_stock) AS total_damaged_stock
FROM blinkit_inventory
GROUP BY date
ORDER BY date
LIMIT 10;


-- Check records with zero stock received
SELECT
    COUNT(*) AS zero_stock_records
FROM blinkit_inventory
WHERE stock_received = 0;


-- Check records with zero damaged stock
SELECT
    COUNT(*) AS zero_damaged_stock_records
FROM blinkit_inventory
WHERE damaged_stock = 0;


-- Check for missing stock values
SELECT
    COUNT(*) AS missing_stock_records
FROM blinkit_inventory
WHERE stock_received IS NULL
   OR damaged_stock IS NULL;
   
   
   -- Check damaged stock greater than stock received
SELECT
    COUNT(*) AS suspicious_records
FROM blinkit_inventory
WHERE damaged_stock > stock_received;


-- Inspect records where damaged stock exceeds stock received
SELECT
    product_id,
    date,
    stock_received,
    damaged_stock
FROM blinkit_inventory
WHERE damaged_stock > stock_received
LIMIT 10;


-- Check inventory totals for 17-03-2023
SELECT
    date,
    COUNT(*) AS total_records,
    SUM(stock_received) AS total_stock_received,
    SUM(damaged_stock) AS total_damaged_stock
FROM blinkit_inventory
WHERE date = '17-03-2023'
GROUP BY date;

-- Count records where damaged stock exceeds stock received, by date
SELECT
    date,
    COUNT(*) AS suspicious_records
FROM blinkit_inventory
WHERE damaged_stock > stock_received
GROUP BY date
ORDER BY suspicious_records DESC
LIMIT 10;


