-- ============================================================
-- Healthcare Operations CMS
-- Block 4: Hospital-Level Analytical Table
-- Script: 04_analytical_table.sql
-- Purpose: Create one-row-per-hospital analytical view for ED throughput analysis
-- ============================================================

DROP VIEW IF EXISTS mart_hospital_ed_throughput;

CREATE VIEW mart_hospital_ed_throughput AS
SELECT
    hg.facility_id,
    hg.facility_name,
    hg.city_town,
    hg.state,
    hg.hospital_type,
    hg.hospital_ownership,
    hg.emergency_services,

    MAX(CASE WHEN ed.measure_id = 'EDV' THEN ed.score_category END) AS ed_volume_category,
    MAX(CASE WHEN ed.measure_id = 'OP_18b' THEN ed.score_numeric END) AS op_18b_median_wait_min,
    MAX(CASE WHEN ed.measure_id = 'OP_22' THEN ed.score_numeric END) AS op_22_lwbs_pct,

    MAX(CASE WHEN ed.measure_id = 'EDV' THEN ed.availability_status END) AS edv_availability_status,
    MAX(CASE WHEN ed.measure_id = 'OP_18b' THEN ed.availability_status END) AS op_18b_availability_status,
    MAX(CASE WHEN ed.measure_id = 'OP_22' THEN ed.availability_status END) AS op_22_availability_status,

    MAX(CASE WHEN ed.measure_id = 'EDV' THEN ed.footnote END) AS edv_footnote,
    MAX(CASE WHEN ed.measure_id = 'OP_18b' THEN ed.footnote END) AS op_18b_footnote,
    MAX(CASE WHEN ed.measure_id = 'OP_22' THEN ed.footnote END) AS op_22_footnote,

    MAX(CASE WHEN ed.measure_id = 'EDV' THEN ed.start_date END) AS edv_start_date,
    MAX(CASE WHEN ed.measure_id = 'EDV' THEN ed.end_date END) AS edv_end_date,

    MAX(CASE WHEN ed.measure_id = 'OP_18b' THEN ed.start_date END) AS op_18b_start_date,
    MAX(CASE WHEN ed.measure_id = 'OP_18b' THEN ed.end_date END) AS op_18b_end_date,

    MAX(CASE WHEN ed.measure_id = 'OP_22' THEN ed.start_date END) AS op_22_start_date,
    MAX(CASE WHEN ed.measure_id = 'OP_22' THEN ed.end_date END) AS op_22_end_date

FROM raw_hospital_general AS hg
LEFT JOIN stg_ed_measures AS ed
    ON hg.facility_id = ed.facility_id
WHERE ed.facility_id IS NOT NULL
GROUP BY
    hg.facility_id,
    hg.facility_name,
    hg.city_town,
    hg.state,
    hg.hospital_type,
    hg.hospital_ownership,
    hg.emergency_services;
