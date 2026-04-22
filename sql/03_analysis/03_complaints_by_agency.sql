-- ===================================================================
-- Analysis of complaint by agency
-- Objective: Identify the requests volume by agency
-- ===================================================================


-- ===================================================================
-- Top 10 agencies in the number of requests
-- ===================================================================
SELECT 
    agency_name, 
    COUNT(*) AS total_complains
FROM service_request_transformed
GROUP BY agency_name
ORDER BY total_complains DESC
LIMIT 10

-- ===================================================================
-- Top 10 agencies with low number of requests
-- ===================================================================

SELECT 
    agency_name, 
    COUNT(*) AS total_complains
FROM service_request_transformed
GROUP BY agency_name
ORDER BY total_complains ASC
LIMIT 10
