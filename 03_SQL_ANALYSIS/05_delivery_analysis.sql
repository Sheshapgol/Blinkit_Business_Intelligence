USE blinkit_db;



DESCRIBE blinkit_delivery_performance;


-- Delivery performance overview
SELECT
    COUNT(*) AS total_deliveries,
    ROUND(AVG(delivery_time_minutes), 2) AS avg_delivery_minutes,
    ROUND(AVG(distance_km), 2) AS avg_delivery_distance_km,
    MAX(delivery_time_minutes) AS longest_delivery_minutes,
    MIN(delivery_time_minutes) AS shortest_delivery_minutes
FROM blinkit_delivery_performance;

-- Check invalid delivery durations
SELECT
    COUNT(*) AS invalid_delivery_records
FROM blinkit_delivery_performance
WHERE delivery_time_minutes <= 0;


-- Count delivery records by duration validity
SELECT
    CASE
        WHEN delivery_time_minutes < 0 THEN 'Negative'
        WHEN delivery_time_minutes = 0 THEN 'Zero'
        ELSE 'Positive'
    END AS duration_type,
    COUNT(*) AS total_records
FROM blinkit_delivery_performance
GROUP BY duration_type
ORDER BY total_records DESC;


-- Average delivery time for positive durations only
SELECT
    COUNT(*) AS valid_delivery_records,
    ROUND(AVG(delivery_time_minutes), 2) AS avg_delivery_minutes,
    MIN(delivery_time_minutes) AS shortest_delivery_minutes,
    MAX(delivery_time_minutes) AS longest_delivery_minutes
FROM blinkit_delivery_performance
WHERE delivery_time_minutes > 0;

-- Delivery count by status
SELECT
    delivery_status,
    COUNT(*) AS total_deliveries
FROM blinkit_delivery_performance
GROUP BY delivery_status
ORDER BY total_deliveries DESC;

-- Delivery delay reasons
SELECT
    reasons_if_delayed,
    COUNT(*) AS total_deliveries
FROM blinkit_delivery_performance
WHERE delivery_status <> 'On Time'
  AND reasons_if_delayed IS NOT NULL
  AND TRIM(reasons_if_delayed) <> ''
GROUP BY reasons_if_delayed
ORDER BY total_deliveries DESC;


-- Average delivery distance by status
SELECT
    delivery_status,
    COUNT(*) AS total_deliveries,
    ROUND(AVG(distance_km), 2) AS avg_distance_km
FROM blinkit_delivery_performance
GROUP BY delivery_status
ORDER BY avg_distance_km DESC;

-- Average positive delivery time by status
SELECT
    delivery_status,
    COUNT(*) AS valid_deliveries,
    ROUND(AVG(delivery_time_minutes), 2) AS avg_delivery_minutes
FROM blinkit_delivery_performance
WHERE delivery_time_minutes > 0
GROUP BY delivery_status
ORDER BY avg_delivery_minutes DESC;

-- Delivery count by distance range
SELECT
    CASE
        WHEN distance_km < 2 THEN 'Short Distance'
        WHEN distance_km < 5 THEN 'Medium Distance'
        ELSE 'Long Distance'
    END AS distance_group,
    COUNT(*) AS total_deliveries
FROM blinkit_delivery_performance
WHERE distance_km IS NOT NULL
GROUP BY distance_group
ORDER BY total_deliveries DESC;


-- Check missing delay reasons
SELECT
    COUNT(*) AS total_deliveries,
    SUM(
        CASE
            WHEN reasons_if_delayed IS NULL
              OR TRIM(reasons_if_delayed) = ''
            THEN 1
            ELSE 0
        END
    ) AS missing_delay_reasons
FROM blinkit_delivery_performance;


-- Average delivery time by distance range
SELECT
    CASE
        WHEN distance_km < 2 THEN 'Short Distance'
        WHEN distance_km < 5 THEN 'Medium Distance'
        ELSE 'Long Distance'
    END AS distance_group,
    COUNT(*) AS total_deliveries,
    ROUND(AVG(delivery_time_minutes), 2) AS avg_delivery_minutes
FROM blinkit_delivery_performance
WHERE distance_km IS NOT NULL
  AND delivery_time_minutes > 0
GROUP BY distance_group
ORDER BY avg_delivery_minutes DESC;




