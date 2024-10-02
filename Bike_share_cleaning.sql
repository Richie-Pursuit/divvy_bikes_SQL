DROP TABLE IF EXISTS Combined_Bike_Trips;

CREATE TABLE Combined_Bike_Trips
LIKE bike_trips_2016_q1;

INSERT Combined_Bike_Trips
SELECT *
FROM bike_trips_2016_q1;
 
INSERT Combined_Bike_Trips
SELECT *
FROM bike_trips_2016_q2_1;

INSERT Combined_Bike_Trips
SELECT *
FROM bike_trips_2016_q2_2;

INSERT Combined_Bike_Trips
SELECT *
FROM bike_trips_2016_q2_3;

SELECT COUNT(*)
FROM Combined_Bike_Trips
WHERE birthyear = 0;
 -- 322825 zeros
-- 480,000 rows

-- set null or empty string in gender row to Unkown
SET SQL_SAFE_UPDATES = 0;

UPDATE Combined_Bike_Trips
SET gender = 'Unknown'
WHERE gender IS NULL OR gender = '';

-- Add new columns for separated date and time
ALTER TABLE Combined_Bike_Trips
ADD COLUMN start_date DATE,
ADD COLUMN start_time TIME,
ADD COLUMN stop_date DATE,
ADD COLUMN stop_time TIME;

-- Update the new columns with separated values
UPDATE Combined_Bike_Trips
SET start_date = STR_TO_DATE(SUBSTRING_INDEX(starttime, ' ', 1), '%m/%d/%Y'),
    start_time = STR_TO_DATE(SUBSTRING_INDEX(starttime, ' ', -1), '%H:%i'),
    stop_date = STR_TO_DATE(SUBSTRING_INDEX(stoptime, ' ', 1), '%m/%d/%Y'),
    stop_time = STR_TO_DATE(SUBSTRING_INDEX(stoptime, ' ', -1), '%H:%i');
    
SET SQL_SAFE_UPDATES = 1;

-- --- ---- --- ----


SET SQL_SAFE_UPDATES = 0;
-- Removing trips with durations that are too long (for example, more than a day)
DELETE FROM Combined_Bike_Trips
WHERE tripduration > 86400;

SELECT COUNT(*) FROM Combined_Bike_Trips WHERE birthyear = 0;

-- handling unlikely birth years
DELETE FROM Combined_Bike_Trips
WHERE birthyear < 1920 AND birthyear <> 0;



SET SQL_SAFE_UPDATES = 1;


SELECT COUNT(*) AS countie
FROM Combined_Bike_Trips;

-- Checking for any remaining NULL values
SELECT COUNT(*) AS missing_genders
FROM Combined_Bike_Trips
WHERE gender IS NULL;

SELECT COUNT(*) AS missing_birthyears
FROM Combined_Bike_Trips
WHERE birthyear IS NULL;

-- Checking if datetime conversion worked
SELECT COUNT(*) AS null_trips
FROM Combined_Bike_Trips
WHERE starttime IS NULL OR stoptime IS NULL;

SELECT COUNT(*) AS customer
FROM Combined_Bike_Trips
WHERE usertype LIKE "CUSTOMER%";

SELECT *
FROM Combined_Bike_Trips
WHERE usertype = "Customer"
LIMIT 10;