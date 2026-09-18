# 🏢 Employee Attrition & Workforce Intelligence Analytics
### *Uncovering the Root Causes of Turnover & Designing Data-Driven Retention Strategies*

![SQL](https://img.shields.io/badge/Database-SQLite%203-003B57?style=for-the-badge&logo=sqlite&logoColor=white)
![Python](https://img.shields.io/badge/Python-3.9+-3776AB?style=for-the-badge&logo=python&logoColor=white)
![Pandas](https://img.shields.io/badge/Data%20Pipeline-Pandas-150458?style=for-the-badge&logo=pandas&logoColor=white)
![Tableau](https://img.shields.io/badge/BI%20Dashboard-Tableau%20Ready-E97627?style=for-the-badge&logo=tableau&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

---

## 📖 Executive Summary

Voluntary employee turnover is one of the costliest blind spots in corporate talent management. Beyond the immediate disruption to operations, replacing a skilled employee typically costs **50% to 200% of their annual salary** in recruitment, onboarding downtime, and lost institutional knowledge.

This project delivers an end-to-end **Workforce Intelligence & Attrition Analysis** built upon the **IBM HR Analytics dataset (1,470 records across 35 workforce dimensions)**. Combining relational SQLite database modeling, a modular 10-query SQL analytics suite, Python ETL automation, and executive Tableau BI specifications, this study isolates the exact drivers behind why employees leave and equips HR leaders with empirical, high-ROI retention interventions.

```
                    ┌─────────────────────────┐
                    │  1,470 Total Employees  │
                    └────────────┬────────────┘
                                 │
                 ┌───────────────┴───────────────┐
                 ▼                               ▼
     ┌───────────────────────┐       ┌───────────────────────┐
     │ 1,233 Retained (83.9%)│       │  237 Leavers (16.1%)  │
     │ Avg Salary: $6,833/mo │       │ Avg Salary: $4,787/mo │
     │ Avg Tenure: 7.37 Yrs  │       │ Avg Tenure: 5.13 Yrs  │
     └───────────────────────┘       └───────────────────────┘
```

---

## 🎯 Key Business Questions Addressed

1. **Macro Turnover**: What is the company-wide baseline voluntary attrition rate, and what is the financial compensation gap between leavers and retained peers?
2. **Department & Role Hotspots**: Which teams experience critical flight risk, and where is the greatest absolute talent drain concentrated?
3. **Pay Parity & Compression**: Are employees leaving due to systemic pay disparities across equivalent seniority levels?
4. **The Overtime Burnout Spiral**: How severely does mandatory overtime accelerate turnover among new hires vs tenured staff?
5. **Employee Sentiment & Work-Life Dynamics**: How strongly do low satisfaction scores (job, environment, work-life balance) correlate with departure rates?
6. **Commute & Travel Friction**: What is the compounded impact of frequent business travel paired with long commutes?
7. **Managerial Continuity**: Does leadership instability (e.g. new managers) trigger flight risk even after promotions?
8. **High-Risk Segment Profiles**: Which multi-variable employee segments exhibit extreme (>70%) flight risk?

---

## 🔍 Core Analytical Findings (100% Empirically Verified)

All findings below were computed directly through deterministic SQL queries against [`data/attrition.db`](data/attrition.db):

### 1. 💰 The $2,045 Monthly Compensation Gap
Employees who voluntarily depart earn an average of **$4,787.09/month** compared to **$6,832.74/month** for employees who stay—representing an organizational **30.0% salary deficit (-$2,045.65/month)**.
- Across junior roles (Job Level 1 & 2), leavers consistently sit in the lowest quartile of compensation within their grade.
- In entry-level Sales roles, leavers were paid **50.65% less** than peers who remained.

```
Retained Staff:  ████████████████████████ $6,833 / mo
Leavers:         █████████████████        $4,787 / mo  (-$2,045 deficit)
```

---

### 2. 🚨 Critical Flight-Risk Roles & Volume Hotspots
- **Sales Representatives** suffer the highest percentage attrition across the company at **39.76%** (33 leavers out of 83 staff).
- **Laboratory Technicians** represent the **largest absolute volume of departures**: 62 leavers (**26.16% of all exits company-wide**) with a 23.94% turnover rate.
- **Human Resources Specialists** exhibit an elevated **23.08% attrition rate**.

| Department | Job Role | Headcount | Leavers | Attrition % | % Total Company Exits |
| :--- | :--- | :---: | :---: | :---: | :---: |
| **Sales** | Sales Representative | 83 | 33 | **39.76%** | 13.92% |
| **R&D** | Laboratory Technician | 259 | 62 | **23.94%** | **26.16%** |
| **HR** | Human Resources | 52 | 12 | **23.08%** | 5.06% |
| **Sales** | Sales Executive | 326 | 57 | **17.48%** | 24.05% |
| **R&D** | Research Scientist | 292 | 47 | **16.10%** | 19.83% |

---

### 3. ⏱️ Overtime: The Single Strongest Catalyst for Turnover
Overtime dramatically multiplies flight risk, especially during the critical onboarding window (<2 years of tenure):
- **Tenure < 1 Year + Overtime**: **71.43% Attrition Rate** (10 out of 14 leave).
- **Tenure < 1 Year + No Overtime**: **20.00% Attrition Rate** (6 out of 30 leave).
- **Tenure 1–2 Years + Overtime**: **47.78% Attrition Rate** (43 out of 90 leave).
- **Tenure 1–2 Years + No Overtime**: **16.48% Attrition Rate** (29 out of 176 leave).

```
< 1 Yr Tenure + Overtime:     ██████████████████████████████ 71.43%
< 1 Yr Tenure + No Overtime:  ████████ 20.00%
1-2 Yrs Tenure + Overtime:    ████████████████████ 47.78%
1-2 Yrs Tenure + No Overtime: ███████ 16.48%
```

---

### 4. 🚗 Commute Distance & Travel Friction
- Employees living **26+ miles from the office** who are required to **Travel Frequently** experience a **41.18% attrition rate**.
- Conversely, employees living near the office (1-5 miles) who do not travel for business experience an attrition rate of only **3.17%**.

---

### 5. 👥 Managerial Continuity & Promotion Risks
- **31.10% of employees** who have been with their current manager for **less than 1 year** leave the company, even if they received a promotion that same year.
- This demonstrates that **manager changes represent a high-vulnerability retention window** where newly assigned staff feel disconnected or unsupported.

---

### 6. 🎯 The Top Multi-Factor Flight-Risk Segments

| Rank | High-Risk Cohort Definition | Headcount | Leavers | Flight Risk Rate |
| :---: | :--- | :---: | :---: | :---: |
| 🥇 | **Sales Rep + Overtime + Low Income (<$3.5k) + Early Career (<=2 yrs)** | 10 | 8 | **80.00%** |
| 🥈 | **Lab Tech + Overtime + Low Income (<$3.5k) + Early Career (<=2 yrs)** | 21 | 15 | **71.43%** |
| 🥉 | **Research Scientist + Overtime + Low Income (<$3.5k) + Early Career (<=2 yrs)** | 24 | 13 | **54.17%** |

---

## 💡 Strategic Action Plan for HR Leadership

```
┌───────────────────────────────────────────────────────────────────────────────┐
│                           HR RETENTION PLAYBOOK                                │
├───────────────────────────────────────────────────────────────────────────────┤
│ 1. Mandatory Overtime Cap (<24 Mo Tenure)                                    │
│    Enforce hard caps on weekly overtime for early-career hires to resolve     │
│    the 71.4% first-year burnout spike.                                        │
│                                                                               │
│ 2. Parity Adjustments for Junior Technical Roles                             │
│    Re-benchmark base compensation for Level 1/2 Laboratory Technicians and     │
│    Sales Reps earning below $3,500/mo to close the 30.0% leaver salary deficit.│
│                                                                               │
│ 3. Structured 90-Day Manager Transition Program                               │
│    Implement formalized skip-level check-ins during the first 90 days of any  │
│    manager transition to address the 31.1% leadership-change turnover rate.   │
│                                                                               │
│ 4. Flexible Commute Subsidy & Remote Days for High Travelers                  │
│    Offer hybrid flex days to employees commuting >25 miles who travel often.  │
└───────────────────────────────────────────────────────────────────────────────┘
```

---

## 📂 Repository Architecture

```
Employee-Attrition-Workforce-Analytics/
├── data/
│   ├── raw_attrition.csv                  # Raw IBM HR Analytics CSV dataset (1,470 rows)
│   ├── schema.sql                         # Typed SQLite DDL with integrity constraints & indexes
│   └── attrition.db                       # Normalized relational SQLite database
├── sql/
│   ├── 01_overall_attrition_kpis.sql      # Macro turnover, headcount, & compensation benchmarks
│   ├── 02_attrition_by_dept_and_role.sql  # Turnover rates & leaver volume by department & role
│   ├── 03_income_comparison_leavers_vs_stayed.sql  # Income deficit & pay disparity across job levels
│   ├── 04_attrition_by_overtime_and_tenure.sql     # Compounded interaction of overtime and tenure
│   ├── 05_job_satisfaction_and_worklife_balance.sql# Employee sentiment & balance correlation
│   ├── 06_distance_and_business_travel_impact.sql  # Commute distance and travel friction matrix
│   ├── 07_promotions_and_time_with_curr_manager.sql# Career progression and manager tenure dynamics
│   ├── 08_top_flight_risk_segments.sql    # Multi-variable high-risk employee segments
│   ├── 09_age_and_education_attrition_matrix.sql   # Generational cohort & academic background matrix
│   └── 10_salary_hike_and_performance_impact.sql   # Merit increase percentages vs performance rating
├── scripts/
│   ├── load_data.py                       # Ingestion, data cleaning, and database builder
│   ├── run_queries.py                     # SQL validation test suite runner
│   └── export_summaries.py                # Automated CSV exporter & Tableau master dataset builder
├── exports/
│   ├── tableau_attrition_master.csv       # Flat enriched master dataset for BI tools (1,470 records)
│   ├── summary_01_kpis.csv ... summary_10_salary_hike_performance.csv # Modular analytical summaries
├── docs/
│   └── tableau_dashboard_spec.md          # Tableau visual architecture, KPI layout, & LOD formulas
└── README.md                              # Project documentation & business intelligence report
```

---

## 📊 Tableau BI Dashboard Specification

The repository includes a production-ready BI specification in [`docs/tableau_dashboard_spec.md`](docs/tableau_dashboard_spec.md) with pre-built Level of Detail (LOD) formulas:

```
+---------------------------------------------------------------------------------------------------+
|  HEADER: Strategic Workforce Analytics & Attrition Intelligence          [Last Refresh: Active DB]|
+---------------------------------------------------------------------------------------------------+
|  GLOBAL FILTER PANEL: [Department]  |  [Job Role]  |  [Overtime]  |  [Travel]  |  [Tenure Band]    |
+---------------------------------------------------------------------------------------------------+
|  KPI CARDS:                                                                                       |
|  [ 1. Total Headcount ]  [ 2. Attrition Rate % ]  [ 3. Avg Leaver Tenure ]  [ 4. Monthly Comp Gap]|
|    1,470 Employees          16.12% (+2.1% vs tgt)      5.13 Years (-2.24y)       -$2,045 (-30.0%) |
+-------------------------------------------------+-------------------------------------------------+
|  CHART 1: Attrition Rate by Dept & Job Role     |  CHART 2: Monthly Income vs Attrition by Level  |
|  (Dual-Axis Horizontal Bar & Leaver Volume)     |  (Box Plot & Jittered Compensation Points)      |
+-------------------------------------------------+-------------------------------------------------+
|  CHART 3: Overtime & Tenure Risk Heatmap        |  CHART 4: Top Flight-Risk Employee Watchlist    |
|  (Color Intensity Matrix of Attrition %)        |  (Ranked Risk Table / Actionable Watchlist)     |
+-------------------------------------------------+-------------------------------------------------+
```

### Sample Native Tableau LOD Formulas Included in `docs/`:
```tableau
// Organization Baseline Turnover Rate (Fixed Level of Detail)
{ FIXED : SUM([attrition_flag]) / COUNT([employee_id]) }

// Monthly Compensation Gap ($)
{ FIXED [job_role], [job_level] : 
    AVG(IIF([attrition]='No', [monthly_income], NULL)) - 
    AVG(IIF([attrition]='Yes', [monthly_income], NULL)) 
}
```

---

## 🚀 Reproduction & Setup Guide

### 1. Prerequisites
- Python 3.8+
- SQLite3 (included with Python standard library)
- Required library: `pandas`

```bash
pip install pandas
```

### 2. Step-by-Step Execution

#### Step 1: Initialize Database & Ingest Cleaned Data
```bash
python scripts/load_data.py
```
*Output: Normalizes schema, drops zero-variance columns, creates indexes, and builds `data/attrition.db`.*

#### Step 2: Run & Validate SQL Analytics Suite
```bash
python scripts/run_queries.py
```
*Output: Executes all 10 SQL query files in sequence and verifies output schema integrity.*

#### Step 3: Generate Summary CSVs & Tableau Master Dataset
```bash
python scripts/export_summaries.py
```
*Output: Generates 10 modular summary CSVs and `exports/tableau_attrition_master.csv`.*

---

## 🛠️ Technical Competencies Demonstrated

- **Relational Data Modeling**: Typed DDL schemas, primary keys, `CHECK` constraints, composite analytical indexes.
- **Advanced SQL**: Common Table Expressions (CTEs), multi-table unions, conditional aggregation (`CASE WHEN`), window calculations, null-safe arithmetic.
- **Data Engineering**: Python ETL script design, automated schema transformation, robust error handling.
- **Business Intelligence**: Executive KPI scorecards, visual hierarchy design, Level-of-Detail (LOD) formulas, actionable HR strategy synthesis.

---

## 📄 License & Attribution
- Dataset: IBM HR Analytics Employee Attrition & Performance Dataset.
- Code & Documentation: Distributed under the [MIT License](LICENSE).
