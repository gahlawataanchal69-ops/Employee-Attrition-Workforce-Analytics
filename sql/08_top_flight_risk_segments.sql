-- ==============================================================================
-- Query 08: Top Flight-Risk Workforce Segments
-- Business Question: What multi-factor cohorts exhibit the most critical flight
-- risks across the organization (combining role, overtime, income level, and tenure)?
-- ==============================================================================

WITH segmented_cohorts AS (
    SELECT 
        job_role,
        overtime,
        CASE 
            WHEN monthly_income < 3500 THEN 'Low Income (<$3.5k)'
            WHEN monthly_income BETWEEN 3500 AND 7000 THEN 'Mid Income ($3.5k-$7k)'
            ELSE 'High Income (>$7k)'
        END AS income_tier,
        CASE 
            WHEN years_at_company <= 2 THEN 'Early Career (<=2 yrs)'
            WHEN years_at_company <= 5 THEN 'Mid Tenure (3-5 yrs)'
            ELSE 'Tenured (6+ yrs)'
        END AS tenure_tier,
        attrition_flag
    FROM employees
)
SELECT 
    job_role,
    overtime,
    income_tier,
    tenure_tier,
    COUNT(*) AS segment_headcount,
    SUM(attrition_flag) AS segment_leavers,
    ROUND(AVG(attrition_flag) * 100.0, 2) AS attrition_rate_pct
FROM segmented_cohorts
GROUP BY job_role, overtime, income_tier, tenure_tier
HAVING segment_headcount >= 10
ORDER BY attrition_rate_pct DESC, segment_headcount DESC
LIMIT 10;
