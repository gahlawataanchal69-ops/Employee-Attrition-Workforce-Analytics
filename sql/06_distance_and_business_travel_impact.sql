-- ==============================================================================
-- Query 06: Commute Distance and Business Travel Impact on Attrition
-- Business Question: How do commute distances (miles from home) and travel frequency
-- compound to accelerate employee departures?
-- ==============================================================================

WITH distance_binned AS (
    SELECT 
        employee_id,
        business_travel,
        distance_from_home,
        attrition_flag,
        CASE 
            WHEN distance_from_home <= 5 THEN '1. Near (1-5 mi)'
            WHEN distance_from_home <= 15 THEN '2. Moderate (6-15 mi)'
            WHEN distance_from_home <= 25 THEN '3. Far (16-25 mi)'
            ELSE '4. Very Far (26+ mi)'
        END AS distance_band
    FROM employees
)
SELECT 
    distance_band,
    business_travel,
    COUNT(*) AS total_employees,
    SUM(attrition_flag) AS leavers,
    ROUND(AVG(attrition_flag) * 100.0, 2) AS attrition_rate_pct
FROM distance_binned
GROUP BY distance_band, business_travel
ORDER BY distance_band ASC, attrition_rate_pct DESC;
