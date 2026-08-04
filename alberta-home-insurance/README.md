# Alberta Home Insurance Premium Pressure Monitor

An end-to-end analytics project examining Alberta home-insurance price pressure from 2016 to 2025 using public economic, construction-cost, and catastrophe-loss data.

The project uses SQL, Python, and Power BI to determine whether Alberta home-insurance CPI diverged sufficiently from selected benchmarks to warrant deeper affordability, insurance-market, or catastrophe-risk review.

---

## Project Overview

Alberta homeowners have experienced substantial increases in home-insurance prices during a period marked by general inflation, rising construction costs, and several major insured catastrophe events.

This project evaluates Alberta home-insurance CPI relative to:

- Alberta all-items CPI
- Canada home-insurance CPI
- residential construction-cost context
- selected Alberta catastrophe-loss events
- Alberta auto-insurance CPI as a sensitivity check

The analysis is designed as a **monitoring and review-trigger framework**, not as a causal or actuarial model.

---

## Stakeholder

**Primary stakeholder:** Provincial public-policy or insurance-affordability analyst

### Decision question

> Has Alberta home-insurance price growth diverged sufficiently from selected economic and insurance benchmarks to justify deeper affordability, market, or catastrophe-risk review?

---

## Key Findings

From 2016 to 2025:

- Alberta home-insurance CPI increased approximately **74.6%**
- Alberta all-items CPI increased approximately **27.4%**
- Canada home-insurance CPI increased approximately **64.5%**
- Alberta auto-insurance CPI increased approximately **67.7%** in the sensitivity analysis

The analysis indicates that Alberta home-insurance prices rose substantially faster than general consumer prices.

Canada also experienced significant home-insurance price growth, showing that the pressure was not unique to Alberta. However, Alberta recorded a larger cumulative increase by 2025, supporting further investigation into provincial market, catastrophe-risk, and replacement-cost conditions.

These findings do not establish the cause of the price increase.

---

## Analytical Workflow

```text
Public source data
→ Python source preparation
→ SQLite warehouse
→ SQL quality checks
→ SQL analytical views
→ Python trend and sensitivity analysis
→ Power BI dashboard
→ stakeholder report and presentation
```

---

## Tools

- SQL
- SQLite
- Python
- pandas
- NumPy
- Matplotlib
- Power BI
- JupyterLab
- Git and GitHub

---

## Repository Structure

```text
alberta-home-insurance/
│
├── README.md
├── .gitignore
│
├── data/
│   ├── raw/
│   ├── processed/
│   └── database/
│
├── docs/
│   ├── project_structure.md
│   └── project documentation
│
├── notebooks/
│   ├── 01_test_environment.ipynb
│   ├── 02_build_sql_warehouse.ipynb
│   └── 03_python_analysis.ipynb
│
├── sql/
│   ├── 01_create_tables.sql
│   ├── 02_load_data_notes.md
│   ├── 03_quality_checks.sql
│   └── 04_create_views.sql
│
├── outputs/
│   ├── dashboard_data/
│   ├── figures/
│   ├── screenshots/
│   ├── demo/
│   └── powerbi/
│
└── reports/
    └── presentation/
```

Raw datasets and generated database files are excluded from Git where appropriate. Folder structure is preserved with `.gitkeep` files.

---

## SQL Warehouse

The SQLite warehouse contains four core tables:

### `dim_date`

**Grain:** One row per month

Provides the shared date spine used across the analysis.

### `fact_cpi`

**Grain:** One row per date, geography, and CPI category

Stores the selected CPI series used for provincial, national, and general-inflation comparisons.

### `fact_construction_cost`

**Grain:** One row per reporting period, geography, and construction category

Provides replacement-cost context. The selected series begins in 2017 and therefore uses a different baseline from the CPI series.

### `fact_hail_loss_event`

**Grain:** One row per curated Alberta catastrophe event

Provides timing and insured-loss context. Events are not treated as causal proof.

---

## Data Quality Checks

The SQL quality-control process validates:

- table existence
- expected row counts
- primary-key uniqueness
- business-grain uniqueness
- required-field nulls
- blank text values
- foreign-key integrity
- orphan records
- date consistency
- source coverage
- numeric validity
- category consistency
- revision flags
- catastrophe-event totals

