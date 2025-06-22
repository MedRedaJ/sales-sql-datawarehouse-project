/*
================================================================================
Stored Procedure: Bronze Layer Load (Source -> Bronze)
================================================================================
Script Purpose:
	This script serves as a stored procedure to load the bronze layer of the data. It extracts the data from the CSV datasource files and
	loads them into their respective tables. Note that the data is truncated, so the tables are wiped, and then data from the sources is loaded.
	It performs the following actions:
	- Truncates the bronze tables before loading the data
	- Uses the 'BULK INSERT' command to load data from CSV files to Bronze tables.

Parameters:
	None.
	This stored procedure does not accept any parameters nor return any values

Usage Example:
	EXEC bronze.load_bronze
================================================================================
*/

CREATE or ALTER PROCEDURE bronze.load_bronze AS

BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();

		------------------------------------------------------------------------------------------------
		PRINT '===============================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '===============================================================';


		------------------------------------------------------------------------------------------------
		PRINT '---------------------------------------------------------------';
		PRINT 'Loading CRM TABLES';
		PRINT '---------------------------------------------------------------';


		------------------------------------------------------------------------------------------------
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info
		PRINT '>> Inserting Data into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\HP\OneDrive\Bureau\Data Warehousing Project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> ---------------------';


		------------------------------------------------------------------------------------------------
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info
		PRINT '>> Inserting Data into: crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\HP\OneDrive\Bureau\Data Warehousing Project\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> ---------------------';


		------------------------------------------------------------------------------------------------
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details
		PRINT '>> Inserting Data into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\HP\OneDrive\Bureau\Data Warehousing Project\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> ---------------------';


		------------------------------------------------------------------------------------------------
		PRINT '---------------------------------------------------------------';
		PRINT 'Loading ERP TABLES';
		PRINT '---------------------------------------------------------------';


		------------------------------------------------------------------------------------------------
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12
		PRINT '>> Inserting Data into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\HP\OneDrive\Bureau\Data Warehousing Project\datasets\source_erp\cust_az12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> ---------------------';


		------------------------------------------------------------------------------------------------
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101
		PRINT '>> Inserting Data into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\HP\OneDrive\Bureau\Data Warehousing Project\datasets\source_erp\loc_a101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> ---------------------';


		------------------------------------------------------------------------------------------------
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2
		PRINT '>> Inserting Data into: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\HP\OneDrive\Bureau\Data Warehousing Project\datasets\source_erp\px_cat_g1v2.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> ---------------------';


		------------------------------------------------------------------------------------------------
		SET @batch_end_time = GETDATE();
		PRINT '=========================================================='
		PRINT ' Loading Bronze Layer Completed';
		PRINT '	   - Total Load Duration: ' + CAST (DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		Print '=========================================================='


		------------------------------------------------------------------------------------------------
	END TRY
	BEGIN CATCH
		PRINT '=========================================================='
		PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================================='
	END CATCH
END
