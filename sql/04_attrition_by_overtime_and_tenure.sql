-- ==============================================================================
-- Query 04: Attrition Rate by Overtime Status and Tenure Band
-- Business Question: How does working overtime interact with tenure bands
-- (<1 year, 1-3 years, 3-5 years, 5-10 years, 10+ years) to impact employee turnover?
-- ==============================================================================

WITH tenure_classified AS (
    SELECT 
        employee_id,
        overtime,
        years_at_company,
        attrition_flag,
        monthly_income,
        CASE 
            WHEN years_at_company < 1 THEN '1. < 1 Year'
            WHEN years_at_company BETWEEN 1 AND 2 THEN '2. 1-2 Years'
            WHEN years_at_company BETWEEN 3 AND 5 THEN '3. 3-5 Years'
            WHEN years_at_company BETWEEN 6 AND 10 THEN '4. 6-10 Years'
            ELSE '5. 10+ Years'
        END AS tenure_band
    FROM employees
)
SELECT 
    tenure_band,
    overtime,
    COUNT(*) AS employee_count,
    SUM(attrition_flag) AS leavers_count,
    ROUND(AVG(attrition_flag) * 100.0, 2) AS attrition_rate_pct,
    ROUND(AVG(monthly_income), 2) AS avg_monthly_income
FROM tenure_classified
GROUP BY tenure_band, overtime
ORDER BY tenure_band ASC, overtime DESC;
