-- ============================================================
-- Alberta Home Insurance Analytics
-- Phase 2: SQL Warehouse & Quality Checks
-- Script: 03_quality_checks.sql
-- Purpose: Validate loaded base tables before creating views
-- ============================================================

PRAGMA foreign_keys = ON;

-- ============================================================
-- 1. TABLE EXISTENCE
-- Expected: four rows, one for each required base table
-- ============================================================

SELECT
    name AS table_name
FROM sqlite_master
WHERE type = 'table'
  AND name IN (
      'dim_date',
      'fact_cpi',
      'fact_construction_cost',
      'fact_hail_loss_event'
  )
ORDER BY name;

-- ============================================================
-- 2. FINAL ROW COUNTS
-- Expected:
-- dim_date = 121
-- fact_cpi = 360
-- fact_construction_cost = 37
-- fact_hail_loss_event = 6
-- ============================================================

SELECT 'dim_date' AS table_name, COUNT(*) AS row_count
FROM dim_date

UNION ALL

SELECT 'fact_cpi', COUNT(*)
FROM fact_cpi

UNION ALL

SELECT 'fact_construction_cost', COUNT(*)
FROM fact_construction_cost

UNION ALL

SELECT 'fact_hail_loss_event', COUNT(*)
FROM fact_hail_loss_event;

-- ============================================================
-- 3. PRIMARY-KEY UNIQUENESS
-- Expected: total_rows = distinct_keys for every table
-- ============================================================

SELECT
    'dim_date' AS table_name,
    COUNT(*) AS total_rows,
    COUNT(DISTINCT date_id) AS distinct_keys
FROM dim_date

UNION ALL

SELECT
    'fact_cpi',
    COUNT(*),
    COUNT(DISTINCT cpi_id)
FROM fact_cpi

UNION ALL

SELECT
    'fact_construction_cost',
    COUNT(*),
    COUNT(DISTINCT construction_id)
FROM fact_construction_cost

UNION ALL

SELECT
    'fact_hail_loss_event',
    COUNT(*),
    COUNT(DISTINCT event_id)
FROM fact_hail_loss_event;

-- ============================================================
-- 4. DUPLICATE PRIMARY KEYS
-- Expected: zero rows from each query
-- ============================================================

SELECT date_id, COUNT(*) AS duplicate_count
FROM dim_date
GROUP BY date_id
HAVING COUNT(*) > 1;

SELECT cpi_id, COUNT(*) AS duplicate_count
FROM fact_cpi
GROUP BY cpi_id
HAVING COUNT(*) > 1;

SELECT construction_id, COUNT(*) AS duplicate_count
FROM fact_construction_cost
GROUP BY construction_id
HAVING COUNT(*) > 1;

SELECT event_id, COUNT(*) AS duplicate_count
FROM fact_hail_loss_event
GROUP BY event_id
HAVING COUNT(*) > 1;

-- ============================================================
-- 5. BUSINESS-GRAIN UNIQUENESS
-- Expected: zero rows
-- ============================================================

-- fact_cpi grain:
-- one row per date_id, geography, and cpi_category

SELECT
    date_id,
    geography,
    cpi_category,
    COUNT(*) AS duplicate_count
FROM fact_cpi
GROUP BY
    date_id,
    geography,
    cpi_category
HAVING COUNT(*) > 1;

-- fact_construction_cost grain:
-- one row per date_id, geography, and construction_category

SELECT
    date_id,
    geography,
    construction_category,
    COUNT(*) AS duplicate_count
FROM fact_construction_cost
GROUP BY
    date_id,
    geography,
    construction_category
HAVING COUNT(*) > 1;

-- dim_date should contain one row per calendar month

SELECT
    year_month,
    COUNT(*) AS duplicate_count
FROM dim_date
GROUP BY year_month
HAVING COUNT(*) > 1;

SELECT
    calendar_date,
    COUNT(*) AS duplicate_count
FROM dim_date
GROUP BY calendar_date
HAVING COUNT(*) > 1;

-- ============================================================
-- 6. REQUIRED-FIELD NULL CHECKS
-- Expected: every reported count = 0
-- ============================================================

