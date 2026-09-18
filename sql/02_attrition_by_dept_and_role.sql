-- ==============================================================================
-- Query 02: Attrition Rate by Department and Job Role
-- Business Question: Which departments and specific job roles experience the
-- highest turnover rates, and what proportion of total company departures
-- do they represent?
-- ==============================================================================

SELECT 
    department,
    job_role,
    COUNT(*) AS total_headcount,
    SUM(attrition_flag) AS leavers_count,
    COUNT(*) - SUM(attrition_flag) AS retained_count,
    ROUND(AVG(attrition_flag) * 100.0, 2) AS attrition_rate_pct,
    ROUND(
        (SUM(attrition_flag) * 100.0) / (SELECT SUM(attrition_flag) FROM employees), 
        2
    ) AS pct_of_total_company_leavers,
    ROUND(AVG(monthly_income), 2) AS avg_monthly_income,
    ROUND(AVG(years_at_company), 2) AS avg_tenure_years
FROM employees
GROUP BY department, job_role
ORDER BY attrition_rate_pct DESC, total_headcount DESC;
