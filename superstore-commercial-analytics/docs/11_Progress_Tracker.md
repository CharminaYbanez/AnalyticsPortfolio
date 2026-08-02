# 11_Progress_Tracker.md

# Progress Tracker

## Project

Superstore Commercial Profitability Review

## Current Status

Phase 6 complete.

The Superstore Commercial Profitability mini project has completed project initiation, data acquisition and feasibility review, SQL staging and QA, Phase 3 analysis and metric development, Tableau dashboarding, and Phase 5 findings/recommendations/limitations documentation.

The Tableau Public dashboard has been published and includes:
- KPI header
- Sub-category × discount tier profitability matrix
- Sub-category sales vs margin scatter plot
- Region profitability summary
- Collapsible Commercial Insights panel
- Collapsible Recommended Actions panel
- Footer and source/tool notes

The project is portfolio-ready. Its README, Tableau link, dashboard screenshots, website copy, interview walkthrough, and documentation have been completed.

## Current Phase

Phase 6 — Portfolio Packaging: Complete

## Overall Phase Status

| Phase | Name | Status |
|---|---|---|
| Phase 0 | Project Initiation | Complete |
| Phase 1 | Data Acquisition and Feasibility | Complete |
| Phase 2 | Data Understanding, SQL Staging and Quality Checks | Complete |
| Phase 3 | Analysis and Metric Development | Complete |
| Phase 4 | Visualization and Dashboarding | Complete |
| Phase 5 | Findings, Recommendations and Limitations | Complete |
| Phase 6 | Portfolio Packaging | Complete |

## Completed Work

### Phase 0 — Project Initiation

Completed:
- Defined stakeholder as Commercial Analytics Manager or VP of Sales Operations.
- Defined decision question.
- Set project scope and terminology guardrails.
- Deferred metric freeze until source, fields, grain and QA were validated.

### Phase 1 — Data Acquisition and Feasibility

Completed:
- Selected `Sample - Superstore.csv` as the primary analysis file.
- Documented comparison against alternate/source-reference file.
- Confirmed dataset feasibility for commercial profitability analysis.
- Documented limitations of using a fictitious/sample dataset.

### Phase 2 — Data Understanding, SQL Staging and Quality Checks

Completed:
- Created staged file: `data/processed/stg_superstore_sales.csv`
- Created SQLite database: `data/database/superstore_commercial_analytics.db`
- Loaded staged table: `raw_superstore_sales`
- Confirmed line-item grain.
- Completed SQL QA checks for row count, keys, duplicates, dates, missingness, categories, discount values, profit ranges and geographic coverage.

Key QA results:
- 9,994 rows
- 9,994 distinct row IDs
- 5,009 distinct orders
- 793 distinct customers
- 1,862 distinct products
- Order Date range: 2014-01-03 to 2017-12-30
- Ship Date range: 2014-01-07 to 2018-01-05
- 1,871 negative-profit rows
- 0 sales less than or equal to zero
- 0 records where Ship Date is before Order Date

### Phase 3 — Analysis and Metric Development

Completed:
- Overall commercial summary
- Category profitability analysis
- Sub-category profitability analysis
- Discount tier by category analysis
- Sub-category × discount tier profitability review
- Region profitability analysis
- Customer contribution analysis
- Customer Pareto analysis
- Year-over-year supporting summary
- Metric dictionary freeze
- Dashboard-ready CSV exports
- Analytical SQL views in `04_analytical_table.sql`

Main Phase 3 finding:
Profitability pressure is concentrated in specific sub-category and discount-tier combinations, especially high-discount Binders, Machines, Tables, Bookcases and Phones.

### Phase 4 — Visualization and Dashboarding

Completed:
- Created Tableau Public profile.
- Published Tableau Public dashboard: `Superstore Commercial Profitability Review`
- Built KPI header.
- Built Sub-Category × Discount Tier Profitability Matrix.
- Built Sub-Category Sales vs Margin scatter plot.
- Built Region Profitability summary.
- Added footer and source/tool notes.
- Added collapsible Commercial Insights and Recommended Actions panels.
- Validated tooltip metric alignment and corrected aggregation issues.

Dashboard status:
Published and portfolio-ready.

### Phase 5 — Findings, Recommendations and Limitations

Completed:
- Drafted and saved key findings.
- Drafted and saved recommended actions.
- Drafted and saved limitations.
- Separated observed findings from interpretations and recommendations.
- Documented causal limitations around discount behavior.
- Documented customer contribution limitation: historical contribution only, not CLV.
- Documented product-name caveat and sample dataset limitation.

### Phase 6 — Portfolio Packaging

Completed:
- Finalized the GitHub README and dashboard screenshot.
- Confirmed the Tableau Public dashboard link.
- Added portfolio website card copy and project links.
- Added 30-second and 2-minute interview explanations.
- Confirmed the repository structure and source-file notes.
- Preserved the sample-data and observational-analysis guardrails.

## Locked Decisions

- Main story: profitability pressure is concentrated in sub-category × discount-tier combinations.
- Use category and sub-category as primary product-mix storytelling levels.
- Do not overbuild product-name standardization for fictitious Superstore data.
- Use weighted profit margin as `SUM(profit) / SUM(sales)`.
- Treat discount patterns as observed associations, not causal proof.
- Treat customer contribution as historical contribution, not customer lifetime value.
- Use Tableau as the final dashboard platform for this mini project.

## Current Limitations

- Superstore is a fictitious/sample dataset.
- Discount reasons, product costs, promotions, returns, product condition and fulfillment cost are unavailable.
- Gross revenue and net revenue cannot be reconstructed.
- Product ID and product name are not perfectly one-to-one.
- Region reflects customer/order geography, not logistics routing.
- Customer contribution does not represent true CLV.

## Immediate Next Action

Publish the packaged project to GitHub and verify the portfolio website links. Any later refinements are optional rather than required for completion.

## Clean Stopping Point

Yes. The project is complete and ready for publishing.
