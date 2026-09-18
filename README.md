# Employee Attrition & Workforce Intelligence Analytics

[![SQLite](https://img.shields.io/badge/Database-SQLite%203-003B57?style=flat&logo=sqlite&logoColor=white)](https://www.sqlite.org/)
[![Python](https://img.shields.io/badge/Python-3.9+-3776AB?style=flat&logo=python&logoColor=white)](https://www.python.org/)
[![Pandas](https://img.shields.io/badge/Library-Pandas-150458?style=flat&logo=pandas&logoColor=white)](https://pandas.pydata.org/)
[![Tableau](https://img.shields.io/badge/BI-Tableau%20Ready-E97627?style=flat&logo=tableau&logoColor=white)](https://www.tableau.com/)

> **A portfolio data analytics project demonstrating end-to-end SQL data modeling, exploratory workforce intelligence, Python automated reporting pipelines, and executive BI dashboard architecture.**

---

## 📌 Executive Overview

Voluntary employee turnover imposes substantial direct and indirect costs on enterprises, ranging from replacement recruitment and onboarding overheads to lost institutional knowledge and team burnout.

This project investigates empirical attrition patterns across **1,470 employee records** from the **IBM HR Analytics Employee Attrition & Performance dataset**. By engineering a clean SQLite database, executing a suite of 10 modular analytical SQL queries, and automating summary exports for Tableau BI dashboards, this analysis isolates the exact drivers of flight risk—including compensation disparity, overtime burnout, manager stability, and early-career vulnerability.

---

## 🎯 Key Business Questions Answered

1. **Baseline Turnover**: What is the company-wide voluntary turnover rate, and how do tenure and compensation differ between leavers and retained staff?
2. **Departmental & Role Vulnerability**: Which departments and specific job roles suffer the highest attrition rates and leaver volumes?
3. **Compensation Equity**: What is the real monthly salary gap between employees who leave vs stay across equivalent job levels?
4. **Burnout Dynamics (Overtime & Tenure)**: How severely does mandatory overtime accelerate turnover among new hires vs tenured staff?
5. **Employee Sentiment & Work-Life Balance**: What is the correlation between satisfaction ratings (Job, Environment, Work-Life) and departure rates?
6. **Commute & Travel Friction**: Does business travel frequency combined with long commute distances drive talent away?
7. **Managerial Tenure & Career Velocity**: Does manager turnover or lack of promotion trigger employee exits?
8. **Multi-Factor Flight Risk Segments**: What specific demographic and operational combinations represent the highest flight risk across the workforce?

---

## 📊 Empirical Findings (Derived from Actual Database Records)

All figures below are directly computed from the validated database queries (zero placeholder or fabricated numbers):

### 1. Headline Turnover & Compensation Deficit
- **Total Workforce**: 1,470 employees | **Retained**: 1,233 (83.88%) | **Leavers**: 237 (**16.12% attrition rate**).
- **Tenure Disparity**: Leavers average **5.13 years** of tenure vs **7.37 years** for retained staff (-2.24 years).
- **The $2,045 Compensation Gap**: Employees who leave earn an average of **$4,787.09/month** compared to **$6,832.74/month** for retained peers—a **30.0% income deficit (-$2,045.65/month)**.

### 2. High-Risk Roles & Volume Hotspots
- **Sales Representatives**: Experience the company's highest turnover rate at **39.76%** (33 leavers out of 83 employees).
- **Laboratory Technicians**: Experience **23.94% attrition** and generate the **highest absolute volume of departures** (62 leavers, accounting for **26.16% of all company exits**).
- **Human Resources Specialists**: Exhibit a **23.08% attrition rate** (12 leavers out of 52 employees).

### 3. The Overtime Multiplier & Early-Career Burnout
- Overtime is the single strongest behavioral accelerant of turnover:
  - **Tenure < 1 Year + Overtime**: **71.43% attrition rate** (10 of 14 employees leave).
  - **Tenure < 1 Year + No Overtime**: **20.00% attrition rate** (6 of 30 employees leave).
  - **Tenure 1–2 Years + Overtime**: **47.78% attrition rate** (43 of 90 employees leave).

### 4. Compounded Travel & Commute Friction
- Employees with long commutes (**26+ miles**) who **Travel Frequently** experience **41.18% attrition** (14 of 34), compared to only **3.17%** for near-commute non-travelers.

### 5. Managerial Continuity Matters
- Employees in their first year with a new manager (`< 1 year`) exhibit an attrition rate of **31.10%**, even if they were promoted in the same year—highlighting that manager transitions represent a high flight-risk window.

### 6. Top High-Risk Segment Watchlist
- **Sales Reps + Overtime + Low Income (<$3.5k) + Early Career (<=2 yrs)**: **80.00% attrition rate** (8 of 10 departed).
- **Lab Technicians + Overtime + Low Income (<$3.5k) + Early Career (<=2 yrs)**: **71.43% attrition rate** (15 of 21 departed).

---

## 💡 Strategic Recommendations for HR Leadership

1. **Targeted Overtime Caps for New Hires (<2 Years)**: Implement strict limits on overtime for employees in their first 24 months to address the 71.4% first-year overtime attrition spike.
2. **Compensation Benchmarking for Junior Technical Roles**: Conduct market rate parity adjustments for Level 1 & 2 Laboratory Technicians and Sales Reps earning below $3,500/month.
3. **Manager Onboarding & Transition Support**: Introduce structured 90-day check-ins following manager changes to mitigate the 31.1% turnover observed during leadership transitions.
4. **Hybrid / Remote Commute Flexibility**: Provide remote work options for employees commuting >25 miles who are also required to travel frequently.

---

## 🛠️ Technology Stack

| Layer | Tool / Technology | Purpose |
| :--- | :--- | :--- |
| **Database Engine** | **SQLite 3** | Embedded relational storage, typed schema DDL, indexed queries |
| **Query Language** | **ANSI SQL** | CTEs, window aggregations, conditional filtering, classification matrices |
| **Data Processing** | **Python 3 / Pandas** | Data ingestion, schema validation, automated batch CSV export |
| **Business Intelligence** | **Tableau Desktop / Cloud** | Master extract modeling, LOD calculated fields, interactive dashboards |

---

## 📂 Repository Structure

```
project emp/
├── data/
│   ├── raw_attrition.csv                  # Raw IBM HR Analytics CSV dataset
│   ├── schema.sql                         # DDL with data types, constraints, and indexes
│   └── attrition.db                       # Relational SQLite database
├── sql/
│   ├── 01_overall_attrition_kpis.sql      # Baseline workforce turnover & income KPIs
│   ├── 02_attrition_by_dept_and_role.sql  # Turnover breakdown by dept & job role
│   ├── 03_income_comparison_leavers_vs_stayed.sql  # Salary disparity across levels
│   ├── 04_attrition_by_overtime_and_tenure.sql     # Overtime vs tenure interactions
│   ├── 05_job_satisfaction_and_worklife_balance.sql# Employee sentiment correlation
│   ├── 06_distance_and_business_travel_impact.sql  # Commute & travel compounding risk
│   ├── 07_promotions_and_time_with_curr_manager.sql# Promotion & manager tenure velocity
│   ├── 08_top_flight_risk_segments.sql    # Multi-factor flight-risk cohorts
│   ├── 09_age_and_education_attrition_matrix.sql   # Demographics & education fields
│   └── 10_salary_hike_and_performance_impact.sql   # Compensation hike vs performance
├── scripts/
│   ├── load_data.py                       # Ingestion & database creation script
│   ├── run_queries.py                     # SQL validation suite runner
│   └── export_summaries.py                # Automated CSV & Tableau dataset export
├── exports/
│   ├── tableau_attrition_master.csv       # Flat enriched dataset for BI dashboard (1,470 rows)
│   ├── summary_01_kpis.csv                # Executive KPI summary
│   ├── summary_02_dept_role.csv           # Department & role breakdown summary
│   ├── summary_03_income_comparison.csv   # Income gap summary
│   ├── summary_04_overtime_tenure.csv     # Overtime vs tenure summary
│   ├── summary_05_satisfaction_metrics.csv# Sentiment metrics summary
│   ├── summary_06_distance_travel.csv     # Distance & travel summary
│   ├── summary_07_promotion_manager.csv   # Promotion & manager summary
│   ├── summary_08_flight_risk_segments.csv# High-risk segments summary
│   ├── summary_09_age_education_matrix.csv# Age & education summary
│   └── summary_10_salary_hike_performance.csv # Salary hike summary
├── docs/
│   └── tableau_dashboard_spec.md          # Tableau visual architecture & LOD formulas
└── README.md                              # Portfolio documentation & empirical report
```

---

## 🚀 How to Reproduce & Run

### Prerequisites
- Python 3.8+
- SQLite3 (built into Python standard library)
- Required Python package: `pandas`

```bash
pip install pandas
```

### Step 1: Initialize the Database and Clean Data
Run the ingestion script to download the raw dataset, apply `data/schema.sql`, and populate `data/attrition.db`:
```bash
python scripts/load_data.py
```

### Step 2: Validate the SQL Analytical Suite
Execute all 10 SQL queries against the database and inspect outputs:
```bash
python scripts/run_queries.py
```

### Step 3: Generate Summary Exports & Tableau Master Dataset
Run the export pipeline to generate clean CSV summaries and the enriched Tableau dataset:
```bash
python scripts/export_summaries.py
```

### Step 4: Connect to Tableau / Power BI
1. Open Tableau Desktop or Power BI.
2. Connect to Text File -> Select `exports/tableau_attrition_master.csv`.
3. Follow the blueprint in [`docs/tableau_dashboard_spec.md`](docs/tableau_dashboard_spec.md) to build KPI cards, visual charts, and interactive filters.
