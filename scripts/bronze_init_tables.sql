/*
================================================================================
Create Tables for the bronze layer
================================================================================
Script Purpose:
	This script creates a new tables from the datasource for the bronze layer of the pipeline.

WARNING:
	Running this script will drop the tables if they exist.
	All data in the database will be permanently deleted. Proceed with caution and ensure
	you have proper backups before running this script.
*/


IF OBJECT_ID ('bronze.crm_prd_info', 'U') IS NOT NULL
	DROP TABLE bronze.crm_prd_info;
CREATE TABLE  bronze.crm_prd_info (
prd_id INT,
prd_key NVARCHAR(50),
prd_nm NVARCHAR(50),
prd_cost INT,
prd_line NVARCHAR(50),
prd_start_dt DATETIME,
prd_end_dt DATETIME
);

IF OBJECT_ID ('bronze.crm_sales_details', 'U') IS NOT NULL
	DROP TABLE bronze.crm_sales_details;
CREATE TABLE bronze.crm_sales_details (
sls_ord_num NVARCHAR(50),
sls_prd_key NVARCHAR(50),
sls_cust_id INT,
sls_order_dt INT,
sls_ship_dt INT,
sls_due_dt INT,
sls_sales INT,
sls_quantity INT,
sls_price INT
)

IF OBJECT_ID ('bronze.erp_cust_ast12', 'U') IS NOT NULL
	DROP TABLE bronze.erp_cust_ast12;
CREATE TABLE bronze.erp_cust_ast12 (
cid NVARCHAR(50),
bdate DATE,
gen NVARCHAR(50)
);

IF OBJECT_ID ('bronze.erp_loc_a101', 'U') IS NOT NULL
	DROP TABLE bronze.erp_loc_a101;
CREATE TABLE bronze.erp_loc_a101 (
cid NVARCHAR(50),
cntry NVARCHAR(50)
);

IF OBJECT_ID ('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
	DROP TABLE bronze.erp_px_cat_g1v2;
CREATE TABLE bronze.erp_px_cat_g1v2 (
id NVARCHAR(50),
cat NVARCHAR(50),
subcat NVARCHAR(50),
maintenance NVARCHAR(50)
);
