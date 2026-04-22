-- ===================================================================
-- Transformation: service_request table
-- Objective: Prepare data for analysis
-- - Convert date/time columns from VARCHAR to TIMESTAMP
-- - Create separate date and hour columns from each timestamp
-- - Calculate resolution time between request creation and closure
-- ===================================================================

CREATE OR REPLACE TABLE service_request_transformed AS
    SELECT
        *,
       
        CAST(created_date AS TIMESTAMP) as created_ts,
        CAST(closed_date AS TIMESTAMP) as closed_ts,
        CAST(resolution_action_updated_date AS TIMESTAMP) as resolution_ts,
       
        CAST(created_ts AS DATE) AS created_day,
        CAST(closed_ts AS DATE) AS closed_day,
        CAST(resolution_ts AS DATE) AS resolution_action_updated_day,

        EXTRACT(HOUR FROM created_ts) AS created_hour,
        EXTRACT(HOUR from closed_ts) AS closed_hour,
        EXTRACT(HOUR FROM resolution_ts) AS resolution_action_updated_hour,
   
        DATEDIFF('hour', created_ts, closed_ts) AS resolution_time_hours

    FROM service_request;



-- ===================================================================
-- Drop original date columns stored as VARCHAR after converting them to TIMESTAMP
-- ===================================================================
ALTER TABLE service_request_transformed DROP COLUMN created_date;


ALTER TABLE service_request_transformed DROP COLUMN closed_date;


-- ===================================================================
-- Display final table: service_request_transformed
-- ===================================================================

SELECT *
FROM service_request_transformed
LIMIT 10 ;   

-- ===================================================================
-- Save final table as Parquet
-- ===================================================================


    COPY (
        SELECT *,
               EXTRACT(YEAR FROM created_ts) AS year
        FROM service_request_transformed
    )
    TO 'data/refined'
    (FORMAT PARQUET, PARTITION_BY (year));