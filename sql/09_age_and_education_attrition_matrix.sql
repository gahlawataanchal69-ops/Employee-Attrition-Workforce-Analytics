-- ==============================================================================
-- Query 09: Demographics Matrix - Age Generations & Education Fields
-- Business Question: How does attrition vary across employee age cohorts and
-- academic backgrounds / fields of study?
-- ==============================================================================

WITH age_segmented AS (
    SELECT 
        employee_id,
        education_field,
        attrition_flag,
        monthly_income,
        CASE 
            WHEN age < 30 THEN '1. Under 30 (Gen Z / Young)'
            WHEN age BETWEEN 30 AND 39 THEN '2. 30-39 (Early/Mid Career)'
            WHEN age BETWEEN 40 AND 49 THEN '3. 40-49 (Experienced)'
            ELSE '4. 50+ (Senior / Veteran)'
        END AS age_cohort
    FROM employees
)
SELECT 
    age_cohort,
    education_field,
    COUNT(*) AS total_employees,
    SUM(attrition_flag) AS leavers_count,
    ROUND(AVG(attrition_flag) * 100.0, 2) AS attrition_rate_pct,
    ROUND(AVG(monthly_income), 2) AS avg_monthly_income
FROM age_segmented
GROUP BY age_cohort, education_field
ORDER BY age_cohort ASC, attrition_rate_pct DESC;
