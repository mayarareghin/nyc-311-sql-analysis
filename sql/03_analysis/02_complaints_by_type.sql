-- ===================================================================
-- Analysis of complaint types
-- Objective: Identify the most common types of complaints overall
-- ===================================================================

-- ===================================================================
-- Total types of complaints in the database
-- ===================================================================

SELECT COUNT( DISTINCT complaint_type) AS total_types 
  FROM service_request_transformed


-- ===================================================================
-- Top 10 complaints
-- ===================================================================

SELECT complaint_type, COUNT(*) AS total_complains
FROM service_request_transformed
GROUP BY complaint_type
ORDER BY total_complains DESC
LIMIT 10

-- ===================================================================
-- Least requested complaints
-- ===================================================================

SELECT complaint_type, COUNT(*) AS total_complains
FROM service_request_transformed
GROUP BY complaint_type
ORDER BY total_complains ASC
LIMIT 10