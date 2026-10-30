USE blinkit_db;

-- QUERY 1: Overall order validation
SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT order_id) AS unique_orders,
    ROUND(SUM(order_total), 2) AS total_revenue
FROM blinkit_orders;


-- QUERY 2: Checking  duplicate order IDs
SELECT
    order_id,
    COUNT(*) AS occurrences
FROM blinkit_orders
GROUP BY order_id
HAVING COUNT(*) > 1;



-- QUERY 3: Checking missing order IDs
SELECT COUNT(*) AS missing_order_ids
FROM blinkit_orders
WHERE order_id IS NULL;


-- Checking order totals
SELECT
    COUNT(*) AS total_orders,
    COUNT(order_total) AS orders_with_amount,
    MIN(order_total) AS minimum_order,
    MAX(order_total) AS maximum_order
FROM blinkit_orders;


-- Checking missing payment methods
SELECT COUNT(*) AS missing_payment_methods
FROM blinkit_orders
WHERE payment_method IS NULL;


-- Checking missing delivery statuses
SELECT COUNT(*) AS missing_delivery_status
FROM blinkit_orders
WHERE delivery_status IS NULL;


-- Checking missing order dates
SELECT COUNT(*) AS missing_order_dates
FROM blinkit_orders
WHERE order_date IS NULL;


-- Checking missing delivery timestamps
SELECT
    COUNT(*) AS total_orders,
    COUNT(promised_delivery_time) AS promised_times,
    COUNT(actual_delivery_time) AS actual_times
FROM blinkit_orders;


-- List delivery status categories
SELECT
    delivery_status,
    COUNT(*) AS total_orders
FROM blinkit_orders
GROUP BY delivery_status
ORDER BY total_orders DESC;


-- Counting orders by payment method
SELECT
    payment_method,
    COUNT(*) AS total_orders
FROM blinkit_orders
GROUP BY payment_method
ORDER BY total_orders DESC;


-- Checking missing customer IDs
SELECT COUNT(*) AS missing_customer_ids
FROM blinkit_orders
WHERE customer_id IS NULL;
