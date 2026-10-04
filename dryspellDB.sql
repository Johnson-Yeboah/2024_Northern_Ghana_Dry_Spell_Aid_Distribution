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

-- Create the Agricultural Impact table
CREATE TABLE agricultural_impact (
    agricultural_impact_id SERIAL PRIMARY KEY,
    year INT NOT NULL,
    region VARCHAR(240) NOT NULL,
    crop VARCHAR(240) NOT NULL,
    affected_area DECIMAL NOT NULL,
    impact_severity VARCHAR(240) NOT NULL
);

-- Test the Agricultural Impact table
SELECT * FROM agricultural_impact;

-- Create agricultural_production table
CREATE TABLE agricultural_production (
    production_id SERIAL,
    year INT,
    crop VARCHAR(240) NOT NULL,
    production DECIMAL NOT NULL,
    yield DECIMAL NOT NULL,
    harvested_area DECIMAL NOT NULL
);

-- Make production_id the primary key
ALTER TABLE agricultural_production ADD PRIMARY KEY (production_id);

--Add NOT NULL constraint to year in agricultural_production table
ALTER TABLE agricultural_production ALTER COLUMN year SET NOT NULL;

-- Test the agricultural_production table
SELECT * FROM agricultural_production;

-- Create the Aid Distribution table
CREATE TABLE aid_distribution (
    aid_id SERIAL PriMARY KEY,
    date DATE NOT NULL,
    region VARCHAR(240) NOT NULL,
    organization VARCHAR(240) NOT NULL,
    aid_type VARCHAR(240) NOT NULL,
    beneficiaries INT NOT NULL,
    quantity DECIMAL,
    value_ghs DECIMAL
);

-- Test the Aid Distribution table
SELECT * FROM aid_distribution;

-- Define relationships between tables
-- Make district_id in climate_data a foreign key referencing districts
ALTER TABLE climate_data ADD FOREIGN KEY(district_id) REFERENCES districts(district_id);

-- Create a regions table to store unique regions
CREATE TABLE regions (
    region_id SERIAL PRIMARY KEY,
    region_name VARCHAR(240) NOT NULL UNIQUE
);

-- Add foreign key constraints to districts, agricultural_impact, and aid_distribution tables referencing regions
ALTER TABLE districts ADD COLUMN region_id INT REFERENCES regions(region_id);
ALTER TABLE agricultural_impact ADD COLUMN region_id INT REFERENCES regions(region_id);
ALTER TABLE aid_distribution ADD COLUMN region_id INT REFERENCES regions(region_id);

--remove the region column from districts, agricultural_impact, and aid_distribution tables
ALTER TABLE districts DROP COLUMN region;
ALTER TABLE agricultural_impact DROP COLUMN region;
ALTER TABLE aid_distribution DROP COLUMN region;
