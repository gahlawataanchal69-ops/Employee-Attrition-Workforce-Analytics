-- ==============================================================================
-- Schema: Employee Attrition & Workforce Analytics
-- Database: SQLite (data/attrition.db)
-- Description: Clean, typed DDL for IBM HR Analytics Employee Attrition Dataset
-- ==============================================================================

DROP TABLE IF EXISTS employees;

CREATE TABLE employees (
    employee_id                 INTEGER PRIMARY KEY,
    age                         INTEGER NOT NULL,
    attrition                   TEXT NOT NULL CHECK(attrition IN ('Yes', 'No')),
    attrition_flag              INTEGER NOT NULL CHECK(attrition_flag IN (0, 1)),
    business_travel             TEXT NOT NULL,
    daily_rate                  INTEGER NOT NULL,
    department                  TEXT NOT NULL,
    distance_from_home          INTEGER NOT NULL, -- Distance in miles
    education                   INTEGER NOT NULL CHECK(education BETWEEN 1 AND 5), -- 1: Below College, 2: College, 3: Bachelor, 4: Master, 5: Doctor
    education_field             TEXT NOT NULL,
    environment_satisfaction    INTEGER NOT NULL CHECK(environment_satisfaction BETWEEN 1 AND 4), -- 1: Low, 2: Medium, 3: High, 4: Very High
    gender                      TEXT NOT NULL,
    hourly_rate                 INTEGER NOT NULL,
    job_involvement             INTEGER NOT NULL CHECK(job_involvement BETWEEN 1 AND 4), -- 1: Low, 2: Medium, 3: High, 4: Very High
    job_level                   INTEGER NOT NULL CHECK(job_level BETWEEN 1 AND 5),
    job_role                    TEXT NOT NULL,
    job_satisfaction            INTEGER NOT NULL CHECK(job_satisfaction BETWEEN 1 AND 4), -- 1: Low, 2: Medium, 3: High, 4: Very High
    marital_status              TEXT NOT NULL,
    monthly_income              INTEGER NOT NULL,
    monthly_rate                INTEGER NOT NULL,
    num_companies_worked        INTEGER NOT NULL,
    overtime                    TEXT NOT NULL CHECK(overtime IN ('Yes', 'No')),
    overtime_flag               INTEGER NOT NULL CHECK(overtime_flag IN (0, 1)),
    percent_salary_hike         INTEGER NOT NULL,
    performance_rating          INTEGER NOT NULL CHECK(performance_rating BETWEEN 1 AND 4), -- 1: Low, 2: Good, 3: Excellent, 4: Outstanding
    relationship_satisfaction   INTEGER NOT NULL CHECK(relationship_satisfaction BETWEEN 1 AND 4),
    stock_option_level          INTEGER NOT NULL CHECK(stock_option_level BETWEEN 0 AND 3),
    total_working_years         INTEGER NOT NULL,
    training_times_last_year    INTEGER NOT NULL,
    work_life_balance           INTEGER NOT NULL CHECK(work_life_balance BETWEEN 1 AND 4), -- 1: Bad, 2: Good, 3: Better, 4: Best
    years_at_company            INTEGER NOT NULL,
    years_in_current_role       INTEGER NOT NULL,
    years_since_last_promotion  INTEGER NOT NULL,
    years_with_curr_manager     INTEGER NOT NULL
);

-- Indexes for optimal analytical query performance
CREATE INDEX IF NOT EXISTS idx_emp_dept ON employees(department);
CREATE INDEX IF NOT EXISTS idx_emp_role ON employees(job_role);
CREATE INDEX IF NOT EXISTS idx_emp_attrition ON employees(attrition);
CREATE INDEX IF NOT EXISTS idx_emp_overtime ON employees(overtime);
CREATE INDEX IF NOT EXISTS idx_emp_dept_role ON employees(department, job_role);
