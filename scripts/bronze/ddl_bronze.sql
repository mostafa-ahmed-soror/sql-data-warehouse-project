 CREATE OR ALTER PROCEDURE bronze.load_bronze AS
 BEGIN
	DECLARE @start_time DATETIME,@end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time=GETDATE();
		print'================================';
		print'loading bronze layer';
		print'================================';

		print'--------------------------------';
		print'Loading CRM Tables'
		print'--------------------------------';

		SET @start_time=GETDATE();
		print'Truncating table bronze.crm_cust_info ';
		TRUNCATE TABLE bronze.crm_cust_info;
		BULK INSERT bronze.crm_cust_info
		FROM 'G:\data analysis\datawarehouse project baraa\sql-data-warehouse-project\datasets\source_crm.\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',', 
			TABLOCK
		);
		SET @end_time=GETDATE();
		print'>> Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
		print'>>--------------';

		SET @start_time=GETDATE();
		print'Truncating Table: bronze.crm_prd_info ';
		TRUNCATE TABLE bronze.crm_prd_info;
		BULK INSERT bronze.crm_prd_info
		FROM 'G:\data analysis\datawarehouse project baraa\sql-data-warehouse-project\datasets\source_crm.\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time=GETDATE();
		print'>> Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
		print'>>--------------';

		SET @start_time=GETDATE();
		print'Truncating Table: bronze.crm_sales_details ';
		TRUNCATE TABLE bronze.crm_sales_details;
		BULK INSERT bronze.crm_sales_details
		FROM 'G:\data analysis\datawarehouse project baraa\sql-data-warehouse-project\datasets\source_crm.\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time=GETDATE();
		print'>> Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
		print'>>--------------';

		print'--------------------------------';
		print'Loading ERP Tables'
		print'--------------------------------';

		SET @start_time=GETDATE();
		print'Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;
		BULK INSERT bronze.erp_cust_az12
		FROM 'G:\data analysis\datawarehouse project baraa\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time=GETDATE();
		print'>> Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
		print'>>--------------';


		SET @start_time=GETDATE();
		print'Truncating Table: bronze.erp_loc_a101 ';
		TRUNCATE TABLE bronze.erp_loc_a101;
		BULK INSERT bronze.erp_loc_a101
		FROM 'G:\data analysis\datawarehouse project baraa\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time=GETDATE();
		print'>> Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
		print'>>--------------';

		SET @start_time=GETDATE();
		print'Truncating Table: bronze.erp_px_cat_g1v2 ';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		BULK INSERT bronze.erp_px_cat_g1v2  
		FROM 'G:\data analysis\datawarehouse project baraa\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		 SET @end_time=GETDATE();
		print'>> Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'Seconds';
		print'>>--------------';
		
		SET @batch_end_time=GETDATE();
		PRINT'=========================';
		PRINT'Loading Bronze layer is Completed';
		PRINT' - Total Load Duration'+ CAST(DATEDIFF(SECOND,@batch_start_time, @batch_end_time) AS NVARCHAR) + ' Seconds';
		PRINT'=========================';

	  END TRY
	BEGIN CATCH
		PRINT '=================================';
		print 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		print 'ERROR '+ ERROR_MESSAGE();
		print 'ERROR '+ CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT '==================================';
	END CATCH
END
