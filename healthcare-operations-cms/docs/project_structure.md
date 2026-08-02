# Project Folder Structure

This document describes the standard folder structure used for the Healthcare Operations CMS mini project.

---

## data/

Stores project data files.

### data/raw/

Original downloaded CMS source datasets.

Rules:

- Do not modify raw source files directly.
- Keep raw data immutable.
- If a source file is replaced, document why in the session log, decision log, or data journal.
- Preserve `Facility ID` as text to avoid losing leading zeroes.

Examples:

- `Timely_and_Effective_Care-Hospital.csv`
- `Hospital_General_Information.csv`
- `HOSPITAL_Data_Dictionary.pdf`

---

### data/processed/

Cleaned or transformed datasets created from raw data.

Use this folder for analysis-ready files exported after SQL staging and QA.

Rules:

- Files in this folder may be regenerated.
- Document major cleaning, filtering, pivoting, and missingness decisions.
- Do not treat processed files as source data.

Examples:

- `healthcare_ed_analytical_table.csv`
- `healthcare_ed_measure_availability.csv`
- `healthcare_ed_peer_benchmark_output.csv`

---

### data/database/

SQLite database files created during the SQL staging and QA phase.

Example:

- `healthcare_operations_cms.db`

Note:

- Database files are generated artifacts.
- They may be excluded from GitHub if the project can rebuild them from raw data and SQL scripts.

---

## notebooks/

Jupyter notebooks used for Python profiling, benchmarking, visualization, and documentation.

Examples:

- `01_healthcare_ops_eda.ipynb`
- `02_healthcare_peer_benchmarking.ipynb`

Rules:

- Use markdown cells for section headings, analytical logic, findings, caveats, and stakeholder interpretation.
- Use code comments only for code-specific notes.
- Final notebooks should run from top to bottom without errors.
- Python analysis should use the SQL-validated analytical table, not silently redo uncontrolled cleaning.

---

## sql/

SQL scripts used to stage, validate, and transform the CMS data.

Examples:

- `01_raw_staging.sql`
- `02_qa_checks.sql`
- `03_staging_views.sql`
- `04_analytical_table.sql`

Use this folder for:

- raw table creation or loading notes
- source grain checks
- duplicate checks
- measure filtering
- date-window checks
- missingness and footnote preservation
- analytical table creation

---

## outputs/

Generated project outputs.

### outputs/figures/

Charts exported from Python.

Examples:

- `op18b_wait_time_by_ed_volume.png`
- `op22_lwbs_by_ed_volume.png`
- `op18b_vs_op22_scatter.png`

---

### outputs/dashboard_data/

Dashboard-ready CSV files exported from SQL or Python.

Examples:

- `healthcare_ed_analytical_table.csv`
- `healthcare_ed_peer_summary.csv`
- `healthcare_review_priority_table.csv`

---

### outputs/powerbi/

Optional Power BI dashboard files.

Example:

- `healthcare_operations_dashboard.pbix`

Note:

- This mini project does not require a full dashboard unless scope allows.
- Static visuals and a concise review-priority table are sufficient for the portfolio version.

---

### outputs/screenshots/

Chart, dashboard, or notebook screenshots used for README files, reports, presentations, and portfolio pages.

Examples:

- `healthcare_ed_wait_time_distribution.png`
- `healthcare_review_priority_summary.png`

---

### outputs/demo/

Optional video exports or screen recordings.

Examples:

- `healthcare_operations_project_walkthrough.mp4`

---

## reports/

Final written and presentation deliverables.

Examples:

- `healthcare_operations_case_study.md`
- `healthcare_operations_final_summary.md`

---

### reports/presentation/

Presentation-specific files.

Examples:

- `healthcare_operations_presentation_outline.md`
- `healthcare_operations_interview_walkthrough.md`
- `healthcare_operations_presentation.pdf`

---

## docs/

Project documentation, NotebookLM-ready notes, decision logs, metric definitions, and reusable references.

Use this folder for:

- project structure notes
- phase notes
- decision log
- metric dictionary
- SQL/Python spellbook
- progress tracker
- source documentation notes
- methodology caveats

Examples:

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

---

## scripts/

Reusable Python scripts.

Use this folder only when code is reused across multiple notebooks or projects.

Examples:

- data-loading utilities
- chart formatting functions
- validation helper functions

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
- SQL QA process
- benchmark logic
- key visuals
- key findings
- limitations
- how to reproduce or review the project

---

## Project scope guardrail

This is a two-day mini project.

The project should focus on:

- SQL staging and QA
- ED throughput measure profiling
- ED-volume peer benchmarking
- 2–4 strong visuals
- concise findings and limitations
- portfolio-ready documentation

Do not expand into:

- causal modeling
- trauma-level adjustment
- hospital ranking systems
- full healthcare policy recommendations
- composite performance scoring
- large dashboard platforms