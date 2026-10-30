USE blinkit_db;

-- Customer data overview
SELECT
    COUNT(*) AS total_customer_records,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM blinkit_customers;