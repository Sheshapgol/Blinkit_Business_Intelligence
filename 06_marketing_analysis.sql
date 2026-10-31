USE blinkit_db;

DESCRIBE blinkit_marketing_performance;

-- Overall marketing performance
SELECT
    COUNT(*) AS total_campaign_records,
    SUM(impressions) AS total_impressions,
    SUM(clicks) AS total_clicks,
    SUM(conversions) AS total_conversions,
    ROUND(SUM(spend), 2) AS total_spend,
    ROUND(SUM(revenue_generated), 2) AS total_revenue_generated,
    ROUND(AVG(roas), 2) AS average_roas
FROM blinkit_marketing_performance;


-- Marketing performance by channel
SELECT
    channel,
    COUNT(*) AS total_records,
    SUM(clicks) AS total_clicks,
    SUM(conversions) AS total_conversions,
    ROUND(SUM(spend), 2) AS total_spend,
    ROUND(SUM(revenue_generated), 2) AS total_revenue
FROM blinkit_marketing_performance
GROUP BY channel
ORDER BY total_revenue DESC;

-- Revenue by marketing channel
SELECT
    channel,
    ROUND(SUM(revenue_generated), 2) AS total_revenue
FROM blinkit_marketing_performance
GROUP BY channel
ORDER BY total_revenue DESC;

-- Campaign records by target audience
SELECT
    target_audience,
    COUNT(*) AS total_campaigns
FROM blinkit_marketing_performance
GROUP BY target_audience;


-- Total conversions by target audience
SELECT
    target_audience,
    SUM(conversions) AS total_conversions
FROM blinkit_marketing_performance
GROUP BY target_audience;


-- Total revenue by target audience
SELECT
    target_audience,
    ROUND(SUM(revenue_generated), 2) AS total_revenue
FROM blinkit_marketing_performance
GROUP BY target_audience;


-- Campaign records by channel
SELECT
    channel,
    COUNT(*) AS total_campaigns
FROM blinkit_marketing_performance
GROUP BY channel;


-- Average ROAS by channel
SELECT
    channel,
    ROUND(AVG(roas), 2) AS average_roas
FROM blinkit_marketing_performance
GROUP BY channel;


-- Total impressions by channel
SELECT
    channel,
    SUM(impressions) AS total_impressions
FROM blinkit_marketing_performance
GROUP BY channel;


-- Total clicks by channel
SELECT
    channel,
    SUM(clicks) AS total_clicks
FROM blinkit_marketing_performance
GROUP BY channel;


-- Total conversions by channel
SELECT
    channel,
    SUM(conversions) AS total_conversions
FROM blinkit_marketing_performance
GROUP BY channel;