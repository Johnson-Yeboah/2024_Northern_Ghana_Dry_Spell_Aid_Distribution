CREATE EXTENSION postgis;
SELECT PostGIS_Version();
-- Crate the Districts table
CREATE TABLE districts (
    district_id SERIAL PRIMARY KEY,
    district_name VARCHAR(240) NOT NULL,
    region VARCHAR(240) NOT NULL,
    geography GEOMETRY(MULTIPOLYGON, 4326)
);
-- Test the Districts table
SELECT * FROM districts;
-- Create the Climate Data table
CREATE TABLE climate_data (
    climate_id SERIAL PRIMARY KEY,
    date DATE,
    latitude DECIMAL,
    longitude DECIMAL,
    precipitation DECIMAL,
    district_id INT REFERENCES districts(district_id)
);
-- Test the Climate Data table
SELECT * FROM climate_data;