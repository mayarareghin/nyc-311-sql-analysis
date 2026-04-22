-- ===================================================================
-- Analysis of the total complaints resolved
-- Objective: Understand the percentage of resolution complaints
-- ===================================================================

  SELECT 
      COUNT(*) FILTER (WHERE closed_ts IS NOT NULL) * 100.0 / COUNT(*) AS pct_open
  FROM service_request_transformed;
