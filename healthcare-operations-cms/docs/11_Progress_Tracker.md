\# Progress Tracker



\## Project



Healthcare Operations Analytics — ED Throughput Benchmarking



\## Current Status



Project complete.



The Healthcare Operations Analytics mini project has completed SQL staging, QA, Python profiling, EDV peer benchmarking, visuals, findings, limitations, and portfolio packaging.



The project is ready for GitHub review and portfolio integration.



\## Current Phase



Phase 6 — Portfolio Packaging: Complete



Project status:



Complete



\## Overall Phase Status



| Phase | Name | Status |

|---|---|---|

| Phase 0 | Project Initiation | Complete |

| Phase 1 | Data Acquisition and Feasibility | Complete |

| Phase 2 | Data Understanding, SQL Staging and Quality Checks | Complete |

| Phase 3 | Analysis and Metric Development | Complete |

| Phase 4 | Visualization and Dashboarding | Complete |

| Phase 5 | Findings, Recommendations and Limitations | Complete |

| Phase 6 | Portfolio Packaging | Complete |



\## Two-Day Timeline Status



\### Day 1 — SQL + QA



Status: Complete



Completed blocks:



\- Block 1 — Raw staging setup

\- Block 2 — Raw QA checks

\- Block 3 — Typed staging view

\- Block 4 — Hospital-level analytical mart

\- Block 5 — Export and Phase 2 documentation



\### Day 2 — Python + Portfolio Output



Status: Complete



Completed blocks:



\- Block 6 — Python profiling

\- Block 7 — EDV peer benchmarking

\- Block 8 — Visuals

\- Block 9 — Findings, recommendations, and limitations

\- Block 10 — Portfolio packaging



\## Business Context



Hospital emergency-department throughput and peer benchmarking using CMS hospital public reporting data.



The project identifies hospitals with elevated ED throughput indicators relative to available ED-volume peer categories.



This is an operational screening project, not a causal diagnosis of hospital performance.



\## Stakeholders



Primary stakeholder:



\- Health-system Operations / Quality Improvement Analyst



Secondary stakeholders:



\- Hospital Operations Director

\- Emergency Department Manager

\- Quality Improvement Team



\## Decision Question



Which hospitals show unusually weak emergency-department throughput indicators relative to available ED-volume peer categories and should receive further operational review?



\## Core Measures



EDV:



Emergency department volume category. Used as a peer-group field.



OP\_18b:



Median ED arrival-to-departure time for discharged patients. Lower is better.



OP\_22:



Percentage of patients who left before being seen. Lower is better.



\## Confirmed Source Grain



Hospital General Information:



\- One row per facility\_id

\- Confirmed through SQL QA



Timely and Effective Care:



\- One row per facility\_id × measure\_id

\- Confirmed through SQL QA



Final analytical mart:



\- One row per hospital

\- 4,660 rows

\- 4,660 unique facilities

\- No duplicate facility\_id rows



\## Confirmed Reporting Windows



EDV:



\- 01/01/2024 to 12/31/2024



OP\_22:



\- 01/01/2024 to 12/31/2024



OP\_18b:



\- 07/01/2024 to 06/30/2025



Important caveat:



OP\_18b uses a different reporting window from EDV and OP\_22. These measures can support recent operational screening, but not perfectly synchronized causal interpretation.



\## Day 1 Completed Work



\### Block 1 — Raw Staging Setup



Completed:



\- Created SQLite database: `data/database/healthcare\_operations\_cms.db`

\- Created raw tables:

&#x20; - `raw\_hospital\_general`

&#x20; - `raw\_timely\_effective\_care`

\- Loaded CMS CSV files into SQLite.

\- Preserved `facility\_id` as text.

\- Detected and fixed duplicate loading issue caused by repeated append execution.



Final row counts after reset and reload:



\- `raw\_hospital\_general`: 5,432 rows

\- `raw\_timely\_effective\_care`: 138,173 rows



\### Block 2 — Raw QA Checks



Completed:



\- Checked total row counts.

\- Checked unique facility counts.

