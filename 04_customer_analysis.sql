USE blinkit_db;

-- Customer data overview
SELECT
    COUNT(*) AS total_customer_records,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM blinkit_customers;

-- Customer count by city
SELECT
    area,
    COUNT(*) AS total_customers
FROM blinkit_customers
GROUP BY area
ORDER BY total_customers DESC;


-- Customer count by segment
SELECT
    customer_segment,
    COUNT(*) AS total_customers
FROM blinkit_customers
GROUP BY customer_segment
ORDER BY total_customers DESC;

-- Customer registrations by year
SELECT
    YEAR(STR_TO_DATE(registration_date, '%Y-%m-%d')) AS registration_year,
    COUNT(*) AS total_customers
FROM blinkit_customers
WHERE STR_TO_DATE(registration_date, '%Y-%m-%d') IS NOT NULL
GROUP BY registration_year
ORDER BY registration_year;


-- Customer order statistics
SELECT
    COUNT(*) AS total_customers,
    ROUND(AVG(total_orders), 2) AS average_orders_per_customer,
    MAX(total_orders) AS highest_orders_by_customer,
    MIN(total_orders) AS lowest_orders_by_customer
FROM blinkit_customers;


-- Top 10 customers by order count
SELECT
    customer_id,
    customer_name,
    total_orders
FROM blinkit_customers
ORDER BY total_orders DESC
LIMIT 10;


-- Average order value by customer segment
SELECT
    customer_segment,
    ROUND(AVG(avg_order_value), 2) AS average_order_value
FROM blinkit_customers
GROUP BY customer_segment
ORDER BY average_order_value DESC;


-- Estimated customer spending by segment
SELECT
    customer_segment,
    ROUND(SUM(total_orders * avg_order_value), 2) AS estimated_total_spending
FROM blinkit_customers
GROUP BY customer_segment
ORDER BY estimated_total_spending DESC;

-- Customer distribution by order frequency
SELECT
    CASE
        WHEN total_orders <= 5 THEN 'Low Frequency'
        WHEN total_orders <= 10 THEN 'Medium Frequency'
        ELSE 'High Frequency'
    END AS order_frequency_group,
    COUNT(*) AS total_customers
FROM blinkit_customers
GROUP BY order_frequency_group
ORDER BY total_customers DESC;


-- Customer segmentation by average order value
SELECT
    CASE
        WHEN avg_order_value < 1000 THEN 'Low Spending'
        WHEN avg_order_value < 1500 THEN 'Medium Spending'
        ELSE 'High Spending'
    END AS spending_group,
    COUNT(*) AS total_customers
FROM blinkit_customers
GROUP BY spending_group
ORDER BY total_customers DESC;