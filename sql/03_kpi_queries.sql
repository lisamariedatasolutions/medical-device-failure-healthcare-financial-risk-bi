 ==========================================
  -- 03_kpi_queries.sql
  -- Purpose: Main KPI queries for dashboard and reporting
   ========================================== */


 USE MedicalDeviceSupplyChainBI;
GO

   --KPI 1: Total devices
SELECT
    COUNT(DISTINCT device_id) AS total_devices
 FROM dbo.medical_device_failure;


 --KPI 2: Total failure events
 SELECT
    SUM(failure_event_count) AS total_failure_events
FROM dbo.medical_device_failure;


--KPI 3: Devices w failure reported
SELECT
    SUM(CASE WHEN failure_flag = 1 THEN 1 ELSE 0 END ) AS devices_with_failure_reported
FROM dbo.medical_device_failure;


--KPI 4: Avg downtime
SELECT
    ROUND(AVG(downtime_hours),2) AS average_downtime_hours
    FROM dbo.medical_device_failure;


    --KPI 5: Avg maintenance cost
SELECT
    ROUND(AVG(maintenance_cost),2) AS average_mainenance_cost
 FROM dbo.medical_device_failure;


     --KPI 6: Total maintenance cost
SELECT
    ROUND(SUM(maintenance_cost),2) AS average_mainenance_cost
 FROM dbo.medical_device_failure;


--KPI 7 : High risk devices
SELECT
    COUNT(*) AS high_risk_devices
 FROM dbo.medical_device_failure
 WHERE operational_risk_level = 'High';


 --KPI 8 : Devices for replacement review
 SELECT
    COUNT(*) AS devices_for_replacement_review
FROM dbo.medical_device_failure
WHERE replacement_review_flag = 'Review for replacement';


--KPI 9: Total financial expenses
SELECT
    ROUND(SUM(amount),2 AS total_financial_expenses
FROM dbo.financial_expenses;


--KPI 10: Avg financial expense
SELECT
    ROUND(AVG(amount),2) AS avg_financial_expense
    FROM dbo.financial_expenses;




  --Combined KPI Summary
SELECT
    COUNT(DISTINCT device_id) AS total_devices,
    SUM(failure_event_count) AS total_failure_Events,
    SUM(CASE WHEN failure_flag = 1 THEN 1  ELSE 0 END) AS devices_with_failure_reported,
    ROUND(AVG(downtime_hours),2) AS average_downtime_hours,
    ROUND(SUM(maintenance_cost),2) AS average_maintenace_cost,
    ROUND(SUM(maintenance_cost),2) AS total_maintenance_cost
FROM dbo.medical_device_failure;



SELECT
    ROUND(SUM(amount),2) AS total_financial_expenses,
    ROUND(AVG(amount),2) AS avg_financial_expense
FROM dbo.financial_expenses;



    