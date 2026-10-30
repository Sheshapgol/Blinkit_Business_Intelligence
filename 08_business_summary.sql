USE blinkit_db;
DESCRIBE blinkit_orders;
DESCRIBE blinkit_order_items;
-- Query 1: Overall order summary
SELECT
    COUNT(*) AS total_orders
FROM blinkit_orders;

-- Query 2: Total order items
SELECT
    COUNT(*) AS total_order_items
FROM blinkit_order_items;

-- Query 2: Total sales
SELECT
    ROUND(SUM(order_total), 2) AS total_sales
FROM blinkit_orders;


-- Query 3: Average order value
SELECT
    ROUND(AVG(order_total), 2) AS average_order_value
FROM blinkit_orders;


-- Query 4: Orders by payment method
SELECT
    payment_method,
    COUNT(*) AS total_orders
FROM blinkit_orders
GROUP BY payment_method
ORDER BY total_orders DESC;


-- Query 5: Orders by delivery status
SELECT
    delivery_status,
    COUNT(*) AS total_orders
FROM blinkit_orders
GROUP BY delivery_status
ORDER BY total_orders DESC;


-- Query 6: Top 10 products by quantity sold
SELECT
    product_id,
    SUM(quantity) AS total_quantity_sold
FROM blinkit_order_items
GROUP BY product_id
ORDER BY total_quantity_sold DESC
LIMIT 10;


-- Query 7: Top 10 products by revenue
SELECT
    product_id,
    ROUND(SUM(quantity * unit_price), 2) AS total_revenue
FROM blinkit_order_items
GROUP BY product_id
ORDER BY total_revenue DESC
LIMIT 10;


-- Query 8: Revenue by payment method
SELECT
    payment_method,
    ROUND(SUM(order_total), 2) AS total_revenue
FROM blinkit_orders
GROUP BY payment_method
ORDER BY total_revenue DESC;


-- Query 9: Average delivery time difference by status
SELECT
    delivery_status,
    ROUND(AVG(TIMESTAMPDIFF(
        MINUTE,
        promised_delivery_time,
        actual_delivery_time
    )), 2) AS avg_difference_minutes
FROM blinkit_orders
WHERE actual_delivery_time IS NOT NULL
  AND promised_delivery_time IS NOT NULL
GROUP BY delivery_status
ORDER BY avg_difference_minutes;

-- Query 10: Orders and sales by delivery status
SELECT
    delivery_status,
    COUNT(*) AS total_orders,
    ROUND(SUM(order_total), 2) AS total_sales
FROM blinkit_orders
GROUP BY delivery_status
ORDER BY total_sales DESC;