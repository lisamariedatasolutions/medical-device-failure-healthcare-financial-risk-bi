/* ==========================================
   06_dashboard_support_queries.sql
   Purpose: Queries for dashboard-ready summary tables
   ========================================== */

USE MedicalDeviceSupplyChainBI;
GO

/* Dashboard summary: device type risk */
SELECT
    device_type,
    COUNT(*) AS device_count,
    SUM(failure_event_count) AS total_failure_events,
    ROUND(SUM(maintenance_cost), 2) AS total_maintenance_cost,
    ROUND(AVG(downtime_hours), 2) AS avg_downtime_hours,
    SUM(CASE WHEN operational_risk_level = 'High' THEN 1 ELSE 0 END) AS high_risk_devices,
    SUM(CASE WHEN replacement_review_flag = 'Review for Replacement' THEN 1 ELSE 0 END) AS replacement_review_count
FROM dbo.medical_device_failure
GROUP BY device_type
ORDER BY total_failure_events DESC;

/* Dashboard summary: manufacturer risk */
SELECT
    manufacturer,
    COUNT(*) AS device_count,
    SUM(failure_event_count) AS total_failure_events,
    ROUND(SUM(maintenance_cost), 2) AS total_maintenance_cost,
    ROUND(AVG(maintenance_cost), 2) AS avg_maintenance_cost,
    ROUND(AVG(downtime_hours), 2) AS avg_downtime_hours,
    SUM(CASE WHEN operational_risk_level = 'High' THEN 1 ELSE 0 END) AS high_risk_devices
FROM dbo.medical_device_failure
GROUP BY manufacturer
ORDER BY total_maintenance_cost DESC;

/* Dashboard summary: operational risk */
SELECT
    operational_risk_level,
    COUNT(*) AS device_count,
    ROUND(SUM(maintenance_cost), 2) AS total_maintenance_cost,
    ROUND(AVG(downtime_hours), 2) AS avg_downtime_hours,
    SUM(failure_event_count) AS total_failure_events
FROM dbo.medical_device_failure
GROUP BY operational_risk_level
ORDER BY 
    CASE operational_risk_level
        WHEN 'Low' THEN 1
        WHEN 'Medium' THEN 2
        WHEN 'High' THEN 3
        ELSE 4
    END;

/* Dashboard summary: financial category */
SELECT
    corrected_expense_category,
    COUNT(*) AS expense_count,
    ROUND(SUM(amount), 2) AS total_amount,
    ROUND(AVG(amount), 2) AS average_amount
FROM dbo.financial_expenses
GROUP BY corrected_expense_category
ORDER BY total_amount DESC;

/* Executive summary query */
SELECT
    COUNT(DISTINCT device_id) AS total_devices,
    SUM(failure_event_count) AS total_failure_events,
    ROUND(SUM(maintenance_cost), 2) AS total_maintenance_cost,
    ROUND(AVG(downtime_hours), 2) AS average_downtime_hours,
    SUM(CASE WHEN operational_risk_level = 'High' THEN 1 ELSE 0 END) AS high_risk_devices,
    SUM(CASE WHEN replacement_review_flag = 'Review for Replacement' THEN 1 ELSE 0 END) AS devices_for_replacement_review
FROM dbo.medical_device_failure;

/* Financial executive summary query */
SELECT
    ROUND(SUM(amount), 2) AS total_financial_expenses,
    ROUND(AVG(amount), 2) AS average_financial_expense,
    COUNT(*) AS expense_record_count
FROM dbo.financial_expenses;