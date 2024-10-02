SELECT COUNT(*) FROM bike_share_Q1_Q2.bike_trips_2016_q1 WHERE usertype LIKE "Customer%";


 -- 322825 null or ""

SET SQL_SAFE_UPDATES = 0;
-- Q1 table
-- Updating empty or NULL values to '0'
UPDATE bike_trips_2016_q1
SET birthyear = '0'
WHERE birthyear IS NULL OR birthyear = '';

-- Changing column type to INT
ALTER TABLE bike_trips_2016_q1
MODIFY COLUMN birthyear INT;

SET SQL_SAFE_UPDATES = 1;


-- ----- ----- ----- -----

SET SQL_SAFE_UPDATES = 0;
-- Q2_1 table
-- Updating empty or NULL values to '0'
UPDATE bike_trips_2016_q2_1
SET birthyear = '0'
WHERE birthyear IS NULL OR birthyear = '';

-- Changing column type to INT
ALTER TABLE bike_trips_2016_q2_1
MODIFY COLUMN birthyear INT;

SET SQL_SAFE_UPDATES = 1;

-- ----- ----- ----- -----

SET SQL_SAFE_UPDATES = 0;
-- Q2_2 table
-- Updating empty or NULL values to '0'
UPDATE bike_trips_2016_q2_2
SET birthyear = '0'
WHERE birthyear IS NULL OR birthyear = '';

-- Changing column type to INT
ALTER TABLE bike_trips_2016_q2_2
MODIFY COLUMN birthyear INT;

SET SQL_SAFE_UPDATES = 1;


-- ----- ----- ----- -----

SET SQL_SAFE_UPDATES = 0;
-- Q2_3 table
-- Updating empty or NULL values to '0'
UPDATE bike_trips_2016_q2_3
SET birthyear = '0'
WHERE birthyear IS NULL OR birthyear = '';

-- Changing column type to INT
ALTER TABLE bike_trips_2016_q2_3
MODIFY COLUMN birthyear INT;

SET SQL_SAFE_UPDATES = 1;

-- cleaning special chr in Q1
SET SQL_SAFE_UPDATES = 0;


-- remove special chr from to_station using CASE
UPDATE bike_trips_2016_q1
SET to_station_name = TRIM(
    REPLACE(
        to_station_name,
        ' (*)', ''
    )
)
WHERE TRIM(to_station_name) LIKE '% (*)';

UPDATE bike_trips_2016_q2_1
SET to_station_name = TRIM(
    REPLACE(
        to_station_name,
        ' (*)', ''
    )
)
WHERE TRIM(to_station_name) LIKE '% (*)';


UPDATE bike_trips_2016_q2_2
SET to_station_name = TRIM(
    REPLACE(
        to_station_name,
        ' (*)', ''
    )
)
WHERE TRIM(to_station_name) LIKE '% (*)';



UPDATE bike_trips_2016_q2_3
SET to_station_name = TRIM(
    REPLACE(
        to_station_name,
        ' (*)', ''
    )
)
WHERE TRIM(to_station_name) LIKE '% (*)';


SET SQL_SAFE_UPDATES = 1;


-- remove special chr from from_station using CASE

SET SQL_SAFE_UPDATES = 0;

UPDATE bike_trips_2016_q1
SET from_station_name = TRIM(
    REPLACE(
        from_station_name,
        ' (*)', ''
    )
)
WHERE TRIM(from_station_name) LIKE '% (*)';


UPDATE bike_trips_2016_q2_1
SET from_station_name = TRIM(
    REPLACE(
        from_station_name,
        ' (*)', ''
    )
)
WHERE TRIM(from_station_name) LIKE '% (*)';


UPDATE bike_trips_2016_q2_2
SET from_station_name = TRIM(
    REPLACE(
        from_station_name,
        ' (*)', ''
    )
)
WHERE TRIM(from_station_name) LIKE '% (*)';


UPDATE bike_trips_2016_q2_3
SET from_station_name = TRIM(
    REPLACE(
        from_station_name,
        ' (*)', ''
    )
)
WHERE TRIM(from_station_name) LIKE '% (*)';




SET SQL_SAFE_UPDATES = 1;

SELECT COUNT(*) FROM bike_trips_2016_q1 WHERE birthyear = "0";
SELECT COUNT(*) FROM bike_trips_2016_q2_1 WHERE birthyear = "0";
SELECT COUNT(*) FROM bike_trips_2016_q2_2 WHERE birthyear = "0";
SELECT COUNT(*) FROM bike_trips_2016_q2_3 WHERE from_station_name LIKE '%*%';


 -- 322825 zeros
 
