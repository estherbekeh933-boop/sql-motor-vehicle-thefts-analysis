-- Motor Vehicle Thefts Analysis
-- 1.How many vehicles were stolen overall?
SELECT COUNT(*) AS total_stolen_vehicles FROM stolen_vehicles;

-- How many vehicles were stolen by vehicle type?
SELECT vehicle_type, COUNT(*) AS stolen_vehicle_type 
FROM stolen_vehicles
GROUP BY vehicle_type;

-- What are the top 5 most stolen makes?
SELECT make_id, make_name, make_type, COUNT(*) AS most_stolen_make
FROM stolen_vehicles AS sv
JOIN make_details AS md
USING(make_id)
GROUP BY make_id, make_name, make_type
ORDER BY most_stolen_make DESC
LIMIT 5;

-- What is the trend of vehicle thefts by model year?
SELECT model_year, COUNT(*) AS thefts_by_model_year
FROM stolen_vehicles
GROUP BY model_year;

-- How many vehicles were stolen in each region?
SELECT location_id, region, COUNT(region) AS stolen_by_region
FROM locations AS l
JOIN stolen_vehicles
USING(location_id)
GROUP BY location_id, region
ORDER BY stolen_by_region DESC;

-- Which country has the highest number of vehicle thefts?
SELECT country, COUNT(vehicle_id) AS theft_by_country
FROM locations AS l
JOIN stolen_vehicles AS sv
USING(location_id)
GROUP BY country
ORDER BY theft_by_country
LIMIT 1;

-- Are luxury vehicles stolen more than standard vehicles?
SELECT make_type, COUNT(vehicle_id) AS theft_count
FROM make_details AS md
JOIN stolen_vehicles AS sv
USING(make_id)
GROUP BY make_type;

-- What colors are most commonly stolen?
SELECT color, COUNT(*) AS most_stolen_color
FROM stolen_vehicles
GROUP BY color
ORDER BY most_stolen_color DESC
LIMIT 5;

-- What is the average population of regions where vehicles are stolen?
SELECT region, population, AVG(population) AS avg_region_population
FROM locations
GROUP BY region, population;

-- Which month has the highest number of thefts?
SELECT EXTRACT(MONTH FROM date_stolen) AS theft_month, COUNT(*) AS count_of_thefts
FROM stolen_vehicles
GROUP BY theft_month
ORDER BY count_of_thefts DESC
LIMIT 1;

-- Which make and model year combination is most targeted?
SELECT make_name, model_year, COUNT(*) AS thefts_count
FROM stolen_vehicles AS sv
JOIN make_details AS md
USING(make_id)
GROUP BY make_name, model_year
ORDER BY thefts_count DESC
LIMIT 1;

-- What is the average age of stolen vehicles?
SELECT AVG(EXTRACT(YEAR FROM date_stolen) - model_year) AS avg_vehicle_age
FROM stolen_vehicles;

-- What is the breakdown of vehicle type by make type (Luxury or Standard)?
SELECT make_type, vehicle_type, COUNT(*) AS count
FROM make_details AS md
JOIN stolen_vehicles AS sv
USING(make_id)
GROUP BY make_type, vehicle_type;

-- Which regions have the highest thefts for luxury vehicles only?
SELECT region, COUNT(vehicle_id) AS luxury_thefts
FROM locations AS l
JOIN stolen_vehicles AS sv
USING(location_id)
JOIN make_details
USING(make_id)
WHERE make_type = 'luxury'
GROUP BY region
ORDER BY luxury_thefts DESC
LIMIT 5;

-- What is the trend of thefts over time by year?
SELECT EXTRACT(YEAR FROM date_stolen) AS theft_count, COUNT(*) AS count_of_thefts
FROM stolen_vehicles
GROUP BY theft_count;

-- Which vehicle colors are most stolen for luxury vehicles only?
SELECT color, make_type, COUNT(*) AS theft_count
FROM stolen_vehicles AS sv
JOIN make_details AS md
USING(make_id)
WHERE make_type = 'luxury'
GROUP BY color, make_type
ORDER BY theft_count DESC
LIMIT 5;

-- Which regions with the highest population density experience the most thefts?
SELECT region, population, density, COUNT(vehicle_id) AS theft_count
FROM locations AS l
JOIN stolen_vehicles AS sv
USING(location_id)
GROUP BY region, population, density
ORDER BY theft_count DESC
LIMIT 10;

-- How many unique makes are affected by vehicle theft?
SELECT COUNT(DISTINCT make_id) AS unique_makes_affected
FROM make_details; 