/*
===============================================================================
PROJECT
Alberta Home Insurance Premium Pressure Monitor

FILE
02_load_data_notes.sql

PURPOSE
Document how the approved source datasets were prepared and loaded into the
SQLite warehouse.

This file is primarily documentation. The actual load process was executed
through:

    notebooks/02_build_sql_warehouse.ipynb

DATABASE
    data/database/alberta_home_insurance.db

RAW-DATA POLICY
Raw source files are preserved without modification.

The SQLite tables are reproducible working copies. During development, database
tables may be dropped, recreated, and reloaded without altering the raw files.

LOAD WORKFLOW
Raw source files
    -> Python/pandas preparation
    -> SQLite warehouse tables
    -> SQL quality checks
    -> SQL analytical views
    -> Python analysis
    -> Power BI dashboard

===============================================================================
LOAD ORDER
===============================================================================

1. dim_date
2. fact_cpi
3. fact_construction_cost
4. fact_hail_loss_event

The date dimension must be loaded before the fact tables because the fact tables
reference date_id values in dim_date.

===============================================================================
TABLE: dim_date
===============================================================================

TARGET GRAIN
One row per monthly date period represented in the project calendar.

PURPOSE
Provide a shared date spine for CPI, construction-cost, catastrophe-event,
Python, and Power BI analysis.

FINAL ROW COUNT
121 rows

CONFIRMED COVERAGE
2016-01 through 2026-01, based on the combined analytical calendar required by
the source datasets.

IMPORTANT ATTRIBUTES
The date dimension includes reusable calendar fields such as:

- date_id
- date
- year
- month
- quarter
- five-year cohort

The exact field names are defined in:

    sql/01_create_tables.sql

LOAD NOTES
- date_id uses the approved YYYYMM integer format.
- The table supports monthly CPI data and alignment with less-frequent sources.
- The five-year cohort supports comparison of 2016-2020 and 2021-2025.

EXPECTED QA
- date_id is unique.
- Required date fields contain no NULL values.
- Dates are chronologically valid.
- Each monthly period appears once.

===============================================================================
TABLE: fact_cpi
===============================================================================

TARGET GRAIN
One row per date, geography, and CPI series/category combination.

PURPOSE
Store the CPI series used in the core analysis and sensitivity work.

FINAL ROW COUNT
360 rows

CORE SERIES
The warehouse supports the approved project comparisons, including:

- Alberta homeowners' insurance CPI
- Canada homeowners' insurance CPI
- Alberta all-items CPI

The later sensitivity check also used Alberta passenger vehicle insurance CPI.
Confirm whether that series was loaded into fact_cpi during the original
warehouse build or added separately during Python analysis before changing this
load documentation.

SOURCE NOTE
The first CPI extract was rejected because it stopped in 2022.

A corrected Statistics Canada database-loading CSV was downloaded and used for
the final warehouse load.

IMPORTANT TRANSFORMATIONS
- Parsed reporting periods into the approved date_id format.
- Retained CPI data in long format.
- Converted observation values to numeric form.
- Preserved geography and CPI-series labels.
- Retained or standardized revision-status information where available.
- Restricted the load to the approved project series and study coverage.

EXPECTED QA
- The expected combination of date, geography, and CPI category is unique.
- CPI values are numeric.
- Required fields contain no NULL values.
- date_id values match dim_date.
- Core CPI coverage is 2016-01 through 2025-12.
- Category and geography labels match the approved series.

===============================================================================
TABLE: fact_construction_cost
===============================================================================

TARGET GRAIN
One row per available construction-cost reporting period and selected benchmark
series.

PURPOSE
Provide replacement-cost context for Alberta home-insurance price pressure.

FINAL ROW COUNT
37 rows

CONFIRMED COVERAGE
2017-01 through 2026-01.

IMPORTANT LIMITATION
The construction-cost benchmark begins in 2017, while the core CPI comparison
uses a 2016 baseline.

The series therefore cannot be indexed from the same starting period without
explicitly documenting the baseline difference.

GEOGRAPHIC PROXY
The table includes a geographic_proxy_flag or equivalent field to identify
whether the selected construction series is:

- province-wide
- a Calgary CMA proxy
- an Edmonton CMA proxy
- an Alberta metro proxy
- another documented geographic approximation

Use the exact values present in the source and schema.

IMPORTANT TRANSFORMATIONS
- Parsed reporting periods into date_id.
- Converted construction-index observations to numeric form.
- Preserved reporting frequency.
- Retained source geography and proxy classification.
- Did not fabricate values for missing monthly periods.

EXPECTED QA
- Required identifiers and numeric values contain no unexpected NULLs.
- date_id values match dim_date.
- Index values are numeric and plausible.
- Date coverage begins in 2017.
- Geographic-proxy status is documented for every row.

===============================================================================
TABLE: fact_hail_loss_event
===============================================================================

TARGET GRAIN
One row per curated Alberta catastrophe event.

PURPOSE
Provide timing and insured-loss context for the descriptive event-window
analysis.

FINAL ROW COUNT
6 rows

SOURCE APPROACH
The table contains a curated set of major Alberta insured-loss events used for
contextual analysis.

"Curated" means that the project intentionally selected documented events
relevant to the approved study scope rather than attempting to construct a
complete claims-level or weather-event database.

IMPORTANT INTERPRETATION RULE
Catastrophe events are timing and context markers.

They are not used as proof that a specific event caused a subsequent CPI
increase.

IMPORTANT TRANSFORMATIONS
- Standardized event dates.
- Created or mapped event date_id values.
- Converted insured-loss amounts to numeric values.
- Preserved event labels and source descriptions.
- Retained claim-count values only where documented.
- Did not impute unavailable claim counts or event attributes.

EXPECTED QA
- Each curated event appears once.
- Event identifiers are unique.
- Event dates are valid.
- date_id values match dim_date.
- Insured-loss values are numeric and non-negative.
- Base-table event totals reconcile with analytical-view totals.

===============================================================================
FINAL LOAD RESULTS
===============================================================================

Expected final warehouse row counts:

- dim_date: 121
- fact_cpi: 360
- fact_construction_cost: 37
- fact_hail_loss_event: 6

All final loads must be followed by:

    sql/03_quality_checks.sql

Analytical views are created only after the base-table QA checks pass:

    sql/04_create_views.sql

===============================================================================
RELOAD INSTRUCTIONS
===============================================================================

1. Confirm that the approved raw files exist in data/raw/.
2. Confirm that sql/01_create_tables.sql contains the approved schema.
3. Run notebooks/02_build_sql_warehouse.ipynb from top to bottom.
4. Confirm that the database is created at:
       data/database/alberta_home_insurance.db
5. Confirm the four expected base tables exist.
6. Run sql/03_quality_checks.sql.
7. Investigate and resolve any failed check.
8. Run sql/04_create_views.sql only after the base tables pass QA.
9. Validate analytical-view totals before beginning Python analysis.

===============================================================================
KNOWN LOAD ISSUES AND RESOLUTIONS
===============================================================================

ISSUE 1
The first CPI source file ended in 2022.

RESOLUTION
The incomplete file was rejected and replaced with the corrected Statistics
Canada database-loading CSV.

ISSUE 2
The construction benchmark begins in 2017 rather than 2016.

RESOLUTION
The source was retained, and the different baseline was documented throughout
the analysis and final reporting.

ISSUE 3
The first annual summary view multiplied catastrophe-loss totals because fact
tables with different grains were joined before aggregation.

RESOLUTION
CPI, construction-cost, and catastrophe-event data were pre-aggregated
separately before the annual results were joined.

This correction belongs primarily to the analytical-view logic, but it is
documented here because it is an important warehouse-validation lesson.
*/