"""
SQL Query Suite Runner and Validator
Project: Employee Attrition & Workforce Analytics
Description: Executes all 10 SQL query files in /sql against data/attrition.db and formats results.
"""

import os
import sqlite3
import pandas as pd

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, 'data', 'attrition.db')
SQL_DIR = os.path.join(PROJECT_ROOT, 'sql')

def run_all_queries():
    if not os.path.exists(DB_PATH):
        raise FileNotFoundError(f"Database not found at {DB_PATH}. Run scripts/load_data.py first.")

    conn = sqlite3.connect(DB_PATH)
    sql_files = sorted([f for f in os.listdir(SQL_DIR) if f.endswith('.sql')])

    print(f"================================================================")
    print(f"EXECUTING & VALIDATING {len(sql_files)} SQL ANALYTICAL QUERIES")
    print(f"Database: {DB_PATH}")
    print(f"================================================================\n")

    for i, sql_file in enumerate(sql_files, 1):
        file_path = os.path.join(SQL_DIR, sql_file)
        with open(file_path, 'r', encoding='utf-8') as f:
            query_sql = f.read()

        print(f"[{i}/{len(sql_files)}] Running: {sql_file}")
        try:
            df_result = pd.read_sql_query(query_sql, conn)
            print(f"  --> Status: OK | Rows Returned: {len(df_result)} | Columns: {list(df_result.columns)}")
            print(f"  --> Preview:\n{df_result.head(3).to_string(index=False)}\n")
        except Exception as e:
            print(f"  --> [ERROR] Failed executing {sql_file}: {e}\n")
            conn.close()
            raise e

    conn.close()
    print("All SQL queries executed and validated successfully!")

if __name__ == '__main__':
    run_all_queries()