Expected final base-table counts:

| Table | Rows |
|---|---:|
| `dim_date` | 121 |
| `fact_cpi` | 360 |
| `fact_construction_cost` | 37 |
| `fact_hail_loss_event` | 6 |

---

## Important Data-Quality Correction

The first version of the annual summary view joined CPI, construction-cost, and catastrophe-event data at incompatible grains.

This multiplied catastrophe-loss totals across CPI category rows.

The issue was corrected by:

1. aggregating CPI data to annual grain;
2. aggregating construction-cost data separately;
3. aggregating catastrophe events separately;
4. joining the pre-aggregated annual results.

This prevented one-to-many join multiplication and preserved valid catastrophe totals.

---

## Python Analysis

The Python notebook:

- loads validated SQL views into pandas;
- calculates annual-average CPI trends;
- indexes series to comparable baselines;
- calculates cumulative growth;
- calculates benchmark gaps;
- compares five-year cohorts;
- adds catastrophe-event context;
- performs an Alberta auto-insurance CPI sensitivity check;
- exports dashboard-ready CSV files;
- generates supporting figures.

---

## Power BI Dashboard

The Power BI report contains two pages.

### Page 1 — Executive Review

Includes:

- cumulative-growth KPI cards
- Alberta versus benchmark comparison
- indexed CPI trend chart
- benchmark-gap indicators
- review signal
- stakeholder interpretation

### Page 2 — Context and Sensitivity

Includes:

- curated catastrophe-loss context
- Alberta home versus auto-insurance CPI comparison
- methodological caveats
- interpretation guardrails

The dashboard is intended to support a decision about whether deeper review is warranted. It does not diagnose the cause of premium growth.

---

## Main Deliverables

- SQLite warehouse
- SQL schema and analytical views
- SQL quality-check script
- Python analysis notebook
- Power BI dashboard
- dashboard-ready datasets
- analytical figures
- dashboard screenshots
- dashboard demonstration video
- final report
- presentation deck
- presentation PDF
- interview walkthrough

---

## Interpretation Guardrails

This project is descriptive and exploratory.

Important limitations include:

- Home-insurance CPI measures aggregate price change, not individual policy premiums.
- CPI does not account for individual property characteristics, deductibles, coverage choices, insurers, or local risk territories.
- Catastrophe events are contextual timing markers, not causal evidence.
- Construction-cost data provide replacement-cost context but begin in 2017.
- The analysis does not include insurer-level pricing, claims severity, reinsurance costs, household income, or premium-to-income measures.
- The project identifies potential affordability pressure but does not directly measure affordability.
- The dashboard Review Signal is judgment-based rather than a formal statistical threshold.

---

## Recommendations

Use benchmark divergence as a monitoring signal.

If Alberta home-insurance CPI continues to exceed general inflation and national insurance benchmarks, stakeholders should consider deeper analysis using:

- insurer or regulatory premium data
- claims frequency and severity
- replacement-cost measures
- reinsurance costs
- coverage and deductible changes
- household-income data
- regional catastrophe exposure
- comparisons with other provinces

---

## Reproducing the Project

1. Clone the repository.
2. Create the required Python environment.
3. Place approved source files in `data/raw/`.
4. Run:

```text
notebooks/02_build_sql_warehouse.ipynb
```

5. Execute:

```text
sql/03_quality_checks.sql
```

6. Create the analytical views using:

```text
sql/04_create_views.sql
```

7. Run:

```text
notebooks/03_python_analysis.ipynb
```

8. Open the Power BI file locally if it is included in the repository.

Raw files and the generated SQLite database may be excluded from Git. Source links and loading notes are documented in the repository.

---

## Project Status

**Complete and portfolio-ready**

This project demonstrates:

- business-question development
- stakeholder framing
- public-data assessment
- SQL warehouse design
- relational modeling
- data-quality validation
- join-grain troubleshooting
- Python analysis
- benchmark and sensitivity analysis
- Power BI dashboard development
- analytical storytelling
- transparent limitation reporting

---

## Author

**Charmina Ybanez**

- Portfolio: charminaybanez.github.io
- LinkedIn: linkedin.com/in/charminaybanez
- GitHub: github.com/CharminaYbanez