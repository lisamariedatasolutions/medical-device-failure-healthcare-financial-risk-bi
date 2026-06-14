/* ==========================================
   02_validation_queries.sql
   Purpose: Validate imported SQL tables
   ========================================== */

USE MedicalDeviceSupplyChainBI;
GO

   --Preview device table
   SELECT TOP 10 *
FROM dbo.medical_device_failure;

--Preview financial table
SELECT TOP 10*
FROM dbo.financial_expenses;




--Row Couont Validation
SELECT 
	'Medical Device Failure' AS	dataset_name,
	COUNT(*) AS row_count
	FROM dbo.medical_device_failure

UNION ALL

SELECT
	'Financial Expenses' AS	dataset_name,
	COUNT(*) AS row_count
	FROM dbo.financial_expenses;




--Check duplicate device IDs
SELECT
	device_id,
	COUNT(*) AS	record_count
FROM dbo.medical_device_failure
GROUP BY device_id 
HAVING COUNT(*) > 1;




--Check for missing values

--device fields
SELECT
	SUM(CASE WHEN device_id IS NULL THEN 1 ELSE 0 END) AS missing_device_id,
	SUM(CASE WHEN device_type IS NULL THEN 1 ELSE 0 END) AS missing_device_type,
	SUM(CASE WHEN manufacturer IS NULL THEN 1 ELSE 0 END) AS missing_maunfacturer,
	SUM(CASE WHEN maintenance_cost IS NULL THEN 1 ELSE 0 END) AS missing_maintenance_cost,
	SUM(CASE WHEN downtime_hours IS NULL THEN 1 ELSE 0 END) AS missing_downtime_hours,
	SUM(CASE WHEN operational_risk_level IS NULL THEN 1 ELSE 0 END) AS missing_risk_level
FROM dbo.medical_device_failure;


--financial fields
SELECT
	SUM(CASE WHEN date IS  NULL THEN 1 ELSE 0 END ) AS missing_date,
	SUM(CASE WHEN corrected_expense_category IS NULL THEN 1 ELSE 0 END) AS missing_corrected_category,
	SUM(CASE WHEN amount IS NULL THEN 1 ELSE 0 END) AS missing_amount,
	SUM(CASE WHEN description IS NULL THEN 1 ELSE 0 END) AS missing_description
FROM dbo.financial_expenses;



--Check category values
SELECT
	operational_risk_level,
	COUNT(*) AS record_count

FROM dbo.medical_device_failure
GROUP BY operational_risk_level
ORDER BY record_count DESC;


--Check financial corrected categories
SELECT
	corrected_expense_category,
	COUNT(*) AS record_count

FROM dbo.financial_expenses
GROUP BY corrected_expense_category
ORDER BY record_count DESC;
