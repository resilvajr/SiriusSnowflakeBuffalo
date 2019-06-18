/*=============================================
Title: sirius_snowflake_flash_demo_semi_structured_data

Usage: 

Author:		Wilson, Jason
			Rice, Newel
		
--
Create date: 2018-NOV-28
--
Description:	sirius_snowflake_flash_demo_semi_structured_data
				SDA Snowflake Lab/Demo script
				
Goal:	Prepare, Unload and Load ~2GB of semi-structured data
		in approx 5 minutes 

		Snowflake Functionality Covered:
			Variables
			User Defined Functions
			File Formats
			Create Stages
			Querying Semi-Structered Data
			Unload Data to json files
			Query Data from files in a stage(data lake)
			Import from json
			Clone Table
			Time Travel

Requires:	sirius_snowflake_flash_demo_semi_structured_data_setup
			environement needs to be established prior to using this
			script for Labs and Demos
--
--
Optional:
--
WARNING: This is a destructive script - review before using - USE AT YOUR OWN RISK!
--
Copyright (C) 2019 - Sirius Solutions, Inc.
All Rights Reserved
--
Version: 0.0.1.000
Revision History:


0.0.1.000 Original
=============================================*/

--Step 1: Change the database to your database
--        example demo_db_1
USE WAREHOUSE DEMO_XL;
USE %%CHANGEME%%;
USE SCHEMA public;

--Step 2: Create Data Variable
SET (cur_date) = CURRENT_TIMESTAMP();

--Step 3: Create UDF to convert kelvin to farenheit
ALTER SESSION SET query_tag='demo step 3';
CREATE OR REPLACE FUNCTION public.kelvin_to_faren(k number)
  RETURNS number
  AS 'k * 9/5 - 459.67';
GRANT ALL ON FUNCTION public.kelvin_to_faren(number) TO PUBLIC;

--Step 4: create file formats
ALTER SESSION SET query_tag='demo step 4';
CREATE OR REPLACE FILE FORMAT public.json_demo 
    TYPE = 'JSON' 
    COMPRESSION = 'GZIP'; 
 
--Step 5: export to json and parquet
--create stage for the file exports 
ALTER SESSION SET query_tag='demo step 5';
CREATE OR REPLACE STAGE public.vacation;


--Step 6: Table Initilization
--Get subset of weather data
--XL Cluster: ~2m      ~60GB Scanned     ~3 mil records       ~150K rows inserted
ALTER SESSION SET query_tag='demo step 6';
CREATE OR REPLACE TRANSIENT TABLE public.daily_14_total AS
SELECT
   to_timestamp(ow.t)           as prediction_dt
  ,ow.V:city.name::string       as city
  ,ow.V:city.country::string    as country
  ,to_timestamp(f.value:dt)     as forecast_dt
  ,kelvin_to_faren(f.value:temp.max) as forecast_max_f
  ,kelvin_to_faren(f.value:temp.min) as forecast_min_f
  ,f.value                           as forecast
  ,V                                 as variant_data
FROM 
    snowflake_sample_data.weather.daily_14_total ow,
    LATERAL FLATTEN(input => V, path => 'data') f
WHERE 
    to_timestamp(f.value:dt)::date > DATEADD(dd, -5, $cur_date)
    AND v:city.country = 'US'
    AND kelvin_to_faren(f.value:temp.max) between 75 and 80
ORDER BY to_timestamp(f.value:dt) DESC
;
    
--Step 7: export to json 
--XL 48s
--MD 2m51s
ALTER SESSION SET query_tag='demo step 7';
COPY INTO @vacation/cities_75to80 
FROM            
(
  SELECT
        ow.variant_data
  FROM 
      daily_14_total ow
      --,LATERAL FLATTEN(input => V, path => 'data') f
)    
FILE_FORMAT = (FORMAT_NAME = 'json_demo')   
OVERWRITE = TRUE;
 
--Step 8: View files from a stage    
--view the files in the stage    
LS @vacation;    

--Step 9: query data in files from a stage
--XL: 5s
ALTER SESSION SET query_tag='demo step 9';
SELECT v.$1 
FROM @vacation
(   FILE_FORMAT => 'json_demo'
    ,PATTERN => '.*cities_75to80_.*.json.gz'
) v
LIMIT 10; 

--Step 10: Loading Semi-structured data
--create target table
ALTER SESSION SET query_tag='demo step 10';
CREATE OR REPLACE TABLE public.vacation_cities
(
    v VARIANT       
);

--Step 11: Load json files from stage
--XL: 4.5s  111 files
ALTER SESSION SET query_tag='demo step 11';
COPY INTO public.vacation_cities(v)
FROM 
(
  SELECT $1 AS v FROM @vacation
)
PATTERN = '.*cities_75to80_.*.json.gz'
FILE_FORMAT = json_demo
ON_ERROR = 'continue' 
PURGE = FALSE
FORCE = FALSE;

--View the Load History
SELECT * 
FROM information_schema.load_history
ORDER BY last_load_time DESC;

------------------------------------------------------/
--Step 12: Time Travel and Cloning
------------------------------------------------------

--Load duplicates into vacation_cities table
ALTER SESSION SET query_tag='demo step 12';
COPY INTO public.vacation_cities(v)
FROM 
(
  SELECT $1 AS v FROM @vacation
)
PATTERN = '.*cities_75to80_.*.json.gz'
FILE_FORMAT = json_demo
ON_ERROR = 'continue' 
PURGE = FALSE
FORCE = TRUE;

--Step 13: CLONE the table prior to the duplicate insert
ALTER SESSION SET query_tag='demo step 13';
CREATE OR REPLACE TABLE temp_vacation_cities CLONE vacation_cities
BEFORE(statement => 'be00d6e8-4b92-47f2-9380-70bf2e359f76');
--AT(TIMESTAMP => DATEADD(minute, -2, $cur_date));

SELECT 'current' AS tbl, COUNT(*) AS cnt FROM vacation_cities
UNION
SELECT 'temp' AS tbl, COUNT(*) AS cnt FROM temp_vacation_cities;

--Step 14: Swap table names
ALTER SESSION SET query_tag='demo step 14';
ALTER TABLE temp_vacation_cities SWAP WITH vacation_cities;

--Step 15: Show Table History
SHOW TABLES HISTORY;