\- Checked duplicate `facility\_id` values in `raw\_hospital\_general`.

\- Checked duplicate `facility\_id + measure\_id` values in `raw\_timely\_effective\_care`.

\- Confirmed target measure coverage.

\- Confirmed reporting windows.

\- Checked score availability.

\- Checked EDV category distribution.

\- Checked OP\_18b and OP\_22 raw score patterns.

\- Checked join coverage.



Key QA results:



\- `raw\_hospital\_general` has 5,432 rows and 5,432 unique facilities.

\- `raw\_timely\_effective\_care` has 138,173 rows and 4,660 unique facilities.

\- No duplicate `facility\_id` values in `raw\_hospital\_general`.

\- No duplicate `facility\_id + measure\_id` combinations in `raw\_timely\_effective\_care`.

\- EDV, OP\_18b, and OP\_22 each have 4,660 rows and 4,660 unique facilities.

\- All 4,660 target-measure facilities match Hospital General Information.



\### Block 3 — Typed Staging View



Completed:



Created view:



\- `stg\_ed\_measures`



Typed staging logic:



\- `score\_raw` preserves original CMS score.

\- `availability\_status` identifies Available, Not Available, or Missing.

\- `score\_numeric` converts OP\_18b and OP\_22 only when available.

\- `score\_category` preserves EDV category only when available.

\- Footnotes and reporting dates are retained.



Validation:



EDV:



\- 4,660 rows

\- 3,837 available category values

\- 823 Not Available

\- 0 numeric values



OP\_18b:



\- 4,660 rows

\- 4,077 available numeric values

\- 583 Not Available

\- 0 category values



OP\_22:



\- 4,660 rows

\- 3,832 available numeric values

\- 828 Not Available

\- 0 category values



\### Block 4 — Hospital-Level Analytical Mart



Completed:



Created view:



\- `mart\_hospital\_ed\_throughput`



Validation:



\- 4,660 rows

\- 4,660 unique facilities

\- No duplicate `facility\_id` rows



Fields include:



\- hospital metadata

\- EDV category

\- OP\_18b numeric measure

\- OP\_22 numeric measure

\- availability statuses

\- footnotes

\- reporting dates



\### Block 5 — Export and Phase 2 Documentation



Completed:



Exported processed file:



\- `data/processed/healthcare\_ed\_throughput\_mart.csv`



Export validation:



\- 4,660 rows

\- 22 columns

\- 4,660 unique facilities

\- `facility\_id` preserved as six-character text, including leading zeroes



Documentation created or updated:



\- `01\_Phase0\_Project\_Initiation.md`

\- `02\_Phase1\_Data\_Acquisition\_Feasibility.md`

\- `03\_Phase2\_Data\_Quality\_SQL\_Staging.md`

\- `08\_Decision\_Log.md`

\- `09\_Metric\_Dictionary.md`

\- `10\_SQL\_Python\_DAX\_Spellbook.md`

\- `11\_Progress\_Tracker.md`



\## Day 2 Completed Work



\### Block 6 — Python Profiling



Completed:



\- Loaded `data/processed/healthcare\_ed\_throughput\_mart.csv`.

\- Confirmed 4,660 rows and 4,660 unique facilities.

\- Confirmed `facility\_id` preservation.

\- Profiled missingness for:

&#x20; - `ed\_volume\_category`

&#x20; - `op\_18b\_median\_wait\_min`

&#x20; - `op\_22\_lwbs\_pct`

\- Confirmed complete-case population for EDV + OP\_18b + OP\_22.

\- Profiled EDV distribution.

\- Profiled OP\_18b and OP\_22 overall distributions.

\- Profiled OP\_18b and OP\_22 by EDV tier.



Key profiling results:



\- EDV available: 3,837 hospitals

\- OP\_18b available: 4,077 hospitals

\- OP\_22 available: 3,832 hospitals

\- Complete-case benchmark population: 3,777 hospitals

\- Complete-case percentage: 81.1%



Overall outcome summary:



\- Overall median OP\_18b: 148 minutes

\- Overall 90th percentile OP\_18b: 225 minutes

