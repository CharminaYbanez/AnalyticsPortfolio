# Phase 2 — Data Understanding, SQL Staging and Quality Checks

## Current Status

Phase 2 is complete.

The CMS raw files were loaded into SQLite, validated through SQL QA checks, transformed into a typed staging view, and exported as a hospital-level analytical mart for Python analysis.

## Project

Healthcare Operations Analytics — ED Throughput Benchmarking

## Stakeholder and Decision Question

Primary stakeholder:
Health-system Operations / Quality Improvement Analyst

Secondary stakeholders:
Hospital Operations Director, Emergency Department Manager, Quality Improvement Team

Decision question:
Which hospitals show unusually weak emergency-department throughput indicators relative to available ED-volume peer categories and should receive further operational review?

## Phase Purpose

Phase 2 validates whether the source data can safely support the planned analytical layer.

This phase matters because the project depends on:

- correct table grain
- reliable joins
- preserved facility identifiers
- valid measure filtering
- documented reporting windows
- defensible missingness handling
- safe numeric conversion
- one-row-per-hospital analytical output

## Raw Data Sources

Raw files used:

- Hospital_General_Information.csv
- Timely_and_Effective_Care-Hospital.csv
- HOSPITAL_Data_Dictionary.pdf

Raw files were stored in:

data/raw/

## SQLite Database

Database created:

data/database/healthcare_operations_cms.db

Raw tables created:

- raw_hospital_general
- raw_timely_effective_care

Staging view created:

- stg_ed_measures

Analytical mart created:

- mart_hospital_ed_throughput

Exported processed file:

data/processed/healthcare_ed_throughput_mart.csv

## SQL Scripts

SQL files used:

- sql/01_raw_staging.sql
- sql/02_qa_checks.sql
- sql/03_staging_views.sql
- sql/04_analytical_table.sql

## Confirmed Source Grain

Hospital General Information:

- 5,432 rows
- 5,432 unique facility_id values
- No duplicate facility_id values
- Confirmed grain: one row per facility_id

Timely and Effective Care:

- 138,173 rows
- 4,660 unique facility_id values
- No duplicate facility_id + measure_id combinations in this release
- Confirmed grain: one row per facility_id × measure_id

## Target Measures

The project filters Timely and Effective Care to three ED-related measures:

- EDV — Emergency department volume
- OP_18b — Median ED arrival-to-departure time for discharged patients
- OP_22 — Left before being seen

Target measure coverage:

- EDV: 4,660 rows and 4,660 unique facilities
- OP_18b: 4,660 rows and 4,660 unique facilities
- OP_22: 4,660 rows and 4,660 unique facilities

## Reporting Windows

Confirmed reporting windows:

- EDV: 01/01/2024 to 12/31/2024
- OP_22: 01/01/2024 to 12/31/2024
- OP_18b: 07/01/2024 to 06/30/2025

Important limitation:
OP_18b uses a different reporting window from EDV and OP_22. These measures can support recent operational screening, but their association should not be interpreted as perfectly time-aligned or causal.

## Score Availability

Raw score availability:

- EDV: 823 Not Available values
- OP_18b: 583 Not Available values
- OP_22: 828 Not Available values

EDV category distribution:

- low: 1,666
- medium: 915
- Not Available: 823
- very high: 704
- high: 552

## Typed Staging Logic

The staging view stg_ed_measures preserves raw score values and creates safer analysis fields.

Fields created:

- score_raw
- availability_status
- score_numeric
- score_category

Logic:

- EDV remains categorical.
- OP_18b and OP_22 are converted to numeric only when available.
- Not Available values are preserved in score_raw and availability_status.
- Not Available values become NULL in numeric/category fields.
- Footnotes and reporting dates are preserved.

Typed staging validation:

EDV:

- 4,660 rows
- 3,837 available category values
- 823 Not Available
- 0 numeric values

OP_18b:

- 4,660 rows
- 4,077 available numeric values
- 583 Not Available
- 0 category values

OP_22:

- 4,660 rows
- 3,832 available numeric values
- 828 Not Available
- 0 category values

