# Project Folder Structure

This document describes the standard folder structure used in the AnalyticsPortfolio project workspace.

---

## data/

Stores project data files.

### data/raw/

Original downloaded or manually curated source datasets.

Rules:

- Do not modify raw source files directly.
- Keep raw data immutable.
- If a source file is replaced, document why in the session log or data journal.

Examples:

- Statistics Canada CPI files
- Construction-cost data files
- Curated catastrophe event CSVs

---

### data/processed/

Cleaned or transformed datasets created from raw data.

Use this folder for intermediate analysis-ready files when needed.

Rules:

- Files in this folder may be regenerated.
- Document major cleaning or transformation decisions.

---

### data/database/

SQLite database files created during the SQL warehouse phase.

Example:

- `alberta_home_insurance.db`

Note:

- Database files are generated artifacts.
- They may be excluded from GitHub if the project can rebuild them from SQL scripts and notebooks.

---

## notebooks/

Jupyter notebooks used for analysis and documentation.

Examples:

- `02_build_sql_warehouse.ipynb`
- `03_python_analysis.ipynb`

Rules:

- Use markdown cells for section headings, explanations, findings, and caveats.
- Use code comments only for code-specific notes.
- Final notebooks should run from top to bottom without errors.

---

## sql/

SQL scripts used to create, validate, and query the warehouse.

Examples:

- `01_create_tables.sql`
- `02_load_data_notes.sql`
- `03_quality_checks.sql`
- `04_create_views.sql`

Use this folder for:

- table creation scripts
- quality checks
- analytical views
- documented SQL logic

---

## outputs/

Generated project outputs.

### outputs/figures/

Charts exported from Python.

Examples:

- `cpi_only_indexed_growth_comparison.png`
- `insurance_yoy_with_event_years.png`

---

### outputs/dashboard_data/

Dashboard-ready CSV files exported from Python for Power BI.

Examples:

- `dashboard_annual_summary.csv`
- `dashboard_cpi_indexed_growth.csv`
- `dashboard_catastrophe_events.csv`
- `dashboard_auto_sensitivity.csv`

---

### outputs/powerbi/

Power BI dashboard files.

Example:

- `alberta_home_insurance_dashboard.pbix`

---

### outputs/screenshots/

Dashboard screenshots used for reports, README files, presentations, and portfolio pages.

Examples:

- `dashboard_page_1_executive_review.png`
- `dashboard_page_2_context_sensitivity_review.png`

---

### outputs/demo/

Optional video exports or screen recordings.

Examples:

- `alberta_home_insurance_dashboard_demo.mp4`
- `alberta_home_insurance_presentation_video.mp4`

---

## reports/

Final written and presentation deliverables.

Examples:

- `alberta_home_insurance_final_report.md`
- `alberta_home_insurance_case_study.md`

---

### reports/presentation/

Presentation-specific files.

Examples:

- `alberta_home_insurance_presentation_outline.md`
- `alberta_home_insurance_presentation.pptx`
- `alberta_home_insurance_presentation.pdf`
- `alberta_home_insurance_interview_walkthrough.md`

---

## docs/

Project documentation, templates, notes, and reusable references.

Use this folder for:

- project folder structure notes
- notebook templates
- workflow guides
- documentation standards
- shortcut notes
- reusable project rules

Examples:

- `project_folder_structure.md`
- `jupyterlab_template_readme.md`

---

## scripts/

Reusable Python scripts.

Use this folder only when code is reused across multiple notebooks or projects.

Examples:

- helper functions
- data-loading utilities
- chart formatting functions
- automation scripts

For one-off project code, keep it inside the notebook instead of creating unnecessary scripts.

---

## README.md

The main project overview file for GitHub or portfolio use.

It should summarize:

- project objective
- stakeholder question
- tools used
- data sources
- methodology
- dashboard screenshots
- key findings
- limitations
- how to reproduce or review the project