SELECT
    SUM(CASE WHEN date_id IS NULL THEN 1 ELSE 0 END) AS missing_date_id,
    SUM(CASE WHEN calendar_date IS NULL THEN 1 ELSE 0 END) AS missing_calendar_date,
    SUM(CASE WHEN year_month IS NULL THEN 1 ELSE 0 END) AS missing_year_month,
    SUM(CASE WHEN year IS NULL THEN 1 ELSE 0 END) AS missing_year,
    SUM(CASE WHEN quarter IS NULL THEN 1 ELSE 0 END) AS missing_quarter,
    SUM(CASE WHEN month_number IS NULL THEN 1 ELSE 0 END) AS missing_month_number
FROM dim_date;

SELECT
    SUM(CASE WHEN cpi_id IS NULL THEN 1 ELSE 0 END) AS missing_cpi_id,
    SUM(CASE WHEN date_id IS NULL THEN 1 ELSE 0 END) AS missing_date_id,
    SUM(CASE WHEN geography IS NULL THEN 1 ELSE 0 END) AS missing_geography,
    SUM(CASE WHEN cpi_category IS NULL THEN 1 ELSE 0 END) AS missing_cpi_category,
    SUM(CASE WHEN cpi_value IS NULL THEN 1 ELSE 0 END) AS missing_cpi_value
FROM fact_cpi;

SELECT
    SUM(CASE WHEN construction_id IS NULL THEN 1 ELSE 0 END) AS missing_construction_id,
    SUM(CASE WHEN date_id IS NULL THEN 1 ELSE 0 END) AS missing_date_id,
    SUM(CASE WHEN geography IS NULL THEN 1 ELSE 0 END) AS missing_geography,
    SUM(CASE WHEN construction_category IS NULL THEN 1 ELSE 0 END) AS missing_category,
    SUM(CASE WHEN construction_index_value IS NULL THEN 1 ELSE 0 END) AS missing_index_value
FROM fact_construction_cost;

SELECT
    SUM(CASE WHEN event_id IS NULL THEN 1 ELSE 0 END) AS missing_event_id,
    SUM(CASE WHEN event_date IS NULL THEN 1 ELSE 0 END) AS missing_event_date,
    SUM(CASE WHEN date_id IS NULL THEN 1 ELSE 0 END) AS missing_date_id,
    SUM(CASE WHEN event_name IS NULL THEN 1 ELSE 0 END) AS missing_event_name
FROM fact_hail_loss_event;

-- ============================================================
-- 7. BLANK-TEXT CHECKS
-- NOT NULL does not prevent empty strings.
-- Expected: every reported count = 0
-- ============================================================

SELECT
    SUM(CASE WHEN TRIM(calendar_date) = '' THEN 1 ELSE 0 END) AS blank_calendar_date,
    SUM(CASE WHEN TRIM(year_month) = '' THEN 1 ELSE 0 END) AS blank_year_month
FROM dim_date;

SELECT
    SUM(CASE WHEN TRIM(geography) = '' THEN 1 ELSE 0 END) AS blank_geography,
    SUM(CASE WHEN TRIM(cpi_category) = '' THEN 1 ELSE 0 END) AS blank_cpi_category
FROM fact_cpi;

SELECT
    SUM(CASE WHEN TRIM(geography) = '' THEN 1 ELSE 0 END) AS blank_geography,
    SUM(CASE WHEN TRIM(construction_category) = '' THEN 1 ELSE 0 END) AS blank_category
FROM fact_construction_cost;

SELECT
    SUM(CASE WHEN TRIM(event_date) = '' THEN 1 ELSE 0 END) AS blank_event_date,
    SUM(CASE WHEN TRIM(event_name) = '' THEN 1 ELSE 0 END) AS blank_event_name
FROM fact_hail_loss_event;

-- ============================================================
-- 8. FOREIGN-KEY / ORPHAN CHECKS
-- Expected: every orphan count = 0
-- ============================================================

SELECT COUNT(*) AS orphan_cpi_rows
FROM fact_cpi AS c
LEFT JOIN dim_date AS d
    ON c.date_id = d.date_id
WHERE d.date_id IS NULL;

SELECT COUNT(*) AS orphan_construction_rows
FROM fact_construction_cost AS c
LEFT JOIN dim_date AS d
    ON c.date_id = d.date_id
WHERE d.date_id IS NULL;

SELECT COUNT(*) AS orphan_event_rows
FROM fact_hail_loss_event AS e
LEFT JOIN dim_date AS d
    ON e.date_id = d.date_id
WHERE d.date_id IS NULL;

-- SQLite's built-in foreign-key diagnostic.
-- Expected: zero rows.

