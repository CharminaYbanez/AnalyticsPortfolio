# Project Folder Structure

This document describes the standard folder structure used for the Olist Marketplace Analytics senior project.

---

## data/

Stores project data files.

### data/raw/

Original downloaded source datasets.

Rules:

- Do not modify raw source files directly.
- Keep raw data immutable.
- If a source file is replaced, document why in the session log, decision log, or data journal.
- Preserve original table names and keys unless transformation is documented.

Examples:

- `olist_orders_dataset.csv`
- `olist_order_items_dataset.csv`
- `olist_products_dataset.csv`
- `olist_sellers_dataset.csv`
- `olist_customers_dataset.csv`
- `olist_order_reviews_dataset.csv`
- `olist_order_payments_dataset.csv`
- `olist_geolocation_dataset.csv`
- `product_category_name_translation.csv`

---

### data/processed/

Cleaned or transformed datasets created from raw data.

Use this folder for analysis-ready files exported after SQL staging and QA.

Rules:

- Files in this folder may be regenerated.
- Document major cleaning, filtering, joining, and transformation decisions.
- Do not treat processed files as source data.

Examples:

- `olist_order_level_analytical_table.csv`
- `olist_seller_performance_table.csv`
- `olist_delivery_sla_table.csv`
- `olist_review_delivery_summary.csv`

---

### data/database/

SQLite database files created during the SQL staging and QA phase.

Example:

- `olist_marketplace_analytics.db`

Note:

- Database files are generated artifacts.
- They may be excluded from GitHub if the project can rebuild them from raw data and SQL scripts.

---

## notebooks/

Jupyter notebooks used for Python profiling, marketplace analysis, validation, visualization, and documentation.

Examples:

- `01_olist_data_profiling.ipynb`
- `02_olist_delivery_sla_analysis.ipynb`
- `03_olist_seller_performance_analysis.ipynb`

Rules:

- Use markdown cells for section headings, analytical logic, findings, caveats, and stakeholder interpretation.
- Use code comments only for code-specific notes.
- Final notebooks should run from top to bottom without errors.
- Python analysis should use the SQL-validated analytical tables when available.

---

## sql/

SQL scripts used to stage, validate, and analyze the Olist marketplace data.

Examples:

- `01_raw_staging.sql`
- `02_qa_checks.sql`
- `03_staging_views.sql`
- `04_analytical_tables.sql`
- `05_seller_performance_queries.sql`
- `06_delivery_sla_queries.sql`

Use this folder for:

- raw table creation or loading notes
- grain checks
- duplicate checks
- key and join validation
- timestamp checks
- order, item, seller, product, customer, payment, and review joins
- SLA and delivery-performance logic
- seller-performance metrics
- analytical table creation

---

## outputs/

Generated project outputs.

### outputs/figures/

Charts exported from Python.

Examples:

- `delivery_delay_distribution.png`
- `seller_revenue_concentration.png`
- `review_score_by_delivery_status.png`
- `freight_delivery_relationship.png`

---

### outputs/dashboard_data/

Dashboard-ready CSV files exported from SQL or Python.

Examples:

- `olist_order_level_dashboard.csv`
- `olist_seller_performance_dashboard.csv`
- `olist_delivery_sla_dashboard.csv`
- `olist_review_summary_dashboard.csv`

---

### outputs/powerbi/

Power BI dashboard files.

Example:

- `olist_marketplace_dashboard.pbix`

Note:

- This senior project may include a fuller dashboard than the mini projects.
- Dashboard files should be supported by documented SQL/Python logic, not manual spreadsheet manipulation.

---

### outputs/screenshots/

Dashboard, chart, or notebook screenshots used for README files, reports, presentations, and portfolio pages.

Examples:

- `olist_dashboard_executive_summary.png`
- `olist_seller_performance_page.png`
- `olist_delivery_sla_page.png`

---

### outputs/demo/

Optional video exports or screen recordings.

Examples:

- `olist_marketplace_dashboard_demo.mp4`
- `olist_project_walkthrough.mp4`

---

## reports/

Final written and presentation deliverables.

Examples:

- `olist_marketplace_case_study.md`
- `olist_senior_project_summary.md`
- `olist_methodology_report.md`

---

### reports/presentation/

Presentation-specific files.

Examples:

- `olist_presentation_outline.md`
- `olist_interview_walkthrough.md`
- `olist_presentation.pdf`
- `olist_presentation.pptx`

---

## docs/

Project documentation, NotebookLM-ready notes, decision logs, metric definitions, and reusable references.

Use this folder for:

- project structure notes
- phase notes
- decision log
- metric dictionary
- SQL/Python/DAX spellbook
- progress tracker
- source documentation notes
- methodology caveats
- dashboard design notes
- stakeholder mapping

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
- dashboard export helpers

For one-off project code, keep it inside the notebook instead of creating unnecessary scripts.

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
- analytical model
- dashboard screenshots
- key findings
- recommendations
- limitations
- how to reproduce or review the project

---

## Project scope guardrail

This is the senior portfolio project.

The project should focus on:

- SQL staging and QA across multiple marketplace tables
- logistics and delivery SLA analysis
- seller performance
- commercial concentration
- review-pattern analysis
- Power BI or dashboard-ready reporting
- stakeholder-ready recommendations and limitations
- portfolio-ready documentation

Do not expand into:

- causal claims that delivery delays caused review scores
- full customer retention or cohort analysis unless justified later
- production-grade semantic modeling claims
- complex ML prediction
- unsupported profitability estimates
- recommendations that guarantee revenue growth