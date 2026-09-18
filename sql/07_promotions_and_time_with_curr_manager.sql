-- ==============================================================================
-- Query 07: Career Stagnation & Manager Tenure Dynamics
-- Business Question: Does lack of promotions (years since last promotion) or short
-- tenure under a current manager influence flight risk?
-- ==============================================================================

WITH career_matrix AS (
    SELECT 
        employee_id,
        attrition_flag,
        CASE 
            WHEN years_since_last_promotion = 0 THEN '0. Promoted this year'
            WHEN years_since_last_promotion BETWEEN 1 AND 2 THEN '1. 1-2 Yrs Ago'
            WHEN years_since_last_promotion BETWEEN 3 AND 5 THEN '2. 3-5 Yrs Ago'
            ELSE '3. 6+ Yrs Ago (Stagnant)'
        END AS promotion_band,
        CASE 
            WHEN years_with_curr_manager < 1 THEN '0. < 1 Year'
            WHEN years_with_curr_manager BETWEEN 1 AND 2 THEN '1. 1-2 Years'
            WHEN years_with_curr_manager BETWEEN 3 AND 5 THEN '2. 3-5 Years'
            ELSE '3. 6+ Years'
        END AS manager_tenure_band
    FROM employees
)
SELECT 
    promotion_band,
    manager_tenure_band,
    COUNT(*) AS total_employees,
    SUM(attrition_flag) AS leavers,
    ROUND(AVG(attrition_flag) * 100.0, 2) AS attrition_rate_pct
FROM career_matrix
GROUP BY promotion_band, manager_tenure_band
ORDER BY promotion_band ASC, manager_tenure_band ASC;