PRAGMA foreign_key_check;

-- ============================================================
-- 9. DATE-DIMENSION VALIDITY
-- Expected: invalid counts = 0
-- ============================================================

SELECT
    SUM(CASE WHEN month_number NOT BETWEEN 1 AND 12 THEN 1 ELSE 0 END)
        AS invalid_month_number,
    SUM(CASE WHEN quarter NOT BETWEEN 1 AND 4 THEN 1 ELSE 0 END)
        AS invalid_quarter,
    SUM(
        CASE
            WHEN date_id <> (year * 100 + month_number)
            THEN 1 ELSE 0
        END
    ) AS inconsistent_date_id,
    SUM(
        CASE
            WHEN year_month <> printf('%04d-%02d', year, month_number)
            THEN 1 ELSE 0
        END
    ) AS inconsistent_year_month
FROM dim_date;

-- Check whether calendar_date is the first day of its month.
-- Expected: invalid_calendar_date = 0

SELECT COUNT(*) AS invalid_calendar_date
FROM dim_date
WHERE calendar_date <> year_month || '-01';

-- Expected consecutive monthly calendar:
-- min_date_id = 201601
-- max_date_id = 202601
-- row_count = 121

SELECT
    MIN(date_id) AS min_date_id,
    MAX(date_id) AS max_date_id,
    MIN(calendar_date) AS min_calendar_date,
    MAX(calendar_date) AS max_calendar_date,
    COUNT(*) AS row_count
FROM dim_date;

-- ============================================================
-- 10. FACT-TABLE DATE COVERAGE
-- ============================================================

-- Expected CPI coverage: 2016-01 through 2025-12

SELECT
    MIN(d.year_month) AS first_cpi_month,
    MAX(d.year_month) AS last_cpi_month,
    COUNT(DISTINCT c.date_id) AS distinct_cpi_months
FROM fact_cpi AS c
INNER JOIN dim_date AS d
    ON c.date_id = d.date_id;

-- Expected construction coverage: 2017-01 through 2026-01

SELECT
    MIN(d.year_month) AS first_construction_period,
    MAX(d.year_month) AS last_construction_period,
    COUNT(DISTINCT c.date_id) AS distinct_construction_periods
FROM fact_construction_cost AS c
INNER JOIN dim_date AS d
    ON c.date_id = d.date_id;

-- Event coverage for the curated event table

SELECT
    MIN(event_date) AS first_event_date,
    MAX(event_date) AS last_event_date,
    COUNT(*) AS event_count
FROM fact_hail_loss_event;

-- ============================================================
-- 11. NUMERIC VALIDITY
-- Expected: every invalid count = 0
-- ============================================================

SELECT COUNT(*) AS invalid_cpi_values
FROM fact_cpi
WHERE cpi_value <= 0;

SELECT COUNT(*) AS invalid_construction_values
FROM fact_construction_cost
WHERE construction_index_value <= 0;

SELECT COUNT(*) AS invalid_initial_loss_values
FROM fact_hail_loss_event
WHERE initial_loss_cad < 0;

SELECT COUNT(*) AS invalid_revised_loss_values
FROM fact_hail_loss_event
WHERE revised_loss_cad < 0;

SELECT COUNT(*) AS invalid_claim_counts
FROM fact_hail_loss_event
WHERE claim_count < 0;

-- ============================================================
-- 12. CATEGORY AND SOURCE REVIEW
-- Review returned values for consistency.
-- ============================================================

SELECT
    geography,
    cpi_category,
    COUNT(*) AS row_count,
    MIN(cpi_value) AS minimum_cpi,
    MAX(cpi_value) AS maximum_cpi
FROM fact_cpi
GROUP BY
    geography,
    cpi_category
ORDER BY
    geography,
    cpi_category;

SELECT
    geography,
    construction_category,
    frequency,
    geographic_proxy_flag,
    COUNT(*) AS row_count,
    MIN(construction_index_value) AS minimum_index,
    MAX(construction_index_value) AS maximum_index
FROM fact_construction_cost
GROUP BY
    geography,
    construction_category,
    frequency,
    geographic_proxy_flag
ORDER BY
    geography,
    construction_category;

SELECT
    province,
    peril_type,
    revision_flag,
    COUNT(*) AS event_count
FROM fact_hail_loss_event
GROUP BY
    province,
    peril_type,
    revision_flag