## Join Coverage

Target ED-measure facilities were joined to Hospital General Information.

Join coverage:

- Target facilities: 4,660
- Matched facilities: 4,660
- Missing from Hospital General Information: 0

## Analytical Mart

The final SQL mart is:

mart_hospital_ed_throughput

Expected grain:

one row per hospital

Validation results:

- Row count: 4,660
- Unique facilities: 4,660
- No duplicate facility_id rows

Fields included:

- facility_id
- facility_name
- city_town
- state
- hospital_type
- hospital_ownership
- emergency_services
- ed_volume_category
- op_18b_median_wait_min
- op_22_lwbs_pct
- edv_availability_status
- op_18b_availability_status
- op_22_availability_status
- edv_footnote
- op_18b_footnote
- op_22_footnote
- edv_start_date
- edv_end_date
- op_18b_start_date
- op_18b_end_date
- op_22_start_date
- op_22_end_date

## Export Validation

The mart was exported to:

data/processed/healthcare_ed_throughput_mart.csv

Export validation:

- Rows exported: 4,660
- Columns exported: 22
- Unique facilities: 4,660
- Facility IDs preserved as six-character text, for example 010001, 010005, and 010006

## Decisions Locked

1. Facility ID is treated as text.
2. Raw source tables are immutable staging tables.
3. EDV is a categorical peer-group field, not a performance metric.
4. OP_18b and OP_22 are numeric outcome measures only after safe staging conversion.
5. Not Available values are preserved and documented, not silently dropped.
6. Footnotes are retained for later interpretation.
7. The analytical mart includes the 4,660 hospitals with target ED-measure records.
8. Reporting-window mismatch is documented as a limitation.
9. Benchmarking will occur only after the SQL mart has been validated.

## Rejected Alternatives

Rejected:

- Dropping hospitals with Not Available values during SQL staging.
- Treating EDV as numeric.
- Creating a composite performance score.
- Joining and pivoting before validating source grain.
- Benchmarking before creating a validated hospital-level mart.
- Treating the measures as perfectly synchronized across reporting windows.

## Limitations and Risks

- EDV and OP_22 use calendar year 2024, while OP_18b uses July 2024 to June 2025.
- EDV peer groups do not fully adjust for trauma level, staffing, capacity, boarding pressure, patient acuity, or local demand shocks.
- Not Available values may reflect reporting or suppression conditions and should not be treated as ordinary random missingness.
- The project can identify hospitals for operational review, but cannot diagnose causes of throughput issues.
- The project should not label hospitals as poor performers or make causal claims.

## Phase 2 Checkpoint

✅ Completed work:

- Loaded CMS raw files into SQLite.
- Created raw staging tables.
- Confirmed row counts and unique facility counts.
- Confirmed table grain.
- Checked duplicate keys.
- Confirmed ED target measure coverage.
- Confirmed reporting windows.
- Checked score availability.
- Confirmed EDV category distribution.
- Created typed staging view.
- Created hospital-level analytical mart.
- Exported validated mart to data/processed/.

🔒 Decisions locked:

- Facility ID remains text.
- EDV is categorical.
- OP_18b and OP_22 are numeric outcome fields after safe conversion.
- Not Available values are preserved.
- Footnotes and reporting dates are retained.
- The Day 2 Python input is healthcare_ed_throughput_mart.csv.

⚠️ Limitations and risks:

- Reporting windows are not perfectly synchronized.
- Peer groups do not adjust for operational complexity.
- Missingness requires caution.
- No causal interpretation is supported.

❓ Unresolved questions:

- Final peer-benchmark threshold still needs to be selected in Phase 3.
- Footnote meanings may need decoding if they materially affect interpretation.
- Visual selection will be finalized in Phase 4.

➡️ Immediate next action:

Begin Day 2 / Phase 3 Python analysis using:

data/processed/healthcare_ed_throughput_mart.csv

🛑 Clean stopping point:

Yes. Phase 2 is complete and the project is ready for Day 2 Python analysis.