\- Overall median OP\_22: 1%

\- Overall 90th percentile OP\_22: 4%



\### Block 7 — EDV Peer Benchmarking



Completed:



\- Created complete-case benchmark population.

\- Calculated EDV-tier median, 75th percentile, and 90th percentile benchmarks.

\- Assigned peer benchmark fields to each hospital.

\- Calculated variance from EDV-tier peer medians.

\- Validated assigned peer medians against actual EDV-tier medians.

\- Created review-priority flags.

\- Created review-priority candidate table.

\- Exported benchmark outputs.



Benchmark population:



\- 3,777 hospitals

\- 3,777 unique facilities



EDV-tier benchmark summary:



| EDV Category | Hospital Count | OP\_18b Median | OP\_18b P90 | OP\_22 Median | OP\_22 P90 |

|---|---:|---:|---:|---:|---:|

| low | 1,612 | 120.0 | 162.9 | 1.0 | 3.0 |

| medium | 911 | 168.0 | 218.0 | 2.0 | 4.0 |

| high | 551 | 190.0 | 252.0 | 2.0 | 5.0 |

| very high | 703 | 194.0 | 271.6 | 2.0 | 5.0 |



Review-priority results:



| Review-Priority Type | Count | Percent of Benchmark Population |

|---|---:|---:|

| High wait only | 241 | 6.4% |

| High LWBS only | 292 | 7.7% |

| Both indicators high | 145 | 3.8% |

| Any review priority | 678 | 18.0% |



Processed outputs exported:



\- `data/processed/healthcare\_ed\_peer\_benchmark\_summary.csv`

\- `data/processed/healthcare\_ed\_benchmark\_analysis\_table.csv`

\- `data/processed/healthcare\_ed\_review\_priority\_table.csv`



\### Block 8 — Visuals



Completed:



Created visuals:



\- `outputs/figures/op18b\_wait\_time\_by\_ed\_volume.png`

\- `outputs/figures/op22\_lwbs\_by\_ed\_volume\_zoomed.png`

\- `outputs/figures/op18b\_vs\_op22\_review\_priority.png`

\- `outputs/figures/review\_priority\_by\_flag\_type.png`



Visual interpretation:



\- OP\_18b median wait time generally increases across EDV categories.

\- OP\_22 values are generally low but show higher upper-tail values in medium, high, and very-high EDV groups.

\- Review-priority hospitals appear in higher OP\_18b and/or OP\_22 regions.

\- Review-priority groups separate high wait only, high LWBS only, and both-indicator candidates.



\### Block 9 — Findings, Recommendations and Limitations



Completed:



\- Drafted stakeholder-ready findings.

\- Separated what the data shows from what it suggests.

\- Drafted recommendations.

\- Documented limitations.

\- Clarified what cannot be concluded.



Key findings:



1\. Median ED arrival-to-departure time generally increases across EDV categories.

2\. OP\_22 values are generally low but show meaningful upper-tail variation.

3\. 678 hospitals were flagged as review-priority candidates.

4\. 145 hospitals were elevated on both ED throughput indicators.



Recommendations:



1\. Use EDV-tier peer benchmarking as the first screening layer.

2\. Prioritize hospitals elevated on both indicators for deeper review.

3\. Use measure-specific review pathways for one-indicator flags.

4\. Preserve CMS missingness and footnotes in future analysis.



\### Block 10 — Portfolio Packaging



Completed:



\- Drafted Phase 6 packaging documentation.

\- Created project README.

\- Confirmed README image paths and notebook/file references.

\- Included project methodology, findings, visuals, recommendations, limitations, and reproduction instructions.

\- Confirmed project is ready for portfolio integration.



README file:



\- `README.md`



Phase 6 documentation:



\- `07\_Phase6\_Portfolio\_Packaging.md`



\## Final Project Outputs



\### SQL Scripts



\- `sql/01\_raw\_staging.sql`

\- `sql/02\_qa\_checks.sql`

\- `sql/03\_staging\_views.sql`

\- `sql/04\_analytical\_table.sql`



\### Notebooks



