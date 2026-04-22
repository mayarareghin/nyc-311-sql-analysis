-- ===================================================================
-- Analysis of complaint by borough
-- Objective: Identify the requests volume by borough
-- ===================================================================


-- ===================================================================
-- Requests by borough
-- ===================================================================

SELECT 
   borough, 
   COUNT(*) AS total_complains
FROM service_request_transformed
GROUP BY borough
ORDER BY total_complains DESC

-- ===================================================================
-- Top requests type by borough
-- ===================================================================

WITH ranking AS (
    SELECT 
        borough,
        complaint_type,
        COUNT(*) AS total,
        ROW_NUMBER() OVER (
          PARTITION BY borough 
          ORDER BY COUNT(*) DESC
        ) AS rank
    FROM service_request_transformed
    WHERE borough IS NOT NULL
    AND complaint_type IS NOT NULL
    GROUP BY borough, complaint_type
  )

  SELECT 
      borough,
      complaint_type,
      total
  FROM ranking
  WHERE rank = 1
  ORDER BY total DESC;


-- ===================================================================
-- Top 15 total complaints by street name
-- ===================================================================

SELECT 
    street_name, 
    COUNT(*) AS total_complains
FROM service_request_transformed
GROUP BY street_name
ORDER BY total_complains DESC
LIMIT 15