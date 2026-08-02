# Decision Log

## Project

Healthcare Operations Analytics — ED Throughput Benchmarking

## Current Status

Phase 2 is complete.

This decision log records major project decisions, revisions, rationale, evidence, and their effect on scope or methodology.

---

## Decision 001 — Primary Stakeholder Framing

Previous decision:
Primary stakeholder was listed as Hospital Operations Director.

New decision:
Primary stakeholder is Health-system Operations / Quality Improvement Analyst.

Hospital Operations Director, Emergency Department Manager, and Quality Improvement Team remain secondary stakeholders.

Reason for revision:
The decision question screens hospitals across a broad CMS dataset. A single Hospital Operations Director is more appropriate for a selected-hospital comparison, while a health-system operations or quality-improvement analyst is more appropriate for cross-hospital screening.

Evidence:
The project uses CMS hospital-level public reporting data across thousands of facilities. The planned analysis identifies hospitals with elevated ED throughput indicators relative to available peer categories.

Effect on scope or methodology:
The project remains a broad screening and benchmarking analysis. It will not claim to diagnose the operational causes of weak throughput at any individual hospital.

---

## Decision 002 — Definition of “Unusually Weak” Throughput

Previous decision:
“Unusually weak” throughput had not yet been formally defined.

New decision:
Unusually weak throughput will mean elevated OP_18b and/or OP_22 relative to EDV peer categories, using medians and percentile-based comparison before any optional review flags.

Reason for revision:
The project needs a predefined review logic before analysis to avoid cherry-picking and overclaiming.

Evidence:
OP_18b and OP_22 are lower-is-better throughput indicators. EDV is a volume peer category, not a performance metric.

Effect on scope or methodology:
OP_18b and OP_22 will remain separate in the core analysis. No composite score will be used in the mini project.

---

## Decision 003 — Missingness and Footnote Preservation

Previous decision:
Missing or non-numeric scores could have been converted directly to null during cleaning.

New decision:
The staged layer preserves score_raw, numeric score where applicable, availability status, original footnote code, and reporting dates.

Reason for revision:
CMS missingness may reflect reporting, suppression, sample-size, eligibility, or availability conditions, not ordinary random missing data.

Evidence:
SQL QA found Not Available values in all three target measures:

- EDV: 823 Not Available
- OP_18b: 583 Not Available
- OP_22: 828 Not Available

Effect on scope or methodology:
All 4,660 target-measure hospitals remain in the analytical mart. Measure-specific valid populations will be used, and complete-case analysis will be reserved for comparisons requiring EDV plus both outcomes.

---

## Decision 004 — Reporting-Window Mismatch

Previous decision:
The three target measures were initially treated as part of the same recent project window.

New decision:
The project explicitly documents that OP_18b covers 07/01/2024 to 06/30/2025, while EDV and OP_22 cover 01/01/2024 to 12/31/2024.

Reason for revision:
The measures are recent and relevant, but not perfectly synchronized.

Evidence:
SQL QA confirmed reporting windows:

- EDV: 01/01/2024 to 12/31/2024
- OP_22: 01/01/2024 to 12/31/2024
- OP_18b: 07/01/2024 to 06/30/2025

Effect on scope or methodology:
The measures can support recent operational screening, but associations between OP_18b and OP_22 will not be interpreted causally or as perfectly time-aligned.

---

## Decision 005 — Facility ID Data Type

Previous decision:
Facility ID type was not yet formally locked.

New decision:
Facility ID is stored and processed as text throughout the project.

Reason for revision:
Facility IDs can contain leading zeroes. Treating them as numeric risks corrupting join keys.

Evidence:
The SQL mart preview confirmed values such as 010001, 010005, and 010006 were preserved after export.

Effect on scope or methodology:
All raw loading, SQLite staging, CSV exports, and Python reads should preserve facility_id as text.

---

## Decision 006 — Raw Staging Design

Previous decision:
Raw staging design was not yet formalized.

New decision:
Raw CMS files are loaded into immutable raw SQLite tables. Cleaning, typing, filtering, and pivoting are handled in separate SQL views.

Raw tables:

- raw_hospital_general
- raw_timely_effective_care

Reason for revision:
Separating raw staging from typed staging keeps source data auditable and rebuildable.

Evidence:
Raw tables were created in SQLite and validated through row counts, duplicate checks, target measure checks, reporting-window checks, and join coverage checks.

Effect on scope or methodology:
Raw tables should not be manually edited. Any transformation must happen in SQL views or processed exports.

---

## Decision 007 — Typed Staging View

Previous decision:
Typed staging fields were not yet created.

New decision:
Create a typed staging view called stg_ed_measures.

The view preserves:

- score_raw
- availability_status
- score_numeric
- score_category
- footnote
- start_date
- end_date

Reason for revision:
The raw score field contains both categorical and numeric values, so safe analysis requires measure-specific typing.

Evidence:
EDV contains categorical values. OP_18b and OP_22 contain numeric-looking values plus Not Available.

Effect on scope or methodology:
EDV remains categorical. OP_18b and OP_22 become numeric only when available. Not Available values are preserved in status fields.

---

## Decision 008 — Analytical Mart Grain

Previous decision:
The final analytical