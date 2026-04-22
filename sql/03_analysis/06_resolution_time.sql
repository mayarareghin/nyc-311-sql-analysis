-- ===================================================================
-- Analysis of the time to resolve the requests
-- Objective: Understand how many time takes to agencies resolve the requests 
-- Time to resolve in format of hours
-- ===================================================================

-- ===================================================================
-- MIN, Max, Avarage e Median resolution time
-- ===================================================================

SELECT
    MIN(resolution_time_hours),
    MAX(resolution_time_hours),
    AVG(resolution_time_hours) AS avg_resolution_time
    ROUND(MEDIAN(resolution_time_hours)) AS median_time
FROM service_request_transformed

-- ===================================================================
-- MIN, Max, Avarage e Median resolution time removing outliers
-- Considering requests resolved between 0 and 365 days
-- ===================================================================

SELECT
    MIN(resolution_time_hours) AS min,
    MAX(resolution_time_hours) AS max,
    AVG(resolution_time_hours) AS avg_resolution_time,
    MEDIAN(resolution_time_hours) AS median_time,
FROM service_request_transformed
WHERE resolution_time_hours > 0 AND resolution_time_hours < 8766

""")

-- ===================================================================
-- Types of complaints with highest time to resolution
-- ===================================================================

SELECT 
    complaint_type,
    ROUND(AVG(resolution_time_hours)) AS avg_resolution,
    ROUND(MEDIAN(resolution_time_hours)) AS median_resolution
FROM service_request_transformed
WHERE resolution_time_hours IS NOT NULL
GROUP BY complaint_type
ORDER BY avg_resolution_time DESC
LIMIT 10;

-- ===================================================================
-- Types of complaints with lowest time to resolution
-- ===================================================================

SELECT 
      complaint_type,
      COUNT(*) as total
      ROUND(AVG(resolution_time_hours)) AS avg_resolution_time,
      ROUND(MEDIAN(resolution_time_hours)) AS median_resolution
FROM service_request_transformed
WHERE resolution_time_hours IS NOT NULL
GROUP BY complaint_type
ORDER BY avg_resolution_time ASC
LIMIT 10;


-- ===================================================================
-- Avarage time to resolve the top 10 complaint types
-- ===================================================================

SELECT
    complaint_type,
    COUNT(*) as total,
    ROUND(AVG(resolution_time_hours)) AS avg_resolution_time
FROM service_request_transformed
WHERE resolution_time_hours IS NOT NULL
GROUP BY complaint_type
ORDER BY total DESC
LIMIT 10


-- ===================================================================
-- Time of resolution by borough
-- ===================================================================

SELECT
    borough,
    AVG(resolution_time_hours) AS avg_resolution_time
FROM service_request_transformed
WHERE resolution_time_hours IS NOT NULL
GROUP BY borough
ORDER BY avg_resolution_time ASC;

