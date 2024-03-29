/*=============================================
Title: sirius_snowflake_flash_demo_semi_structured_data_setup

Usage: 

Author:		Rice, Newel
			Wilson, Jason
--
Create date: 2018-NOV-28
--
Description:	sirius_snowflake_flash_demo_semi_structured_data_setup
				is used to configure the SDA Snowflake Lab/Demo environment

Requires:	none
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
--This will perform an environment reset for the demo's
--Set our role for the next steps to sysadmin
USE ROLE sysadmin;

--Create our warehouses for the demo
CREATE WAREHOUSE IF NOT EXISTS "DEMO_XS" WITH WAREHOUSE_SIZE = 'XSMALL' AUTO_SUSPEND = 300 AUTO_RESUME = TRUE MIN_CLUSTER_COUNT = 1 MAX_CLUSTER_COUNT = 2 SCALING_POLICY = 'STANDARD' COMMENT = '';
CREATE WAREHOUSE IF NOT EXISTS "DEMO_MD" WITH WAREHOUSE_SIZE = 'MEDIUM' AUTO_SUSPEND = 300 AUTO_RESUME = TRUE MIN_CLUSTER_COUNT = 1 MAX_CLUSTER_COUNT = 2 SCALING_POLICY = 'STANDARD' COMMENT = '';
CREATE WAREHOUSE IF NOT EXISTS "DEMO_LG" WITH WAREHOUSE_SIZE = 'LARGE' AUTO_SUSPEND = 300 AUTO_RESUME = TRUE MIN_CLUSTER_COUNT = 1 MAX_CLUSTER_COUNT = 2 SCALING_POLICY = 'STANDARD' COMMENT = '';
CREATE WAREHOUSE IF NOT EXISTS "DEMO_XL" WITH WAREHOUSE_SIZE = 'XLARGE' AUTO_SUSPEND = 300 AUTO_RESUME = TRUE MIN_CLUSTER_COUNT = 1 MAX_CLUSTER_COUNT = 2 SCALING_POLICY = 'STANDARD' COMMENT = '';


--Create the origin database for cloning later

CREATE OR REPLACE DATABASE DEMO_DB_ORIG;
USE DEMO_DB_ORIG;
--Create our data table
CREATE OR REPLACE TABLE PUBLIC.DAILY_14_TOTAL (
	V VARIANT,
	T TIMESTAMP_NTZ(9)
);
--Load some data into our origin database
USE WAREHOUSE DEMO_LG;
INSERT INTO PUBLIC.DAILY_14_TOTAL
SELECT * FROM SNOWFLAKE_SAMPLE_DATA.WEATHER.DAILY_14_TOTAL
WHERE T BETWEEN '2018-06-01 00:00:00.000' AND '2018-07-01 00:00:00.000';

--Clone a demo database from origin database
 
DROP DATABASE IF EXISTS DEMO_DB;
CREATE DATABASE DEMO_DB CLONE DEMO_DB_ORIG;


--drop any prior version of student databases
DROP DATABASE IF EXISTS DEMO_DB_1;
DROP DATABASE IF EXISTS DEMO_DB_2;
DROP DATABASE IF EXISTS DEMO_DB_3;
DROP DATABASE IF EXISTS DEMO_DB_4;
DROP DATABASE IF EXISTS DEMO_DB_5;
DROP DATABASE IF EXISTS DEMO_DB_6;
DROP DATABASE IF EXISTS DEMO_DB_7;
DROP DATABASE IF EXISTS DEMO_DB_8;
DROP DATABASE IF EXISTS DEMO_DB_9;
DROP DATABASE IF EXISTS DEMO_DB_10;
DROP DATABASE IF EXISTS DEMO_DB_11;
DROP DATABASE IF EXISTS DEMO_DB_12;
DROP DATABASE IF EXISTS DEMO_DB_13;
DROP DATABASE IF EXISTS DEMO_DB_14;
DROP DATABASE IF EXISTS DEMO_DB_15;

--Zero Copy Clone from origin version into
--student databases
CREATE DATABASE DEMO_DB_1 CLONE DEMO_DB_ORIG;
CREATE DATABASE DEMO_DB_2 CLONE DEMO_DB_ORIG;
CREATE DATABASE DEMO_DB_3 CLONE DEMO_DB_ORIG;
CREATE DATABASE DEMO_DB_4 CLONE DEMO_DB_ORIG;
CREATE DATABASE DEMO_DB_5 CLONE DEMO_DB_ORIG;
CREATE DATABASE DEMO_DB_6 CLONE DEMO_DB_ORIG;
CREATE DATABASE DEMO_DB_7 CLONE DEMO_DB_ORIG;
CREATE DATABASE DEMO_DB_8 CLONE DEMO_DB_ORIG;
CREATE DATABASE DEMO_DB_9 CLONE DEMO_DB_ORIG;
CREATE DATABASE DEMO_DB_10 CLONE DEMO_DB_ORIG;
CREATE DATABASE DEMO_DB_11 CLONE DEMO_DB_ORIG;
CREATE DATABASE DEMO_DB_12 CLONE DEMO_DB_ORIG;
CREATE DATABASE DEMO_DB_13 CLONE DEMO_DB_ORIG;
CREATE DATABASE DEMO_DB_14 CLONE DEMO_DB_ORIG;
CREATE DATABASE DEMO_DB_15 CLONE DEMO_DB_ORIG;
--Set our role for the next several steps to accountadmin
USE ROLE accountadmin;
--Create the DEMO role
CREATE ROLE IF NOT EXISTS DEMO;
--USER MANAGEMENT
--drop any formerly setup demo users
DROP USER IF EXISTS sd_demo_1;
DROP USER IF EXISTS sd_demo_2;
DROP USER IF EXISTS sd_demo_3;
DROP USER IF EXISTS sd_demo_4;
DROP USER IF EXISTS sd_demo_5;
DROP USER IF EXISTS sd_demo_6;
DROP USER IF EXISTS sd_demo_7;
DROP USER IF EXISTS sd_demo_8;
DROP USER IF EXISTS sd_demo_9;
DROP USER IF EXISTS sd_demo_10;
DROP USER IF EXISTS sd_demo_11;
DROP USER IF EXISTS sd_demo_12;
DROP USER IF EXISTS sd_demo_13;
DROP USER IF EXISTS sd_demo_14;
DROP USER IF EXISTS sd_demo_15;

--create new demo users
CREATE USER sd_demo_1 
PASSWORD = 'june2019' 
COMMENT = 'Demo User' 
LOGIN_NAME = 'sd_demo_1' 
DISPLAY_NAME = 'sd_demo_1'
DEFAULT_ROLE = "DEMO" 
DEFAULT_WAREHOUSE = 'DEMO_XS' 
DEFAULT_NAMESPACE = 'demo_db_1' 
MUST_CHANGE_PASSWORD = FALSE;


CREATE USER sd_demo_2
PASSWORD = 'june2019' 
COMMENT = 'Demo User' 
LOGIN_NAME = 'sd_demo_2' 
DISPLAY_NAME = 'sd_demo_2' 
DEFAULT_ROLE = "DEMO" 
DEFAULT_WAREHOUSE = 'DEMO_XS' 
DEFAULT_NAMESPACE = 'demo_db_2' 
MUST_CHANGE_PASSWORD = FALSE;

CREATE USER sd_demo_3 
PASSWORD = 'june2019' 
COMMENT = 'Demo User' 
LOGIN_NAME = 'sd_demo_3' 
DISPLAY_NAME = 'sd_demo_3' 
DEFAULT_ROLE = "DEMO" 
DEFAULT_WAREHOUSE = 'DEMO_XS' 
DEFAULT_NAMESPACE = 'demo_db_3' 
MUST_CHANGE_PASSWORD = FALSE;

CREATE USER sd_demo_4 
PASSWORD = 'june2019' 
COMMENT = 'Demo User' 
LOGIN_NAME = 'sd_demo_4' 
DISPLAY_NAME = 'sd_demo_4'
DEFAULT_ROLE = "DEMO" 
DEFAULT_WAREHOUSE = 'DEMO_XS' 
DEFAULT_NAMESPACE = 'demo_db_4' 
MUST_CHANGE_PASSWORD = FALSE;

CREATE USER sd_demo_5 
PASSWORD = 'june2019' 
COMMENT = 'Demo User' 
LOGIN_NAME = 'sd_demo_5' 
DISPLAY_NAME = 'sd_demo_5' 
DEFAULT_ROLE = "DEMO" 
DEFAULT_WAREHOUSE = 'DEMO_XS' 
DEFAULT_NAMESPACE = 'demo_db_5' 
MUST_CHANGE_PASSWORD = FALSE;

CREATE USER sd_demo_6
PASSWORD = 'june2019' 
COMMENT = 'Demo User' 
LOGIN_NAME = 'sd_demo_6' 
DISPLAY_NAME = 'sd_demo_6' 
DEFAULT_ROLE = "DEMO" 
DEFAULT_WAREHOUSE = 'DEMO_XS' 
DEFAULT_NAMESPACE = 'demo_db_6' 
MUST_CHANGE_PASSWORD = FALSE;

CREATE USER sd_demo_7 
PASSWORD = 'june2019' 
COMMENT = 'Demo User' 
LOGIN_NAME = 'sd_demo_7' 
DISPLAY_NAME = 'sd_demo_7' 
DEFAULT_ROLE = "DEMO" 
DEFAULT_WAREHOUSE = 'DEMO_XS' 
DEFAULT_NAMESPACE = 'demo_db_7' 
MUST_CHANGE_PASSWORD = FALSE;

CREATE USER sd_demo_8 
PASSWORD = 'june2019' 
COMMENT = 'Demo User' 
LOGIN_NAME = 'sd_demo_8' 
DISPLAY_NAME = 'sd_demo_8' 
DEFAULT_ROLE = "DEMO" 
DEFAULT_WAREHOUSE = 'DEMO_XS' 
DEFAULT_NAMESPACE = 'demo_db_8' 
MUST_CHANGE_PASSWORD = FALSE;

CREATE USER sd_demo_9 
PASSWORD = 'june2019' 
COMMENT = 'Demo User' 
LOGIN_NAME = 'sd_demo_9' 
DISPLAY_NAME = 'sd_demo_9' 
DEFAULT_ROLE = "DEMO" 
DEFAULT_WAREHOUSE = 'DEMO_XS' 
DEFAULT_NAMESPACE = 'demo_db_9' 
MUST_CHANGE_PASSWORD = FALSE;

CREATE USER sd_demo_10 
PASSWORD = 'june2019' 
COMMENT = 'Demo User' 
LOGIN_NAME = 'sd_demo_10' 
DISPLAY_NAME = 'sd_demo_10' 
DEFAULT_ROLE = "DEMO" 
DEFAULT_WAREHOUSE = 'DEMO_XS' 
DEFAULT_NAMESPACE = 'demo_db_10' 
MUST_CHANGE_PASSWORD = FALSE;

CREATE USER sd_demo_11 
PASSWORD = 'june2019' 
COMMENT = 'Demo User' 
LOGIN_NAME = 'sd_demo_11' 
DISPLAY_NAME = 'sd_demo_11' 
DEFAULT_ROLE = "DEMO" 
DEFAULT_WAREHOUSE = 'DEMO_XS' 
DEFAULT_NAMESPACE = 'demo_db_11' 
MUST_CHANGE_PASSWORD = FALSE;

CREATE USER sd_demo_12 
PASSWORD = 'june2019' 
COMMENT = 'Demo User' 
LOGIN_NAME = 'sd_demo_12' 
DISPLAY_NAME = 'sd_demo_12' 
DEFAULT_ROLE = "DEMO" 
DEFAULT_WAREHOUSE = 'DEMO_XS' 
DEFAULT_NAMESPACE = 'demo_db_12' 
MUST_CHANGE_PASSWORD = FALSE;

CREATE USER sd_demo_13 
PASSWORD = 'june2019' 
COMMENT = 'Demo User' 
LOGIN_NAME = 'sd_demo_13' 
DISPLAY_NAME = 'sd_demo_13' 
DEFAULT_ROLE = "DEMO" 
DEFAULT_WAREHOUSE = 'DEMO_XS' 
DEFAULT_NAMESPACE = 'demo_db_13' 
MUST_CHANGE_PASSWORD = FALSE;

CREATE USER sd_demo_14 
PASSWORD = 'june2019' 
COMMENT = 'Demo User' 
LOGIN_NAME = 'sd_demo_14' 
DISPLAY_NAME = 'sd_demo_14' 
DEFAULT_ROLE = "DEMO" 
DEFAULT_WAREHOUSE = 'DEMO_XS' 
DEFAULT_NAMESPACE = 'demo_db_14' 
MUST_CHANGE_PASSWORD = FALSE;

CREATE USER sd_demo_15 
PASSWORD = 'june2019' 
COMMENT = 'Demo User' 
LOGIN_NAME = 'sd_demo_15' 
DISPLAY_NAME = 'sd_demo_15' 
DEFAULT_ROLE = "DEMO" 
DEFAULT_WAREHOUSE = 'DEMO_XS' 
DEFAULT_NAMESPACE = 'demo_db_15' 
MUST_CHANGE_PASSWORD = FALSE;


GRANT ROLE "DEMO" TO USER sd_demo_1;
GRANT ROLE "DEMO" TO USER sd_demo_2;
GRANT ROLE "DEMO" TO USER sd_demo_3;
GRANT ROLE "DEMO" TO USER sd_demo_4;
GRANT ROLE "DEMO" TO USER sd_demo_5;
GRANT ROLE "DEMO" TO USER sd_demo_6;
GRANT ROLE "DEMO" TO USER sd_demo_7;
GRANT ROLE "DEMO" TO USER sd_demo_8;
GRANT ROLE "DEMO" TO USER sd_demo_9;
GRANT ROLE "DEMO" TO USER sd_demo_10;
GRANT ROLE "DEMO" TO USER sd_demo_11;
GRANT ROLE "DEMO" TO USER sd_demo_12;
GRANT ROLE "DEMO" TO USER sd_demo_13;
GRANT ROLE "DEMO" TO USER sd_demo_14;
GRANT ROLE "DEMO" TO USER sd_demo_15;

GRANT USAGE ON WAREHOUSE demo_xs TO ROLE demo;
GRANT USAGE ON WAREHOUSE demo_md TO ROLE demo;
GRANT USAGE ON WAREHOUSE demo_lg TO ROLE demo;
GRANT USAGE ON WAREHOUSE demo_xl TO ROLE demo;

GRANT OPERATE ON WAREHOUSE demo_xs TO ROLE demo;
GRANT OPERATE ON WAREHOUSE demo_md TO ROLE demo;
GRANT OPERATE ON WAREHOUSE demo_lg TO ROLE demo;
GRANT OPERATE ON WAREHOUSE demo_xl TO ROLE demo;



--Apply permissions
GRANT ALL ON DATABASE DEMO_DB_1	TO ROLE DEMO;
GRANT ALL ON DATABASE DEMO_DB_2	TO ROLE DEMO;
GRANT ALL ON DATABASE DEMO_DB_3	TO ROLE DEMO;
GRANT ALL ON DATABASE DEMO_DB_4	TO ROLE DEMO;
GRANT ALL ON DATABASE DEMO_DB_5	TO ROLE DEMO;
GRANT ALL ON DATABASE DEMO_DB_6	TO ROLE DEMO;
GRANT ALL ON DATABASE DEMO_DB_7	TO ROLE DEMO;
GRANT ALL ON DATABASE DEMO_DB_8	TO ROLE DEMO;
GRANT ALL ON DATABASE DEMO_DB_9	TO ROLE DEMO;
GRANT ALL ON DATABASE DEMO_DB_10 TO ROLE DEMO;
GRANT ALL ON DATABASE DEMO_DB_11 TO ROLE DEMO;
GRANT ALL ON DATABASE DEMO_DB_12 TO ROLE DEMO;
GRANT ALL ON DATABASE DEMO_DB_13 TO ROLE DEMO;
GRANT ALL ON DATABASE DEMO_DB_14 TO ROLE DEMO;
GRANT ALL ON DATABASE DEMO_DB_15 TO ROLE DEMO;

GRANT ALL ON SCHEMA DEMO_DB_1.public TO ROLE DEMO;
GRANT ALL ON SCHEMA DEMO_DB_2.public TO ROLE DEMO;
GRANT ALL ON SCHEMA DEMO_DB_3.public TO ROLE DEMO;
GRANT ALL ON SCHEMA DEMO_DB_4.public TO ROLE DEMO;
GRANT ALL ON SCHEMA DEMO_DB_5.public TO ROLE DEMO;
GRANT ALL ON SCHEMA DEMO_DB_6.public TO ROLE DEMO;
GRANT ALL ON SCHEMA DEMO_DB_7.public TO ROLE DEMO;
GRANT ALL ON SCHEMA DEMO_DB_8.public TO ROLE DEMO;
GRANT ALL ON SCHEMA DEMO_DB_9.public TO ROLE DEMO;
GRANT ALL ON SCHEMA DEMO_DB_10.public TO ROLE DEMO;
GRANT ALL ON SCHEMA DEMO_DB_11.public TO ROLE DEMO;
GRANT ALL ON SCHEMA DEMO_DB_12.public TO ROLE DEMO;
GRANT ALL ON SCHEMA DEMO_DB_13.public TO ROLE DEMO;
GRANT ALL ON SCHEMA DEMO_DB_14.public TO ROLE DEMO;
GRANT ALL ON SCHEMA DEMO_DB_15.public TO ROLE DEMO;

GRANT OWNERSHIP ON ALL TABLES IN SCHEMA DEMO_DB_1.public TO ROLE DEMO;
GRANT OWNERSHIP ON ALL TABLES IN SCHEMA DEMO_DB_2.public TO ROLE DEMO;
GRANT OWNERSHIP ON ALL TABLES IN SCHEMA DEMO_DB_3.public TO ROLE DEMO;
GRANT OWNERSHIP ON ALL TABLES IN SCHEMA DEMO_DB_4.public TO ROLE DEMO;
GRANT OWNERSHIP ON ALL TABLES IN SCHEMA DEMO_DB_5.public TO ROLE DEMO;
GRANT OWNERSHIP ON ALL TABLES IN SCHEMA DEMO_DB_6.public TO ROLE DEMO;
GRANT OWNERSHIP ON ALL TABLES IN SCHEMA DEMO_DB_7.public TO ROLE DEMO;
GRANT OWNERSHIP ON ALL TABLES IN SCHEMA DEMO_DB_8.public TO ROLE DEMO;
GRANT OWNERSHIP ON ALL TABLES IN SCHEMA DEMO_DB_9.public TO ROLE DEMO;
GRANT OWNERSHIP ON ALL TABLES IN SCHEMA DEMO_DB_10.public TO ROLE DEMO;
GRANT OWNERSHIP ON ALL TABLES IN SCHEMA DEMO_DB_11.public TO ROLE DEMO;
GRANT OWNERSHIP ON ALL TABLES IN SCHEMA DEMO_DB_12.public TO ROLE DEMO;
GRANT OWNERSHIP ON ALL TABLES IN SCHEMA DEMO_DB_13.public TO ROLE DEMO;
GRANT OWNERSHIP ON ALL TABLES IN SCHEMA DEMO_DB_14.public TO ROLE DEMO;
GRANT OWNERSHIP ON ALL TABLES IN SCHEMA DEMO_DB_15.public TO ROLE DEMO;

--GRANT ALL ON ALL TABLES IN SCHEMA DEMO_DB_1.public TO ROLE DEMO;
--GRANT ALL ON ALL TABLES IN SCHEMA DEMO_DB_2.public TO ROLE DEMO;
--GRANT ALL ON ALL TABLES IN SCHEMA DEMO_DB_3.public TO ROLE DEMO;
--GRANT ALL ON ALL TABLES IN SCHEMA DEMO_DB_4.public TO ROLE DEMO;
--GRANT ALL ON ALL TABLES IN SCHEMA DEMO_DB_5.public TO ROLE DEMO;
--GRANT ALL ON ALL TABLES IN SCHEMA DEMO_DB_6.public TO ROLE DEMO;
--GRANT ALL ON ALL TABLES IN SCHEMA DEMO_DB_7.public TO ROLE DEMO;
--GRANT ALL ON ALL TABLES IN SCHEMA DEMO_DB_8.public TO ROLE DEMO;
--GRANT ALL ON ALL TABLES IN SCHEMA DEMO_DB_9.public TO ROLE DEMO;
--GRANT ALL ON ALL TABLES IN SCHEMA DEMO_DB_10.public TO ROLE DEMO;
--GRANT ALL ON ALL TABLES IN SCHEMA DEMO_DB_11.public TO ROLE DEMO;
--GRANT ALL ON ALL TABLES IN SCHEMA DEMO_DB_12.public TO ROLE DEMO;
--GRANT ALL ON ALL TABLES IN SCHEMA DEMO_DB_13.public TO ROLE DEMO;
--GRANT ALL ON ALL TABLES IN SCHEMA DEMO_DB_14.public TO ROLE DEMO;
--GRANT ALL ON ALL TABLES IN SCHEMA DEMO_DB_15.public TO ROLE DEMO;

