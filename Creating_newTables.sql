DROP TABLE IF EXISTS  UserType_Summary;
CREATE TABLE UserType_Summary AS
SELECT 
    usertype,
    COUNT(trip_id) AS total_trips,
    AVG(tripduration) AS avg_tripduration,
    AVG(tripduration_minutes) AS avg_tripduration_minutes,
    AVG(tripduration_hours) AS avg_tripduration_hours,
    AVG(user_age) AS avg_user_age
FROM 
    Combined_Bike_Trips_With_Location
GROUP BY 
    usertype;
-- ===================================
DROP TABLE IF EXISTS TimeOfDay_Usage;
CREATE TABLE TimeOfDay_Usage AS
SELECT 
    time_of_day_category,
    SUM(CASE WHEN usertype = 'Customer' THEN 1 ELSE 0 END) AS Customer_Trips,
    SUM(CASE WHEN usertype = 'Subscriber' THEN 1 ELSE 0 END) AS Subscriber_Trips
FROM 
    Combined_Bike_Trips_With_Location
GROUP BY 
    time_of_day_category
ORDER BY 
    (SUM(CASE WHEN usertype = 'Customer' THEN 1 ELSE 0 END) + 
     SUM(CASE WHEN usertype = 'Subscriber' THEN 1 ELSE 0 END)) DESC;

    
    -- ----
-- A table that shows trip numbers in terms of days out the week
DROP TABLE IF EXISTS DayOfWeek_Usage;
CREATE TABLE DayOfWeek_Usage AS
SELECT 
    start_day_of_week,
    SUM(CASE WHEN usertype = 'Subscriber' THEN 1 ELSE 0 END) AS subscriber_trips,
    SUM(CASE WHEN usertype = 'Customer' THEN 1 ELSE 0 END) AS customer_trips,
    COUNT(trip_id) AS total_trips
FROM 
    Combined_Bike_Trips_With_Location
GROUP BY 
    start_day_of_week
ORDER BY 
    FIELD(start_day_of_week, 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday');


    
    -- --------
-- creating a table to see what are the popular bike stations

DROP TABLE IF EXISTS Popular_Locations;

CREATE TABLE Popular_Locations AS
SELECT 
    from_station_name,
    to_station_name,
    SUM(CASE WHEN usertype = 'Subscriber' THEN 1 ELSE 0 END) AS subscriber_trips,
    SUM(CASE WHEN usertype = 'Customer' THEN 1 ELSE 0 END) AS customer_trips,
    COUNT(trip_id) AS total_trips -- total trips adds the most popular from and to station routes despite member status
FROM 
    Combined_Bike_Trips_With_Location
GROUP BY 
    from_station_name, to_station_name
ORDER BY 
    total_trips DESC;

-- ----

-- CREATE TABLE Subscriber_Demographics AS
-- SELECT 
--     gender,
--     AVG(user_age) AS avg_user_age,
--     COUNT(trip_id) AS total_trips
-- FROM 
--     Combined_Bike_Trips_With_Location
-- WHERE 
--     usertype = 'Subscriber'
-- GROUP BY 
--     gender;
    
-- ----

-- Assuming the haversine_distance function is already created
DROP TABLE IF EXISTS Trip_Distance;
CREATE TABLE Trip_Distance AS
SELECT 
    trip_id,
    usertype,
    (3959 * ACOS(
        COS(RADIANS(from_station_latitude)) 
        * COS(RADIANS(to_station_latitude)) 
        * COS(RADIANS(to_station_longitude) - RADIANS(from_station_longitude)) 
        + SIN(RADIANS(from_station_latitude)) 
        * SIN(RADIANS(to_station_latitude))
    )) AS distance_miles
FROM 
    Combined_Bike_Trips_With_Location;
    
-- ----------
DROP TABLE IF EXISTS Potential_Subscribers;
CREATE TABLE Potential_Subscribers AS
SELECT 
    trip_id,
    COUNT(trip_id) OVER (PARTITION BY from_station_name, to_station_name, start_day_of_week, start_hour) AS trip_count
FROM 
    Combined_Bike_Trips_With_Location
WHERE 
    usertype = 'Customer';