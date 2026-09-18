"""
Export Pipeline and Tableau Dataset Generator
Project: Employee Attrition & Workforce Analytics
Description: Runs analysis queries against SQLite attrition.db and generates:
  1. Modular summary CSVs for executive reporting in /exports
  2. A fully enriched, Tableau-ready flat master dataset (exports/tableau_attrition_master.csv)
"""

import os
import sqlite3
import pandas as pd

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, 'data', 'attrition.db')
SQL_DIR = os.path.join(PROJECT_ROOT, 'sql')
EXPORTS_DIR = os.path.join(PROJECT_ROOT, 'exports')

def export_sql_summaries(conn: sqlite3.Connection):
    """Executes each SQL file in /sql and exports individual summary CSVs."""
    print("--> Exporting individual analytical summary CSVs...")
    sql_files = sorted([f for f in os.listdir(SQL_DIR) if f.endswith('.sql')])

    export_map = {
        '01_overall_attrition_kpis.sql': 'summary_01_kpis.csv',
        '02_attrition_by_dept_and_role.sql': 'summary_02_dept_role.csv',
        '03_income_comparison_leavers_vs_stayed.sql': 'summary_03_income_comparison.csv',
        '04_attrition_by_overtime_and_tenure.sql': 'summary_04_overtime_tenure.csv',
        '05_job_satisfaction_and_worklife_balance.sql': 'summary_05_satisfaction_metrics.csv',
        '06_distance_and_business_travel_impact.sql': 'summary_06_distance_travel.csv',
        '07_promotions_and_time_with_curr_manager.sql': 'summary_07_promotion_manager.csv',
        '08_top_flight_risk_segments.sql': 'summary_08_flight_risk_segments.csv',
        '09_age_and_education_attrition_matrix.sql': 'summary_09_age_education_matrix.csv',
        '10_salary_hike_and_performance_impact.sql': 'summary_10_salary_hike_performance.csv'
    }

    for sql_file, output_csv in export_map.items():
        sql_path = os.path.join(SQL_DIR, sql_file)
        if not os.path.exists(sql_path):
            continue
        with open(sql_path, 'r', encoding='utf-8') as f:
            query_sql = f.read()

        df = pd.read_sql_query(query_sql, conn)
        target_path = os.path.join(EXPORTS_DIR, output_csv)
        df.to_csv(target_path, index=False)
        print(f"    Exported: {output_csv} ({len(df)} rows)")

def generate_tableau_master_dataset(conn: sqlite3.Connection):
    """
    Generates a denormalized, presentation-ready flat CSV file for Tableau/BI tools
    with standardized metric labels, binned dimensions, and categorical groupings.
    """
    print("\n--> Generating Tableau Master Flat Dataset...")
    query = """
    SELECT 
        employee_id,
        age,
        CASE 
            WHEN age < 30 THEN 'Under 30'
            WHEN age BETWEEN 30 AND 39 THEN '30-39'
            WHEN age BETWEEN 40 AND 49 THEN '40-49'
            ELSE '50+'
        END AS age_cohort,
        gender,
        marital_status,
        department,
        job_role,
        job_level,
        education,
        CASE education
            WHEN 1 THEN '1 - Below College'
            WHEN 2 THEN '2 - College'
            WHEN 3 THEN '3 - Bachelor'
            WHEN 4 THEN '4 - Master'
            WHEN 5 THEN '5 - Doctor'
        END AS education_label,
        education_field,
        monthly_income,
        CASE 
            WHEN monthly_income < 3500 THEN 'Low (<$3,500)'
            WHEN monthly_income BETWEEN 3500 AND 7000 THEN 'Mid ($3,500 - $7,000)'
            WHEN monthly_income BETWEEN 7001 AND 12000 THEN 'High ($7,001 - $12,000)'
            ELSE 'Executive (>$12,000)'
        END AS income_bracket,
        daily_rate,
        hourly_rate,
        monthly_rate,
        percent_salary_hike,
        stock_option_level,
        overtime,
        overtime_flag,
        business_travel,
        distance_from_home,
        CASE 
            WHEN distance_from_home <= 5 THEN 'Near (1-5 mi)'
            WHEN distance_from_home <= 15 THEN 'Moderate (6-15 mi)'
            WHEN distance_from_home <= 25 THEN 'Far (16-25 mi)'
            ELSE 'Very Far (26+ mi)'
        END AS distance_band,
        job_satisfaction,
        CASE job_satisfaction 
            WHEN 1 THEN '1 - Low' 
            WHEN 2 THEN '2 - Medium' 
            WHEN 3 THEN '3 - High' 
            WHEN 4 THEN '4 - Very High' 
        END AS job_satisfaction_label,
        environment_satisfaction,
        CASE environment_satisfaction 
            WHEN 1 THEN '1 - Low' 
            WHEN 2 THEN '2 - Medium' 
            WHEN 3 THEN '3 - High' 
            WHEN 4 THEN '4 - Very High' 
        END AS environment_satisfaction_label,
        relationship_satisfaction,
        CASE relationship_satisfaction 
            WHEN 1 THEN '1 - Low' 
            WHEN 2 THEN '2 - Medium' 
            WHEN 3 THEN '3 - High' 
            WHEN 4 THEN '4 - Very High' 
        END AS relationship_satisfaction_label,
        work_life_balance,
        CASE work_life_balance 
            WHEN 1 THEN '1 - Bad' 
            WHEN 2 THEN '2 - Good' 
            WHEN 3 THEN '3 - Better' 
            WHEN 4 THEN '4 - Best' 
        END AS work_life_balance_label,
        job_involvement,
        performance_rating,
        CASE performance_rating
            WHEN 3 THEN '3 - Excellent'
            WHEN 4 THEN '4 - Outstanding'
        END AS performance_label,
        total_working_years,
        years_at_company,
        CASE 
            WHEN years_at_company < 1 THEN '< 1 Year'
            WHEN years_at_company BETWEEN 1 AND 2 THEN '1-2 Years'
            WHEN years_at_company BETWEEN 3 AND 5 THEN '3-5 Years'
            WHEN years_at_company BETWEEN 6 AND 10 THEN '6-10 Years'
            ELSE '10+ Years'
        END AS tenure_band,
        years_in_current_role,
        years_since_last_promotion,
        years_with_curr_manager,
        training_times_last_year,
        num_companies_worked,
        attrition,
        attrition_flag
    FROM employees
    """
    master_df = pd.read_sql_query(query, conn)
    master_path = os.path.join(EXPORTS_DIR, 'tableau_attrition_master.csv')
    master_df.to_csv(master_path, index=False)
    print(f"    Exported: tableau_attrition_master.csv ({len(master_df)} rows, {len(master_df.columns)} columns)")

def main():
    os.makedirs(EXPORTS_DIR, exist_ok=True)
    if not os.path.exists(DB_PATH):
        raise FileNotFoundError(f"Database not found at {DB_PATH}")

    conn = sqlite3.connect(DB_PATH)
    print("================================================================")
    print("RUNNING EXPORT PIPELINE FOR TABLEAU & BI DASHBOARDING")
    print(f"Target Directory: {EXPORTS_DIR}")
    print("================================================================")

    export_sql_summaries(conn)
    generate_tableau_master_dataset(conn)

    conn.close()
    print("\nExport pipeline completed successfully!")

if __name__ == '__main__':
    main()
