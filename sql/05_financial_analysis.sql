/* ==========================================
   05_financial_analysis.sql
   Purpose: Financial expense analysis
   ========================================== */

USE MedicalDeviceSupplyChainBI;
GO

/* Financial expense summary by corrected category */
SELECT
    corrected_expense_category,
    COUNT(*) AS expense_count,
    ROUND(SUM(amount), 2) AS total_amount,
    ROUND(AVG(amount), 2) AS average_amount,
    ROUND(MIN(amount), 2) AS min_amount,
    ROUND(MAX(amount), 2) AS max_amount
FROM dbo.financial_expenses
GROUP BY corrected_expense_category
ORDER BY total_amount DESC;

/* Monthly financial expense trend */
SELECT
    expense_month_year,
    COUNT(*) AS expense_count,
    ROUND(SUM(amount), 2) AS total_amount,
    ROUND(AVG(amount), 2) AS average_amount
FROM dbo.financial_expenses
GROUP BY expense_month_year
ORDER BY expense_month_year;

/* Expense description summary */
SELECT
    description,
    corrected_expense_category,
    COUNT(*) AS expense_count,
    ROUND(SUM(amount), 2) AS total_amount,
    ROUND(AVG(amount), 2) AS average_amount
FROM dbo.financial_expenses
GROUP BY description, corrected_expense_category
ORDER BY total_amount DESC;

/* Category correction validation */
SELECT
    expense_category_validation_flag,
    COUNT(*) AS record_count
FROM dbo.financial_expenses
GROUP BY expense_category_validation_flag
ORDER BY record_count DESC;

/* Original vs corrected category comparison */
SELECT
    expense_category,
    corrected_expense_category,
    COUNT(*) AS record_count,
    ROUND(SUM(amount), 2) AS total_amount
FROM dbo.financial_expenses
GROUP BY expense_category, corrected_expense_category
ORDER BY expense_category, corrected_expense_category;

/* Top 10 largest financial expenses */
SELECT TOP 10
    date,
    expense_month_year,
    expense_category,
    corrected_expense_category,
    amount,
    description
FROM dbo.financial_expenses
ORDER BY amount DESC;