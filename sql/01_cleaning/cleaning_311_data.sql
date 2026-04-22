-- ===================================================================
-- Load data from API-downloaded files into a dataframe
-- Source: data/raw/nyc-311
-- ===================================================================

CREATE OR REPLACE TABLE service_request AS
    SELECT * FROM 'data/raw/**/*.parquet';

-- ===================================================================
-- Removing non-relevant columns for analysis
-- Note: Columns are dropped one by one due to DuckDB limitations
-- ===================================================================

ALTER TABLE service_request DROP COLUMN incident_zip;
ALTER TABLE service_request DROP COLUMN cross_street_1;
ALTER TABLE service_request DROP COLUMN cross_street_2;
ALTER TABLE service_request DROP COLUMN intersection_street_1;
ALTER TABLE service_request DROP COLUMN intersection_street_2;
ALTER TABLE service_request DROP COLUMN address_type;
ALTER TABLE service_request DROP COLUMN landmark;
ALTER TABLE service_request DROP COLUMN facility_type;
ALTER TABLE service_request DROP COLUMN due_date;
ALTER TABLE service_request DROP COLUMN community_board;
ALTER TABLE service_request DROP COLUMN council_district;
ALTER TABLE service_request DROP COLUMN police_precinct;
ALTER TABLE service_request DROP COLUMN bbl;
ALTER TABLE service_request DROP COLUMN park_borough;
ALTER TABLE service_request DROP COLUMN vehicle_type;
ALTER TABLE service_request DROP COLUMN taxi_company_borough;
ALTER TABLE service_request DROP COLUMN taxi_pick_up_location;
ALTER TABLE service_request DROP COLUMN bridge_highway_name;
ALTER TABLE service_request DROP COLUMN bridge_highway_direction;
ALTER TABLE service_request DROP COLUMN road_ramp;
ALTER TABLE service_request DROP COLUMN bridge_highway_segment;
ALTER TABLE service_request DROP COLUMN latitude;
ALTER TABLE service_request DROP COLUMN longitude;
ALTER TABLE service_request DROP COLUMN location;
ALTER TABLE service_request DROP COLUMN x_coordinate_state_plane;
ALTER TABLE service_request DROP COLUMN y_coordinate_state_plane;
ALTER TABLE service_request DROP COLUMN park_facility_name;
ALTER TABLE service_request DROP COLUMN descriptor_2;


-- ===================================================================
-- Display final table
-- ===================================================================

SELECT *
FROM service_request
LIMIT 10 