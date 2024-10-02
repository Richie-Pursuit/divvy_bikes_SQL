-- creating a table with the location coordinates for the station and bike station capacity 
DROP TABLE IF EXISTS  Combined_Bike_Trips_With_Location;
CREATE TABLE Combined_Bike_Trips_With_Location AS
SELECT 
    trips.trip_id,
    trips.starttime,
    trips.stoptime,
    trips.bikeid,
    trips.tripduration,
    trips.from_station_id,
    trips.from_station_name,
    trips.to_station_id,
    trips.to_station_name,
    trips.usertype,
    trips.gender,
    trips.birthyear,
    trips.start_date,
    trips.start_time,
    trips.stop_date,
    trips.stop_time,
    from_stations.latitude AS from_station_latitude,
    from_stations.longitude AS from_station_longitude,
    to_stations.latitude AS to_station_latitude,
    to_stations.longitude AS to_station_longitude
FROM 
    Combined_Bike_Trips AS trips
LEFT JOIN 
    bike_stations_2016_q1q2 AS from_stations 
    ON trips.from_station_name = from_stations.name
LEFT JOIN 
    bike_stations_2016_q1q2 AS to_stations 
    ON trips.to_station_name = to_stations.name;
    




-- --------- convert trip duration into minutes && hrs 

SET SQL_SAFE_UPDATES = 0;

-- Adding trip duration in minutes
ALTER TABLE Combined_Bike_Trips_With_Location
ADD COLUMN tripduration_minutes INT;

UPDATE Combined_Bike_Trips_With_Location
SET tripduration_minutes = tripduration / 60;

-- Adding trip duration in hours
ALTER TABLE Combined_Bike_Trips_With_Location
ADD COLUMN tripduration_hours DECIMAL(5, 2);

UPDATE Combined_Bike_Trips_With_Location
SET tripduration_hours = tripduration / 3600;

SET SQL_SAFE_UPDATES = 1;


SET SQL_SAFE_UPDATES = 0;
-- Add day of the week column
ALTER TABLE Combined_Bike_Trips_With_Location
ADD COLUMN start_day_of_week VARCHAR(10);

UPDATE Combined_Bike_Trips_With_Location
SET start_day_of_week = DAYNAME(start_date);

-- Adding start hour column
ALTER TABLE Combined_Bike_Trips_With_Location
ADD COLUMN start_hour INT;

UPDATE Combined_Bike_Trips_With_Location
SET start_hour = HOUR(start_time);

-- Adding time of day category column
ALTER TABLE Combined_Bike_Trips_With_Location
ADD COLUMN time_of_day_category VARCHAR(10);

UPDATE Combined_Bike_Trips_With_Location
SET time_of_day_category = CASE
    WHEN start_hour BETWEEN 5 AND 11 THEN 'Morning'
    WHEN start_hour BETWEEN 12 AND 16 THEN 'Afternoon'
    WHEN start_hour BETWEEN 17 AND 20 THEN 'Evening'
    ELSE 'Night'
END;

-- Adding trip based on duration category column
ALTER TABLE Combined_Bike_Trips_With_Location
ADD COLUMN duration_category VARCHAR(10);

UPDATE Combined_Bike_Trips_With_Location
SET duration_category = CASE
    WHEN tripduration <= 300 THEN 'Short'
    WHEN tripduration BETWEEN 301 AND 1200 THEN 'Medium'
    ELSE 'Long'
END;

SET SQL_SAFE_UPDATES = 1;




SET SQL_SAFE_UPDATES = 0;
-- --- Converting user age 
-- Adding user age column
ALTER TABLE Combined_Bike_Trips_With_Location
ADD COLUMN user_age INT;

UPDATE Combined_Bike_Trips_With_Location
SET user_age = CASE 
    WHEN birthyear = 0 THEN 0
    ELSE YEAR(CURDATE()) - birthyear
END;


SET SQL_SAFE_UPDATES = 1;


