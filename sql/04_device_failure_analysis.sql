/* ==========================================
   04_device_failure_analysis.sql
   Purpose: Device failure, downtime, manufacturer, and risk analysis
   ========================================== */

USE MedicalDeviceSupplyChainBI;
GO

/* Device type summary */
SELECT
    device_type,
    COUNT(*) AS device_count,
    SUM(failure_event_count) AS total_failure_events,
    ROUND(AVG(CAST(failure_event_count AS FLOAT)), 2) AS avg_failure_events,
    ROUND(SUM(maintenance_cost), 2) AS total_maintenance_cost,
    ROUND(AVG(maintenance_cost), 2) AS avg_maintenance_cost,
    ROUND(AVG(downtime_hours), 2) AS avg_downtime_hours,
    SUM(CASE WHEN operational_risk_level = 'High' THEN 1 ELSE 0 END) AS high_risk_devices,
    SUM(CASE WHEN replacement_review_flag = 'Review for Replacement' THEN 1 ELSE 0 END) AS replacement_review_count
FROM dbo.medical_device_failure
GROUP BY device_type
ORDER BY total_failure_events DESC;

/* Manufacturer maintenance cost summary */
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

/* Failure type summary */
SELECT
    failure_type,
    COUNT(*) AS record_count,
    SUM(failure_event_count) AS total_failure_events,
    ROUND(AVG(maintenance_cost), 2) AS avg_maintenance_cost,
    ROUND(AVG(downtime_hours), 2) AS avg_downtime_hours
FROM dbo.medical_device_failure
GROUP BY failure_type
ORDER BY record_count DESC;

/* Risk level summary */
SELECT
    operational_risk_level,
    COUNT(*) AS device_count,
    SUM(failure_event_count) AS total_failure_events,
    ROUND(SUM(maintenance_cost), 2) AS total_maintenance_cost,
    ROUND(AVG(maintenance_cost), 2) AS avg_maintenance_cost,
    ROUND(AVG(downtime_hours), 2) AS avg_downtime_hours
FROM dbo.medical_device_failure
GROUP BY operational_risk_level
ORDER BY 
    CASE operational_risk_level
        WHEN 'Low' THEN 1
        WHEN 'Medium' THEN 2
        WHEN 'High' THEN 3
        ELSE 4
    END;

/* Replacement review summary */
SELECT
    replacement_review_flag,
    COUNT(*) AS device_count,
    SUM(failure_event_count) AS total_failure_events,
    ROUND(SUM(maintenance_cost), 2) AS total_maintenance_cost,
    ROUND(AVG(maintenance_cost), 2) AS avg_maintenance_cost,
    ROUND(AVG(downtime_hours), 2) AS avg_downtime_hours
FROM dbo.medical_device_failure
GROUP BY replacement_review_flag
ORDER BY device_count DESC;

/* Top 10 highest cost devices */
SELECT TOP 10
    device_id,
    device_type,
    manufacturer,
    model,
    age,
    maintenance_cost,
    downtime_hours,
    failure_event_count,
    maintenance_severity,
    operational_risk_level,
    replacement_review_flag
FROM dbo.medical_device_failure
ORDER BY maintenance_cost DESC;

/* Top 10 highest downtime devices */
SELECT TOP 10
    device_id,
    device_type,
    manufacturer,
    model,
    age,
    maintenance_cost,
    downtime_hours,
    failure_event_count,
    maintenance_severity,
    operational_risk_level,
    replacement_review_flag
FROM dbo.medical_device_failure
ORDER BY downtime_hours DESC;

/* Devices needing replacement review */
SELECT
    device_id,
    device_type,
    manufacturer,
    model,
    age,
    maintenance_cost,
    downtime_hours,
    failure_event_count,
    risk_score,
    operational_risk_level,
    replacement_review_flag
FROM dbo.medical_device_failure
WHERE replacement_review_flag = 'Review for Replacement'
ORDER BY risk_score DESC, maintenance_cost DESC;