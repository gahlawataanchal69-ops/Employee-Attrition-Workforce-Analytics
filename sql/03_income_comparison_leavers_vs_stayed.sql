-- ==============================================================================
-- Query 03: Income Disparity Analysis - Leavers vs Retained Employees
-- Business Question: How does average monthly compensation differ between
-- employees who left versus those who stayed across job roles and job levels,
-- and where are the most severe income deficits observed?
-- ==============================================================================

SELECT 
    job_role,
    job_level,
    COUNT(*) AS total_employees,
    SUM(attrition_flag) AS leavers,
    ROUND(AVG(CASE WHEN attrition = 'No' THEN monthly_income END), 2) AS avg_income_retained,
    ROUND(AVG(CASE WHEN attrition = 'Yes' THEN monthly_income END), 2) AS avg_income_leavers,
    ROUND(
        AVG(CASE WHEN attrition = 'No' THEN monthly_income END) - 
        AVG(CASE WHEN attrition = 'Yes' THEN monthly_income END), 
        2
    ) AS income_gap_retained_vs_leavers,
    ROUND(
        ((AVG(CASE WHEN attrition = 'No' THEN monthly_income END) - 
          AVG(CASE WHEN attrition = 'Yes' THEN monthly_income END)) / 
          NULLIF(AVG(CASE WHEN attrition = 'No' THEN monthly_income END), 0)) * 100.0,
        2
    ) AS pct_income_deficit_leavers
FROM employees
GROUP BY job_role, job_level
HAVING leavers > 0
ORDER BY pct_income_deficit_leavers DESC, total_employees DESC;