\- `notebooks/01\_healthcare\_ops\_eda.ipynb`

\- `notebooks/02\_healthcare\_ops\_analysis.ipynb`

\- `notebooks/03\_healthcare\_peer\_benchmarking.ipynb`



\### Processed Data



\- `data/processed/healthcare\_ed\_throughput\_mart.csv`

\- `data/processed/healthcare\_ed\_peer\_benchmark\_summary.csv`

\- `data/processed/healthcare\_ed\_benchmark\_analysis\_table.csv`

\- `data/processed/healthcare\_ed\_review\_priority\_table.csv`



\### Visuals



\- `outputs/figures/op18b\_wait\_time\_by\_ed\_volume.png`

\- `outputs/figures/op22\_lwbs\_by\_ed\_volume\_zoomed.png`

\- `outputs/figures/op18b\_vs\_op22\_review\_priority.png`

\- `outputs/figures/review\_priority\_by\_flag\_type.png`



\### Documentation



\- `docs/project\_structure.md`

\- `docs/01\_Phase0\_Project\_Initiation.md`

\- `docs/02\_Phase1\_Data\_Acquisition\_Feasibility.md`

\- `docs/03\_Phase2\_Data\_Quality\_SQL\_Staging.md`

\- `docs/04\_Phase3\_Analysis\_Metric\_Development.md`

\- `docs/05\_Phase4\_Visualization\_Dashboard.md`

\- `docs/06\_Phase5\_Findings\_Recommendations\_Limitations.md`

\- `docs/07\_Phase6\_Portfolio\_Packaging.md`

\- `docs/08\_Decision\_Log.md`

\- `docs/09\_Metric\_Dictionary.md`

\- `docs/10\_SQL\_Python\_DAX\_Spellbook.md`

\- `docs/11\_Progress\_Tracker.md`



\## Decisions Locked



1\. Facility ID remains text.

2\. Raw source tables are immutable staging tables.

3\. EDV is categorical and used as the main peer-group field.

4\. OP\_18b and OP\_22 are numeric outcome measures after safe staging conversion.

5\. Not Available values are preserved and documented.

6\. Footnotes are retained.

7\. Reporting-window mismatch is documented.

8\. The analytical mart includes the 4,660 hospitals with target ED-measure records.

9\. Benchmarking uses complete cases.

10\. EDV-tier medians, 75th percentiles, and 90th percentiles are the benchmark statistics.

11\. Review-priority flags use EDV-tier p90 thresholds.

12\. No composite performance score is used.

13\. No causal claims are made.

14\. No hospital “best/worst” ranking language is used.

15\. Static Python visuals are sufficient for this mini project.

16\. Full dashboard expansion is out of scope.



\## Limitations and Risks



\- EDV and OP\_22 use calendar year 2024.

\- OP\_18b uses July 2024 to June 2025.

\- EDV peer groups do not adjust for trauma level, staffing, capacity, boarding pressure, patient acuity, or local demand shocks.

\- Not Available values may reflect reporting, suppression, eligibility, or sample-size conditions.

\- The project can identify hospitals for operational review but cannot diagnose operational causes.

\- Geography, ownership, and hospital type should be used cautiously and only where defensible.

\- Review-priority flags are screening indicators, not definitive hospital rankings.

\- OP\_22 tied values can make percentile-based flags include more than exactly 10% of hospitals.



\## Portfolio Integration Next Steps



These are outside the completed mini-project scope and should be handled in the Portfolio Hub or portfolio-site thread:



1\. Add project summary to root `AnalyticsPortfolio/README.md`.

2\. Add project card to the portfolio website.

3\. Select final screenshots for the project page.

4\. Decide whether to include this project before or after the Alberta Home Insurance project on the portfolio site.

5\. Update LinkedIn project section if desired.


Optional extension:
Create a one-page Tableau dashboard using the finalized Healthcare processed outputs for BI practice. This is not required for the completed mini-project and should not delay portfolio-site integration.



\## Clean Stopping Point



Yes.

The Healthcare Operations Analytics mini project is complete and ready for portfolio integration.
