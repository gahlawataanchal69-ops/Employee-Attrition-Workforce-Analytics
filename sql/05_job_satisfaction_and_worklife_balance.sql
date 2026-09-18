-- ==============================================================================
-- Query 05: Job Satisfaction, Environment, and Work-Life Balance Correlation
-- Business Question: What is the empirical relationship between employee sentiment
-- ratings (Job Satisfaction, Environment Satisfaction, Work-Life Balance) and turnover?
-- ==============================================================================

SELECT 
    'Job Satisfaction' AS metric_category,
    job_satisfaction AS rating_score,
    CASE job_satisfaction 
        WHEN 1 THEN 'Low' 
        WHEN 2 THEN 'Medium' 
        WHEN 3 THEN 'High' 
        WHEN 4 THEN 'Very High' 
    END AS rating_label,
    COUNT(*) AS total_headcount,
    SUM(attrition_flag) AS leavers,
    ROUND(AVG(attrition_flag) * 100.0, 2) AS attrition_rate_pct
FROM employees
GROUP BY job_satisfaction

UNION ALL

SELECT 
    'Environment Satisfaction' AS metric_category,
    environment_satisfaction AS rating_score,
    CASE environment_satisfaction 
        WHEN 1 THEN 'Low' 
        WHEN 2 THEN 'Medium' 
        WHEN 3 THEN 'High' 
        WHEN 4 THEN 'Very High' 
    END AS rating_label,
    COUNT(*) AS total_headcount,
    SUM(attrition_flag) AS leavers,
    ROUND(AVG(attrition_flag) * 100.0, 2) AS attrition_rate_pct
FROM employees
GROUP BY environment_satisfaction

UNION ALL

SELECT 
    'Work-Life Balance' AS metric_category,
    work_life_balance AS rating_score,
    CASE work_life_balance 
        WHEN 1 THEN 'Bad' 
        WHEN 2 THEN 'Good' 
        WHEN 3 THEN 'Better' 
        WHEN 4 THEN 'Best' 
    END AS rating_label,
    COUNT(*) AS total_headcount,
    SUM(attrition_flag) AS leavers,
    ROUND(AVG(attrition_flag) * 100.0, 2) AS attrition_rate_pct
FROM employees
GROUP BY work_life_balance

ORDER BY metric_category, rating_score ASC;
