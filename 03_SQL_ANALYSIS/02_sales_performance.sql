 USE blinkit_db;

-- Overall sales performance
SELECT
    COUNT(*) AS total_orders,
    ROUND(SUM(order_total), 2) AS total_revenue,
    ROUND(AVG(order_total), 2) AS average_order_value
FROM blinkit_orders;


-- Monthly sales performance
-- Monthly sales performance
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS sales_month,
    COUNT(*) AS total_orders,
    ROUND(SUM(order_total), 2) AS monthly_revenue
FROM blinkit_orders
GROUP BY sales_month
ORDER BY sales_month;



-- Sales performance by payment method
SELECT
    payment_method,
    COUNT(*) AS total_orders,
    ROUND(SUM(order_total), 2) AS total_revenue
FROM blinkit_orders
GROUP BY payment_method
ORDER BY total_revenue DESC;



-- Average order value by payment method
SELECT
    payment_method,
    COUNT(*) AS total_orders,
    ROUND(AVG(order_total), 2) AS average_order_value
FROM blinkit_orders
GROUP BY payment_method
ORDER BY average_order_value DESC;



-- Top 10 highest-value orders
SELECT
    order_id,
    order_date,
    payment_method,
    order_total
FROM blinkit_orders
ORDER BY order_total DESC
LIMIT 10;



-- Sales performance by delivery status
SELECT
    delivery_status,
    COUNT(*) AS total_orders,
    ROUND(SUM(order_total), 2) AS total_revenue
FROM blinkit_orders
GROUP BY delivery_status
ORDER BY total_orders DESC;



-- Sales performance by day of the week
SELECT
    DAYNAME(order_date) AS day_of_week,
    COUNT(*) AS total_orders,
    ROUND(SUM(order_total), 2) AS total_revenue
FROM blinkit_orders
GROUP BY DAYOFWEEK(order_date), DAYNAME(order_date)
ORDER BY DAYOFWEEK(order_date);



-- Average order value by day of the week
SELECT
    DAYNAME(order_date) AS day_of_week,
    COUNT(*) AS total_orders,
    ROUND(AVG(order_total), 2) AS average_order_value
FROM blinkit_orders
GROUP BY DAYOFWEEK(order_date), DAYNAME(order_date)
ORDER BY DAYOFWEEK(order_date);



-- Monthly revenue summary
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS sales_month,
    ROUND(SUM(order_total), 2) AS monthly_revenue
FROM blinkit_orders
GROUP BY sales_month
ORDER BY sales_month;


-- Revenue contribution by payment method
SELECT
    payment_method,
    ROUND(SUM(order_total), 2) AS total_revenue,
    ROUND(
        SUM(order_total) * 100 /
        (SELECT SUM(order_total) FROM blinkit_orders),
        2
    ) AS revenue_percentage
FROM blinkit_orders
GROUP BY payment_method
ORDER BY total_revenue DESC;



-- Top 5 months by revenue
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS sales_month,
    COUNT(*) AS total_orders,
    ROUND(SUM(order_total), 2) AS monthly_revenue
FROM blinkit_orders
GROUP BY sales_month
ORDER BY monthly_revenue DESC
LIMIT 5;



-- Bottom 5 months by revenue
SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS sales_month,
    COUNT(*) AS total_orders,
    ROUND(SUM(order_total), 2) AS monthly_revenue
FROM blinkit_orders
GROUP BY sales_month
ORDER BY monthly_revenue ASC
LIMIT 5;



-- Revenue contribution by delivery status
SELECT
    delivery_status,
    COUNT(*) AS total_orders,
    ROUND(SUM(order_total), 2) AS total_revenue,
    ROUND(
        SUM(order_total) * 100 /
        (SELECT SUM(order_total) FROM blinkit_orders),
        2
    ) AS revenue_percentage
FROM blinkit_orders
GROUP BY delivery_status
ORDER BY total_orders DESC;



-- Average order value by delivery status
SELECT
    delivery_status,
    COUNT(*) AS total_orders,
    ROUND(AVG(order_total), 2) AS average_order_value
FROM blinkit_orders
GROUP BY delivery_status
ORDER BY average_order_value DESC;



-- Order count by payment method and delivery status
SELECT
    payment_method,
    delivery_status,
    COUNT(*) AS total_orders
FROM blinkit_orders
GROUP BY payment_method, delivery_status
ORDER BY payment_method, total_orders DESC;






-- Delivery status by payment method
SELECT
    payment_method,
    delivery_status,
    COUNT(*) AS total_orders
FROM blinkit_orders
GROUP BY payment_method, delivery_status
ORDER BY payment_method, delivery_status;


USE blinkit_db;

DESCRIBE blinkit_orders;

SELECT order_date
FROM blinkit_orders
LIMIT 10;

SELECT
    order_id,
    DATE_FORMAT(order_date, '%d-%m-%Y') AS order_date
FROM blinkit_orders;






