# 08_Decision_Log.md

## Decision 001 — Project Framework

Previous decision:
Not applicable.

New decision:
Use a CRISP-DM-informed phase-based framework adapted from the Alberta Home Insurance project.

Reason for revision:
The project needs consistent structure, clear checkpoints and portfolio-ready documentation.

Evidence:
The Alberta project workflow provided a successful repeatable structure for project initiation, data acquisition, QA, analysis, visualization, findings and packaging.

Effect on scope or methodology:
All Superstore work will proceed through Phase 0 to Phase 6. Each phase will open with purpose, importance, decisions, deliverable and scope/error risks, and close with a checkpoint.

---

## Decision 002 — Primary Stakeholder

Previous decision:
Not applicable.

New decision:
Primary stakeholder is a Commercial Analytics Manager or VP of Sales Operations.

Reason for revision:
The dataset contains sales, profit, product, region, customer, segment and discount fields, making it better suited to commercial performance review than finance reporting or marketing attribution.

Evidence:
Available fields support commercial profitability and mix analysis but do not support true campaign, acquisition or cost attribution analysis.

Effect on scope or methodology:
The dashboard and analysis will prioritize profitability, revenue mix, discount patterns and commercial review areas.

---

## Decision 003 — Main Decision Question

Previous decision:
Not applicable.

New decision:
Which products, customer segments, regions and discount patterns contribute to profitable growth or revenue leakage, and where should management prioritize commercial review?

Reason for revision:
The project needs one business-facing decision question to prevent generic chart-building.

Evidence:
The dataset supports product, customer, segment, region, sales, profit and discount analysis.

Effect on scope or methodology:
Metrics and visuals must connect back to profitable growth, revenue leakage or commercial review prioritization.

---

## Decision 004 — Initial Dataset Position

Previous decision:
Preferred dataset was Official Tableau Sample Superstore, subject to direct source and field verification.

New decision:
Use Sample - Superstore.csv as the primary analysis candidate and sample-superstore.csv as a source/reference comparison file unless Phase 1 identifies a better official accessible dataset.

Reason for revision:
Initial file inspection shows that Sample - Superstore.csv preserves Row ID, Customer ID, Product ID and numeric Sales, Profit and Discount fields. The source/reference-style file has rounded formatted values and lacks important identifiers.

Evidence:
Initial inspection:
- Sample - Superstore.csv has 9,994 rows, 21 columns and key analytical identifiers.
- sample-superstore.csv has 9,994 rows, 22 columns, formatted values, rounded amounts and lacks Customer ID, Product ID and Row ID.

Effect on scope or methodology:
Detailed SQL/Python analysis will use the cleaner primary file if Phase 1 confirms feasibility. The source/reference file will be documented for provenance comparison only.

---

## Decision 005 — Metric Freeze Deferred

Previous decision:
Not applicable.

New decision:
Do not freeze metrics until source, fields, grain and QA checks are completed.

Reason for revision:
Metric validity depends on confirming data grain, field availability, data types, duplicates and date semantics.

Evidence:
Two available files differ in identifiers, formatting and date ranges.

Effect on scope or methodology:
Phase 0 can define metric candidates, but final metric definitions must wait until Phase 1 and Phase 2.

---

## Decision 006 — Year-over-Year Analysis as Fallback or Supporting Branch

Previous decision:
Core analytical areas included sales and profit trends, discount leakage, product and regional mix, and historical customer contribution / Pareto concentration.

New decision:
Keep margin and discount analysis as candidate core areas, but add year-over-year analysis as a fallback or supporting branch if margin analysis does not produce stakeholder-relevant findings.

Reason for revision:
Margin analysis may show obvious or weak results. Year-over-year analysis can provide a stronger commercial performance story if it reveals changes in sales, profit, margin, region, category, segment or sub-category performance over time.

Evidence:
The primary Superstore analysis file includes Order Date, Sales, Profit, Category, Sub-Category, Segment, Region and Discount fields, which should support YoY analysis after date semantics and grain are verified.

Effect on scope or methodology:
YoY analysis is added as a contingency path, not a pre-frozen metric set. Final YoY metrics will be defined only after Phase 1 and Phase 2 validation. Potential YoY metrics include annual sales, annual profit, weighted margin by year, YoY sales growth, YoY profit growth and YoY margin movement.

---

## Decision 007 — Phase 1 Feasibility Decision

