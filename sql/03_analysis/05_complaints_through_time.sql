-- ===================================================================
-- Analysis of trends by time
-- Objective: Identify when the complaints are more open
-- ===================================================================

-- ===================================================================
-- Requests by month
-- ===================================================================

SELECT
    MONTH(created_day) AS month,
    COUNT(*) AS total
FROM service_request_transformed
GROUP BY month

-- ===================================================================
-- Requests by day of week
-- ===================================================================

SELECT 
    DAYNAME(created_day) AS day_of_week,
    COUNT(*) AS total
FROM service_request_transformed
GROUP BY day_of_week
ORDER BY total DESC;


-- ===================================================================
-- Hours with more requests made
-- ===================================================================

SELECT 
    created_hour,
    COUNT(*) AS total
FROM service_request_transformed
GROUP BY created_hour
ORDER BY total DESC;