ORDER BY
    province,
    peril_type,
    revision_flag;

-- ============================================================
-- 13. REVISION-FLAG VALIDITY
-- Expected: invalid_revision_flags = 0
-- ============================================================

SELECT COUNT(*) AS invalid_revision_flags
FROM fact_hail_loss_event
WHERE revision_flag NOT IN (0, 1)
  AND revision_flag IS NOT NULL;

-- ============================================================
-- 14. CPI SERIES COMPLETENESS
-- Core monthly series should contain 120 observations each
-- for 2016-01 through 2025-12.
-- ============================================================

SELECT
    geography,
    cpi_category,
    COUNT(*) AS observation_count,
    COUNT(DISTINCT date_id) AS distinct_months,
    MIN(date_id) AS first_date_id,
    MAX(date_id) AS last_date_id
FROM fact_cpi
GROUP BY
    geography,
    cpi_category
ORDER BY
    geography,
    cpi_category;

-- ============================================================
-- 15. EVENT TOTALS FOR LATER VIEW RECONCILIATION
-- Record these outputs, then compare them with
-- vw_catastrophe_events and vw_annual_summary after running
-- sql/04_create_views.sql.
-- ============================================================

SELECT
    COUNT(*) AS base_event_count,
    ROUND(SUM(initial_loss_cad), 2) AS total_initial_loss_cad,
    ROUND(SUM(revised_loss_cad), 2) AS total_revised_loss_cad,
    SUM(claim_count) AS total_claim_count
FROM fact_hail_loss_event;

SELECT
    d.year,
    COUNT(DISTINCT e.event_id) AS event_count,
    ROUND(SUM(e.revised_loss_cad), 2) AS total_revised_loss_cad
FROM fact_hail_loss_event AS e
INNER JOIN dim_date AS d
    ON e.date_id = d.date_id
GROUP BY d.year
ORDER BY d.year;

-- ============================================================
-- 16. COMPACT PASS / FAIL SUMMARY
-- Each row should return PASS.
-- ============================================================

SELECT
    'dim_date row count' AS check_name,
    CASE WHEN COUNT(*) = 121 THEN 'PASS' ELSE 'FAIL' END AS status,
    COUNT(*) AS actual_value,
    121 AS expected_value
FROM dim_date

UNION ALL

SELECT
    'fact_cpi row count',
    CASE WHEN COUNT(*) = 360 THEN 'PASS' ELSE 'FAIL' END,
    COUNT(*),
    360
FROM fact_cpi

UNION ALL

SELECT
    'fact_construction_cost row count',
    CASE WHEN COUNT(*) = 37 THEN 'PASS' ELSE 'FAIL' END,
    COUNT(*),
    37
FROM fact_construction_cost

UNION ALL

SELECT
    'fact_hail_loss_event row count',
    CASE WHEN COUNT(*) = 6 THEN 'PASS' ELSE 'FAIL' END,
    COUNT(*),
    6
FROM fact_hail_loss_event

UNION ALL

SELECT
    'fact_cpi orphan rows',
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
    COUNT(*),
    0
FROM fact_cpi AS c
LEFT JOIN dim_date AS d
    ON c.date_id = d.date_id
WHERE d.date_id IS NULL

UNION ALL

SELECT
    'fact_construction_cost orphan rows',
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
    COUNT(*),
    0
FROM fact_construction_cost AS c
LEFT JOIN dim_date AS d
    ON c.date_id = d.date_id
WHERE d.date_id IS NULL

UNION ALL

SELECT
    'fact_hail_loss_event orphan rows',
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
    COUNT(*),
    0
FROM fact_hail_loss_event AS e
LEFT JOIN dim_date AS d
    ON e.date_id = d.date_id
WHERE d.date_id IS NULL

UNION ALL

SELECT
    'invalid CPI values',
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
    COUNT(*),
    0
FROM fact_cpi
WHERE cpi_value <= 0

UNION ALL

SELECT
    'invalid construction values',
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
    COUNT(*),
    0
FROM fact_construction_cost
WHERE construction_index_value <= 0

UNION ALL

SELECT
    'invalid revision flags',
    CASE WHEN COUNT(*) = 0 THEN 'PASS' ELSE 'FAIL' END,
    COUNT(*),
    0
FROM fact_hail_loss_event
WHERE revision_flag NOT IN (0, 1)
  AND revision_flag IS NOT NULL;