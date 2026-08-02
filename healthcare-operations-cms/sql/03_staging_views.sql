-- ============================================================
-- Healthcare Operations CMS
-- Block 3: Typed Staging Views
-- Script: 03_staging_views.sql
-- Purpose: Create cleaned measure-level staging views while preserving raw values
-- ============================================================

DROP VIEW IF EXISTS stg_ed_measures;

CREATE VIEW stg_ed_measures AS
SELECT
    facility_id,
    measure_id,
    measure_name,
    score AS score_raw,
    CASE
        WHEN score = 'Not Available' THEN 'Not Available'
        WHEN score IS NULL OR TRIM(score) = '' THEN 'Missing'
        ELSE 'Available'
    END AS availability_status,

    CASE
        WHEN measure_id IN ('OP_18b', 'OP_22')
            AND score <> 'Not Available'
            AND score IS NOT NULL
            AND TRIM(score) <> ''
        THEN CAST(score AS REAL)
        ELSE NULL
    END AS score_numeric,

    CASE
        WHEN measure_id = 'EDV'
            AND score <> 'Not Available'
            AND score IS NOT NULL
            AND TRIM(score) <> ''
        THEN score
        ELSE NULL
    END AS score_category,
    footnote,
    start_date,
    end_date
FROM raw_timely_effective_care
WHERE measure_id IN ('EDV', 'OP_22', 'OP_18b');