Previous decision:
Use Sample - Superstore.csv as the primary analysis candidate and sample-superstore.csv as a source/reference comparison file unless Phase 1 identifies a better official accessible dataset.

New decision:
Proceed with Sample - Superstore.csv as the primary analytical dataset. Use sample-superstore.csv only as source/reference comparison evidence.

Reason for revision:
Phase 1 inspection confirmed that Sample - Superstore.csv preserves the key identifiers and numeric fields needed for commercial profitability analysis. The comparison file contains rounded/formatted values and lacks Row ID, Customer ID and Product ID.

Evidence:
Sample - Superstore.csv:
- 9,994 rows and 21 columns
- includes Row ID, Order ID, Customer ID, Customer Name, Product ID, Product Name, Sales, Quantity, Discount and Profit
- Order Date range from 2014-01-03 to 2017-12-30
- 5,009 unique orders
- 793 unique customers
- 1,862 unique product IDs
- no duplicate Row IDs
- no fully duplicate rows

sample-superstore.csv:
- 9,994 rows and 22 columns
- UTF-16 tab-delimited
- Sales and Profit are rounded currency strings
- Discount is a percent string
- lacks Row ID, Customer ID and Product ID
- date range differs from the primary file

Effect on scope or methodology:
SQL, Python and Tableau analysis will use Sample - Superstore.csv as the working dataset. Source caveats will be documented. Detailed customer and product analysis will not use the rounded source/reference file.

---

## Decision 008 — Project Folder Structure and File Naming

Previous decision:
No finalized folder structure for Project 3.

New decision:
Use a standard portfolio project folder structure with folders for raw data, processed data, database artifacts, notebooks, SQL scripts, outputs, reports, documentation, optional scripts and README.

Recommended structure:
- data/raw/
- data/processed/
- data/database/
- notebooks/
- sql/
- outputs/figures/
- outputs/dashboard_data/
- outputs/tableau/
- outputs/screenshots/
- outputs/demo/
- reports/
- reports/presentation/
- docs/
- scripts/
- README.md

Reason for revision:
The project needs a reproducible structure that separates raw data, processed data, SQL logic, notebooks, dashboard assets, documentation and portfolio outputs.

Evidence:
The project requires SQL staging and QA, Python profiling, Tableau dashboarding, NotebookLM-ready documentation, metric definitions, decision logs and portfolio packaging.

Effect on scope or methodology:
The structure supports reproducibility without expanding into unnecessary enterprise architecture. Power BI is not part of the core tool plan and should remain optional only. Tableau is the primary dashboard tool and should have the main dashboard output folder.

---

## Decision 009 — SQL Engine Selection

Previous decision:
SQL engine was unresolved. Options included SQLite, DuckDB or PostgreSQL-style SQL.

New decision:
Use SQLite for Project 3 SQL staging, QA and analysis.

Reason for revision:
SQLite is lightweight, local, easy to use from Jupyter with Python's built-in sqlite3 library, and sufficient for the project's staging, QA and aggregation needs.

Evidence:
The project is a two-day mini project using one primary Superstore CSV file. The work requires table creation, data loading, QA checks, aggregation, grouping, date checks and dashboard-ready exports, all of which SQLite can support.

Effect on scope or methodology:
SQL syntax will use SQLite-compatible functions where needed. Database artifacts will be stored under data/database/. The database can be regenerated from raw data and SQL scripts, so the .db file may be treated as a generated artifact.

---

# Decision 010 — Product-Level Caveat Handling

Previous decision:
Product-level rankings were considered feasible with caveats because product_id and product_name are not perfectly one-to-one.

New decision:
Do not build a full product-dimension cleanup or product-name standardization process for the Superstore mini project. Keep the product-level caveat documented and prioritize category and sub-category analysis for product-mix storytelling.

Reason for revision:
Superstore is a fictitious sample dataset. Building a product master or canonical product-name mapping would not be a true source-data fix. It would add complexity without meaningfully improving the validity of the mini project.

Evidence:
Phase 2 QA showed:
- 32 product_id values map to more than one product_name.
- Several product_name values map to multiple product_id values, including generic names such as Staples, Staple envelope and Easy-staple paper.
- The project already has strong product-mix analysis available at the category and sub-category levels.

Effect on scope or methodology:
The Superstore project will avoid unnecessary product-dimension engineering. Product-level ranking may be included only as optional detail with caveats. Advanced entity-key logic, composite keys and exception-table handling will be reserved for the Olist senior project, where relational modeling and grain validation are genuinely relevant.