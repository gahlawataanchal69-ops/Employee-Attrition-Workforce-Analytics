-- ==============================================================================
-- Query 01: Overall Workforce Attrition & Retention KPIs
-- Business Question: What is the organization-wide baseline headcount, voluntary
-- turnover rate, retained headcount, average tenure of leavers vs stayers,
-- and average monthly compensation?
-- ==============================================================================

SELECT 
    COUNT(*) AS total_employees,
    SUM(attrition_flag) AS total_leavers,
    COUNT(*) - SUM(attrition_flag) AS total_retained,
    ROUND(AVG(attrition_flag) * 100.0, 2) AS overall_attrition_rate_pct,
    ROUND(AVG(CASE WHEN attrition = 'Yes' THEN years_at_company END), 2) AS avg_tenure_leavers_years,
    ROUND(AVG(CASE WHEN attrition = 'No' THEN years_at_company END), 2) AS avg_tenure_retained_years,
    ROUND(AVG(CASE WHEN attrition = 'Yes' THEN monthly_income END), 2) AS avg_monthly_income_leavers,
    ROUND(AVG(CASE WHEN attrition = 'No' THEN monthly_income END), 2) AS avg_monthly_income_retained,
    ROUND(AVG(monthly_income), 2) AS avg_monthly_income_all
FROM employees;
