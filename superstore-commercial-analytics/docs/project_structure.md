# project_structure.md

# Project Folder Structure

This document describes the standard folder structure used for the Superstore Commercial Analytics mini project.

---

## Project Scope Reminder

This is a two-day commercial analytics mini project.

The project should focus on:

- SQL staging and QA
- sales, profit, discount, product, segment, customer and region analysis
- revenue mix and profit leakage patterns
- year-over-year analysis if margin analysis is not sufficiently stakeholder-relevant
- 2–4 strong visuals
- concise commercial recommendations and limitations
- portfolio-ready documentation

Do not expand into:

- true customer lifetime value
- causal claims about discounts
- advanced forecasting
- basket analysis unless core work is complete
- gross-versus-net revenue reconstruction without source fields
- large enterprise dashboard architecture
- simultaneous Tableau and Power BI dashboard builds unless core work is complete

---

## data/

Stores project data files.

---

### data/raw/

Original downloaded or mirrored source datasets.

Rules:

- Do not modify raw source files directly.
- Keep raw data immutable.
- If a source file is replaced, document why in the decision log, session log or data journal.
- Preserve original field names unless transformation is documented.
- If files are renamed for cleaner code, document the rename.

Recommended files:

- `sample_superstore_primary.csv`
- `sample_superstore_reference.csv`

Original source filenames may also be preserved:

- `Sample - Superstore.csv`
- `sample-superstore.csv`

Current file roles:

- `Sample - Superstore.csv` is the primary analytical file.
- `sample-superstore.csv` is the source/reference comparison file only.

Notes:

- The primary file preserves Row ID, Customer ID, Product ID and numeric Sales, Profit, Quantity and Discount fields.
- The reference file has rounded/formatted values and lacks Row ID, Customer ID and Product ID.
- Use the reference file only for provenance comparison unless a later decision changes this.

---

### data/processed/

Cleaned or transformed datasets created from raw data.

Use this folder for analysis-ready files exported after SQL staging, Python cleaning or QA.

Rules:

- Files in this folder may be regenerated.
- Document major cleaning, filtering and transformation decisions.
- Do not treat processed files as source data.
- Processed files should be reproducible from raw data and scripts/notebooks.

Examples:

- `stg_superstore_sales.csv`
- `superstore_profitability_analytical_table.csv`
- `superstore_discount_tier_summary.csv`
- `superstore_yoy_summary.csv`
- `superstore_customer_pareto_summary.csv`

---

### data/database/

SQLite database files created during the SQL staging and QA phase.

Example:

- `superstore_commercial_analytics.db`

Rules:

- Database files are generated artifacts.
- They may be excluded from GitHub if the project can rebuild them from raw data and SQL scripts.
- SQL scripts should explain how to recreate the database tables or views.

---

## notebooks/

Jupyter notebooks used for Python profiling, commercial analysis, visualization and documentation.

Examples:

- `01_superstore_eda_staging_qa.ipynb`
- `02_superstore_profitability_analysis.ipynb`

Rules:

- Use markdown cells for section headings, analytical logic, findings, caveats and stakeholder interpretation.
- Use code comments only for code-specific notes.
- Final notebooks should run from top to bottom without errors.
- Python analysis should use the SQL-validated analytical table when available.
- Avoid turning notebooks into a substitute for the README or final report.

---

## sql/

SQL scripts used to stage, validate and analyze the Superstore data.

Examples:

- `01_raw_staging.sql`
- `02_qa_checks.sql`
- `03_staging_views.sql`
- `04_analytical_table.sql`

Use this folder for:

- raw table creation or loading notes
- staging table creation
- grain checks
- duplicate checks
- missingness checks
- date checks
- category consistency checks
- sales and profit validation
- discount-tier logic
- category, region, segment and product-level analysis
- customer contribution and Pareto analysis
- year-over-year summary logic
- analytical table creation

Rules:

- Keep SQL scripts readable and sequential.
- Add short comments explaining the purpose of each query.
- Do not create unnecessary database architecture for a two-day mini project.
- Validate key outputs through a second query, manual check or Python check when practical.

---

## outputs/

Generated project outputs.

---

### outputs/figures/

Charts exported from Python.

Examples:

- `profit_by_category.png`
- `discount_tier_margin_summary.png`
- `sales_profit_by_region.png`
- `customer_contribution_pareto.png`
- `yoy_sales_profit_trend.png`

Rules:

- Use clear filenames.
- Export only visuals that support the stakeholder decision question.
- Do not save every exploratory chart as a final output.

---

### outputs/dashboard_data/

Dashboard-ready CSV files exported from SQL or Python.

Examples:

- `superstore_sales_profit_summary.csv`
- `superstore_discount_tier_summary.csv`
- `superstore_category_region_summary.csv`
- `superstore_customer_pareto_summary.csv`
- `superstore_yoy_summary.csv`

Rules:

- These files should be clean enough for Tableau.
- Include only fields needed for dashboarding or portfolio visuals.
- Document how each file was generated.

---

### outputs/tableau/

Tableau workbook files or packaged workbook files.

Examples:

