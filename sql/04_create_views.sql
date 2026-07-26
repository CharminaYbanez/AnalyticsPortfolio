-- ============================================================
-- Alberta Home Insurance Analytics
-- Phase 2: SQL Warehouse & Quality Checks
-- Script: 04_create_views.sql
-- Purpose: Create analysis-ready SQL views
-- ============================================================

DROP VIEW IF EXISTS vw_cpi_monthly;
DROP VIEW IF EXISTS vw_construction_quarterly;
DROP VIEW IF EXISTS vw_catastrophe_events;
DROP VIEW IF EXISTS vw_annual_summary;

-- ============================================================
-- View 1: Monthly CPI data
-- Purpose: Clean CPI view for analysis and visualization
-- ============================================================

CREATE VIEW vw_cpi_monthly AS
SELECT
    d.date_id,
    d.calendar_date,
    d.year_month,
    d.year,
    d.quarter,
    d.month_number,
    d.month_name,
    d.five_year_cohort,
    f.geography,
    f.cpi_category,
    f.cpi_value,
    f.source_table,
    f.source_name
FROM fact_cpi f
INNER JOIN dim_date d
    ON f.date_id = d.date_id;

-- ============================================================
-- View 2: Quarterly construction benchmark
-- Purpose: Clean construction cost benchmark view
-- ============================================================

CREATE VIEW vw_construction_quarterly AS
SELECT
    d.date_id,
    d.calendar_date,
    d.year_month,
    d.year,
    d.quarter,
    d.month_number,
    d.month_name,
    d.five_year_cohort,
    f.geography,
    f.construction_category,
    f.construction_index_value,
    f.frequency,
    f.geographic_proxy_flag,
    f.source_table,
    f.source_name
FROM fact_construction_cost f
INNER JOIN dim_date d
    ON f.date_id = d.date_id;

-- ============================================================
-- View 3: Catastrophe events
-- Purpose: Clean event markers for dashboard annotations
-- ============================================================

CREATE VIEW vw_catastrophe_events AS
SELECT
    e.event_id,
    e.event_date,
    e.date_id,
    d.year_month,
    d.year,
    d.quarter,
    d.five_year_cohort,
    e.event_name,
    e.primary_region,
    e.province,
    e.peril_type,
    e.initial_loss_cad,
    e.revised_loss_cad,
    e.claim_count,
    e.estimate_publication_date,
    e.loss_source,
    e.source_url,
    e.revision_flag,
    e.notes
FROM fact_hail_loss_event e
INNER JOIN dim_date d
    ON e.date_id = d.date_id;

-- ============================================================
-- View 4: Annual summary
-- Purpose: Annual rollup for high-level trend comparison
-- Note: Each dataset is pre-aggregated before joining to avoid
--       multiplying event losses across CPI categories.
-- ============================================================

CREATE VIEW vw_annual_summary AS
WITH cpi_annual AS (
    SELECT
        d.year,
        d.five_year_cohort,

        AVG(CASE
            WHEN c.geography = 'Alberta'
             AND c.cpi_category = 'All-items'
            THEN c.cpi_value
        END) AS alberta_all_items_cpi_avg,

        AVG(CASE
            WHEN c.geography = 'Alberta'
             AND c.cpi_category = 'Homeowners'' home and mortgage insurance'
            THEN c.cpi_value
        END) AS alberta_home_insurance_cpi_avg,

        AVG(CASE
            WHEN c.geography = 'Canada'
             AND c.cpi_category = 'Homeowners'' home and mortgage insurance'
            THEN c.cpi_value
        END) AS canada_home_insurance_cpi_avg

    FROM dim_date d
    LEFT JOIN fact_cpi c
        ON d.date_id = c.date_id
    WHERE d.year BETWEEN 2016 AND 2025
    GROUP BY
        d.year,
        d.five_year_cohort
),

construction_annual AS (
    SELECT
        d.year,
        AVG(k.construction_index_value) AS alberta_residential_construction_index_avg
    FROM fact_construction_cost k
    INNER JOIN dim_date d
        ON k.date_id = d.date_id
    WHERE d.year BETWEEN 2016 AND 2025
    GROUP BY
        d.year
),

events_annual AS (
    SELECT
        d.year,
        COUNT(DISTINCT e.event_id) AS catastrophe_event_count,
        SUM(e.revised_loss_cad) AS total_revised_catastrophe_loss_cad
    FROM fact_hail_loss_event e
    INNER JOIN dim_date d
        ON e.date_id = d.date_id
    WHERE d.year BETWEEN 2016 AND 2025
    GROUP BY
        d.year
)

SELECT
    c.year,
    c.five_year_cohort,
    c.alberta_all_items_cpi_avg,
    c.alberta_home_insurance_cpi_avg,
    c.canada_home_insurance_cpi_avg,
    k.alberta_residential_construction_index_avg,
    COALESCE(e.catastrophe_event_count, 0) AS catastrophe_event_count,
    e.total_revised_catastrophe_loss_cad
FROM cpi_annual c
LEFT JOIN construction_annual k
    ON c.year = k.year
LEFT JOIN events_annual e
    ON c.year = e.year
ORDER BY
    c.year;