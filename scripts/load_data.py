"""
Data Ingestion and Database Initializer Script
Project: Employee Attrition & Workforce Analytics
Description: Cleans raw IBM HR analytics data and populates SQLite database (data/attrition.db).
"""

import os
import sqlite3
import pandas as pd
import urllib.request

DATA_DIR = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'data')
RAW_CSV_PATH = os.path.join(DATA_DIR, 'raw_attrition.csv')
SCHEMA_SQL_PATH = os.path.join(DATA_DIR, 'schema.sql')
DB_PATH = os.path.join(DATA_DIR, 'attrition.db')

DATA_URLS = [
    'https://raw.githubusercontent.com/IBM/employee-attrition-aif360/master/data/emp_attrition.csv',
    'https://raw.githubusercontent.com/datasets/employee-attrition/master/data/WA_Fn-UseC_-HR-Employee-Attrition.csv'
]

COLUMN_MAPPING = {
    'EmployeeNumber': 'employee_id',
    'Age': 'age',
    'Attrition': 'attrition',
    'BusinessTravel': 'business_travel',
    'DailyRate': 'daily_rate',
    'Department': 'department',
    'DistanceFromHome': 'distance_from_home',
    'Education': 'education',
    'EducationField': 'education_field',
    'EnvironmentSatisfaction': 'environment_satisfaction',
    'Gender': 'gender',
    'HourlyRate': 'hourly_rate',
    'JobInvolvement': 'job_involvement',
    'JobLevel': 'job_level',
    'JobRole': 'job_role',
    'JobSatisfaction': 'job_satisfaction',
    'MaritalStatus': 'marital_status',
    'MonthlyIncome': 'monthly_income',
    'MonthlyRate': 'monthly_rate',
    'NumCompaniesWorked': 'num_companies_worked',
    'OverTime': 'overtime',
    'PercentSalaryHike': 'percent_salary_hike',
    'PerformanceRating': 'performance_rating',
    'RelationshipSatisfaction': 'relationship_satisfaction',
    'StockOptionLevel': 'stock_option_level',
    'TotalWorkingYears': 'total_working_years',
    'TrainingTimesLastYear': 'training_times_last_year',
    'WorkLifeBalance': 'work_life_balance',
    'YearsAtCompany': 'years_at_company',
    'YearsInCurrentRole': 'years_in_current_role',
    'YearsSinceLastPromotion': 'years_since_last_promotion',
    'YearsWithCurrManager': 'years_with_curr_manager'
}

def ensure_raw_data():
    """Ensure raw dataset is present on disk, downloading if necessary."""
    if os.path.exists(RAW_CSV_PATH) and os.path.getsize(RAW_CSV_PATH) > 1000:
        print(f"[INFO] Raw dataset already exists at {RAW_CSV_PATH}")
        return

    print("[INFO] Fetching IBM HR Dataset from public repository...")
    for url in DATA_URLS:
        try:
            print(f"Trying {url}...")
            urllib.request.urlretrieve(url, RAW_CSV_PATH)
            if os.path.exists(RAW_CSV_PATH) and os.path.getsize(RAW_CSV_PATH) > 1000:
                print("[SUCCESS] Dataset downloaded successfully.")
                return
        except Exception as e:
            print(f"[WARNING] Download failed for {url}: {e}")

    raise FileNotFoundError("Could not acquire raw dataset.")

def clean_data(df: pd.DataFrame) -> pd.DataFrame:
    """Normalize column names, handle types, and compute helper flags."""
    # Retain only recognized columns
    cols_to_keep = [col for col in COLUMN_MAPPING.keys() if col in df.columns]
    cleaned_df = df[cols_to_keep].copy()
    cleaned_df.rename(columns=COLUMN_MAPPING, inplace=True)

    # Compute binary indicator flags
    cleaned_df['attrition_flag'] = cleaned_df['attrition'].apply(lambda x: 1 if str(x).strip().lower() == 'yes' else 0)
    cleaned_df['overtime_flag'] = cleaned_df['overtime'].apply(lambda x: 1 if str(x).strip().lower() == 'yes' else 0)

    # Reorder columns to match schema.sql definition exactly
    ordered_cols = [
        'employee_id', 'age', 'attrition', 'attrition_flag', 'business_travel',
        'daily_rate', 'department', 'distance_from_home', 'education',
        'education_field', 'environment_satisfaction', 'gender', 'hourly_rate',
        'job_involvement', 'job_level', 'job_role', 'job_satisfaction',
        'marital_status', 'monthly_income', 'monthly_rate', 'num_companies_worked',
        'overtime', 'overtime_flag', 'percent_salary_hike', 'performance_rating',
        'relationship_satisfaction', 'stock_option_level', 'total_working_years',
        'training_times_last_year', 'work_life_balance', 'years_at_company',
        'years_in_current_role', 'years_since_last_promotion', 'years_with_curr_manager'
    ]
    return cleaned_df[ordered_cols]

def init_sqlite_db():
    """Initializes the database schema and loads cleaned records."""
    ensure_raw_data()
    raw_df = pd.read_csv(RAW_CSV_PATH)
    print(f"[INFO] Loaded raw CSV with {len(raw_df)} rows and {len(raw_df.columns)} columns.")

    cleaned_df = clean_data(raw_df)
    print(f"[INFO] Cleaned data shape: {cleaned_df.shape}")

    # Remove existing DB file for a clean rebuild
    if os.path.exists(DB_PATH):
        os.remove(DB_PATH)

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # Apply schema DDL
    with open(SCHEMA_SQL_PATH, 'r', encoding='utf-8') as f:
        schema_sql = f.read()
    cursor.executescript(schema_sql)
    print(f"[INFO] Applied schema DDL from {SCHEMA_SQL_PATH}")

    # Insert data
    cleaned_df.to_sql('employees', conn, if_exists='append', index=False)
    conn.commit()

    # Verification checks
    cursor.execute("SELECT COUNT(*) FROM employees")
    total_count = cursor.fetchone()[0]
    cursor.execute("SELECT COUNT(*) FROM employees WHERE attrition = 'Yes'")
    attrition_count = cursor.fetchone()[0]
    cursor.execute("SELECT AVG(monthly_income) FROM employees")
    avg_income = cursor.fetchone()[0]

    print("\n--- DATABASE VERIFICATION REPORT ---")
    print(f"Database Location: {DB_PATH}")
    print(f"Total Employees Loaded: {total_count}")
    print(f"Total Leavers (Attrition = Yes): {attrition_count} ({attrition_count/total_count*100:.2f}%)")
    print(f"Active Employees (Attrition = No): {total_count - attrition_count} ({(total_count-attrition_count)/total_count*100:.2f}%)")
    print(f"Average Monthly Income: ${avg_income:,.2f}")
    print("------------------------------------\n")

    conn.close()

if __name__ == '__main__':
    init_sqlite_db()