- `superstore_commercial_profitability_dashboard.twb`
- `superstore_commercial_profitability_dashboard.twbx`

Rules:

- Tableau is the primary dashboard tool for this project.
- Keep the dashboard focused on the stakeholder question.
- Match every dashboard visual to a business question.
- Avoid building a large enterprise-style dashboard unless the core project is already complete.

---

### outputs/powerbi/

Optional only.

Use this folder only if the project is later adapted into Power BI.

Example:

- `superstore_commercial_dashboard.pbix`

Note:

- Power BI is not part of the core tool plan for this project.
- Do not expand into both Tableau and Power BI unless SQL QA, analysis, dashboarding, findings and portfolio packaging are already complete.

---

### outputs/screenshots/

Dashboard, chart or notebook screenshots used for README files, reports, presentations and portfolio pages.

Examples:

- `superstore_profitability_dashboard.png`
- `superstore_discount_margin_view.png`
- `superstore_customer_pareto_view.png`
- `superstore_yoy_trend_view.png`

Rules:

- Use screenshots that communicate the final story clearly.
- Avoid cluttered screenshots from exploratory work.
- Use visuals that support the README and portfolio page.

---

### outputs/demo/

Optional video exports or screen recordings.

Examples:

- `superstore_project_walkthrough.mp4`

Rules:

- Optional only.
- Use only if the final dashboard is strong enough to justify a walkthrough.
- Keep demo videos short and stakeholder-oriented.

---

## reports/

Final written and presentation deliverables.

Examples:

- `superstore_commercial_case_study.md`
- `superstore_profitability_summary.md`

Use this folder for:

- case study writeup
- executive summary
- findings and recommendations
- limitation notes
- final methodology explanation

Rules:

- Separate what the data shows from what it suggests.
- Do not claim causal discount impact.
- Do not call historical customer contribution true customer lifetime value.
- Do not reconstruct gross or net revenue without source support.

---

### reports/presentation/

Presentation-specific files.

Examples:

- `superstore_presentation_outline.md`
- `superstore_interview_walkthrough.md`
- `superstore_presentation.pdf`

Use this folder for:

- interview walkthrough script
- presentation outline
- exported slide deck or PDF
- stakeholder explanation notes

---

## docs/

Project documentation, NotebookLM-ready notes, decision logs, metric definitions and reusable references.

Use this folder for:

- project structure notes
- phase notes
- decision log
- metric dictionary
- SQL/Python/Tableau spellbook
- progress tracker
- source documentation notes
- methodology caveats

Required documentation files:

- `project_structure.md`
- `00_Project_Overview.md`
- `01_Phase0_Project_Initiation.md`
- `02_Phase1_Data_Acquisition_Feasibility.md`
- `03_Phase2_Data_Quality_SQL_Staging.md`
- `04_Phase3_Analysis_Metric_Development.md`
- `05_Phase4_Visualization_Dashboard.md`
- `06_Phase5_Findings_Recommendations_Limitations.md`
- `07_Phase6_Portfolio_Packaging.md`
- `08_Decision_Log.md`
- `09_Metric_Dictionary.md`
- `10_SQL_Python_DAX_Spellbook.md`
- `11_Progress_Tracker.md`

Optional documentation files:

- `source_notes.md`
- `data_journal.md`
- `tableau_dashboard_notes.md`
- `interview_notes.md`

Rules:

- Keep documentation modular.
- Do not maintain one giant expanding document.
- Do not silently rewrite earlier decisions.
- Record revisions in the decision log with previous decision, new decision, reason, evidence and methodology effect.

---

## scripts/

Reusable Python scripts.

Use this folder only when code is reused across multiple notebooks or projects.

Examples:

- data-loading utilities
- chart formatting functions
- validation helper functions

Rules:

- For one-off project code, keep it inside the notebook.
- Do not create scripts just to make the project look more complex.
- Scripts should be documented enough that the project can be reproduced.

---

## README.md

The main project overview file for GitHub or portfolio use.

It should summarize:

- project objective
- stakeholder question
- tools used
- data source
- methodology
- SQL QA process
- profitability and revenue-mix analysis
- key visuals
- key findings
- limitations
- how to reproduce or review the project

Recommended README sections:

1. Project Overview
2. Business Question
3. Stakeholder
4. Dataset and Source Caveats
5. Tools Used
6. Methodology
7. Data Quality and Staging
8. Metrics
9. Dashboard / Visuals
10. Key Findings
11. Recommendations
12. Limitations
13. Repository Structure
14. How to Reproduce
15. Interview Explanation

---

## Final Scope Guardrail

This project should remain a focused commercial analytics mini project.

Core deliverables:

- cleaned staged dataset
- SQL QA checks
- validated metric dictionary
- commercial profitability analysis
- Tableau dashboard
- 2–4 strong visuals
- concise findings and recommendations
- README and portfolio-ready documentation

Avoid expanding into:

- true CLV
- causal inference
- forecasting
- basket analysis before core completion
- gross/net revenue reconstruction
- unnecessary dimensional modeling
- building in multiple BI tools at the same time
