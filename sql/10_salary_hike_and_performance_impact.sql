-- ==============================================================================
-- Query 10: Salary Hike Percentage & Performance Rating Impact
-- Business Question: Are top performers receiving adequate salary increments,
-- and does a smaller compensation hike trigger higher departure rates?
-- ==============================================================================

WITH hike_tiered AS (
    SELECT 
        employee_id,
        performance_rating,
        percent_salary_hike,
        attrition_flag,
        CASE 
            WHEN percent_salary_hike < 14 THEN '1. Low Hike (11-13%)'
            WHEN percent_salary_hike BETWEEN 14 AND 18 THEN '2. Moderate Hike (14-18%)'
            ELSE '3. High Hike (19-25%)'
        END AS hike_tier,
        CASE performance_rating
            WHEN 3 THEN '3 - Excellent'
            WHEN 4 THEN '4 - Outstanding'
            ELSE CAST(performance_rating AS TEXT)
        END AS performance_label
    FROM employees
)
SELECT 
    performance_label,
    hike_tier,
    COUNT(*) AS total_employees,
    SUM(attrition_flag) AS leavers,
    ROUND(AVG(attrition_flag) * 100.0, 2) AS attrition_rate_pct,
    ROUND(AVG(percent_salary_hike), 2) AS avg_actual_hike_pct
FROM hike_tiered
GROUP BY performance_label, hike_tier
ORDER BY performance_label ASC, hike_tier ASC;
