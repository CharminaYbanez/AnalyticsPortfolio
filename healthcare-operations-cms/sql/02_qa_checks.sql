-- ============================================================
-- Healthcare Operations CMS
-- Block 2: Raw QA Checks
-- Script: 02_qa_checks.sql
-- Purpose: Validate raw table grain, keys, target measure coverage,
--          reporting windows, score availability, and join coverage
-- ============================================================

-- ============================================================
-- QA 1: Raw table row counts and unique facility counts
-- Expected:
-- raw_hospital_general rows = 5,432
-- raw_hospital_general unique facilities = 5,432
-- raw_timely_effective_care rows = 138,173
-- raw_timely_effective_care unique facilities = 4,660
-- ============================================================

SELECT
    'raw_hospital_general' AS check_name,
    COUNT(*) AS row_count
FROM raw_hospital_general

UNION ALL

SELECT
    'raw_hospital_general_unique_facilities' AS check_name,
    COUNT(DISTINCT facility_id) AS row_count
FROM raw_hospital_general

UNION ALL

SELECT
    'raw_timely_effective_care' AS check_name,
    COUNT(*) AS row_count
FROM raw_timely_effective_care

UNION ALL

SELECT
    'raw_timely_effective_care_unique_facilities' AS check_name,
    COUNT(DISTINCT facility_id) AS row_count
FROM raw_timely_effective_care;


-- ============================================================
-- QA 2: Duplicate facility_id check in Hospital General Information
-- Expected result: no rows returned
-- Confirms raw_hospital_general grain is one row per facility_id
-- ============================================================

SELECT
    facility_id,
    COUNT(*) AS row_count
FROM raw_hospital_general
GROUP BY facility_id
HAVING COUNT(*) > 1;


-- ============================================================
-- QA 3: Duplicate facility_id + measure_id check in Timely and Effective Care
-- Expected result: no rows returned
-- Confirms raw_timely_effective_care grain is one row per facility_id × measure_id
-- ============================================================

SELECT
    facility_id,
    measure_id,
    COUNT(*) AS row_count
FROM raw_timely_effective_care
GROUP BY
    facility_id,
    measure_id
HAVING COUNT(*) > 1;


-- ============================================================
-- QA 4: Target ED measure coverage
-- Expected:
-- EDV = 4,660 rows and 4,660 unique facilities
-- OP_18b = 4,660 rows and 4,660 unique facilities
-- OP_22 = 4,660 rows and 4,660 unique facilities
-- ============================================================

SELECT
    measure_id,
    COUNT(*) AS row_count,
    COUNT(DISTINCT facility_id) AS unique_facilities
FROM raw_timely_effective_care
WHERE measure_id IN ('EDV', 'OP_22', 'OP_18b')
GROUP BY measure_id
ORDER BY measure_id;


-- ============================================================
-- QA 5: Target ED measure reporting windows
-- Expected:
-- EDV    = 01/01/2024 to 12/31/2024
-- OP_22  = 01/01/2024 to 12/31/2024
-- OP_18b = 07/01/2024 to 06/30/2025
-- ============================================================

SELECT
    measure_id,
    start_date,
    end_date,
    COUNT(*) AS row_count
FROM raw_timely_effective_care
WHERE measure_id IN ('EDV', 'OP_22', 'OP_18b')
GROUP BY
    measure_id,
    start_date,
    end_date
