-- ============================================================
-- Alberta Home Insurance Analytics
-- Phase 2: SQL Warehouse & Quality Checks
-- Script: 01_create_tables.sql
-- Purpose: Create core warehouse tables
-- ============================================================

PRAGMA foreign_keys = ON;

-- Drop tables if they already exist.
-- This allows the build script to be rerun during development.

DROP TABLE IF EXISTS fact_hail_loss_event;
DROP TABLE IF EXISTS fact_construction_cost;
DROP TABLE IF EXISTS fact_cpi;
DROP TABLE IF EXISTS dim_date;

-- ============================================================
-- Dimension Table: dim_date
-- Grain: One row per month
-- ============================================================

CREATE TABLE dim_date (
    date_id INTEGER PRIMARY KEY,              -- YYYYMM format, e.g., 202408
    calendar_date TEXT NOT NULL,              -- First day of month, e.g., 2024-08-01
    year_month TEXT NOT NULL,                 -- YYYY-MM format
    year INTEGER NOT NULL,
    quarter INTEGER NOT NULL,
    month_number INTEGER NOT NULL,
    month_name TEXT,
    five_year_cohort TEXT,

    CHECK (month_number BETWEEN 1 AND 12),
    CHECK (quarter BETWEEN 1 AND 4)
);

-- ============================================================
-- Fact Table: fact_cpi
-- Grain: One row per date, geography, and CPI category
-- ============================================================

CREATE TABLE fact_cpi (
    cpi_id INTEGER PRIMARY KEY AUTOINCREMENT,
    date_id INTEGER NOT NULL,
    geography TEXT NOT NULL,
    cpi_category TEXT NOT NULL,
    cpi_value REAL NOT NULL,
    source_table TEXT,
    source_name TEXT,

    FOREIGN KEY (date_id) REFERENCES dim_date(date_id)
);

-- ============================================================
-- Fact Table: fact_construction_cost
-- Grain: One row per date, geography, and construction category
-- ============================================================

CREATE TABLE fact_construction_cost (
    construction_id INTEGER PRIMARY KEY AUTOINCREMENT,
    date_id INTEGER NOT NULL,
    geography TEXT NOT NULL,
    construction_category TEXT NOT NULL,
    construction_index_value REAL NOT NULL,
    frequency TEXT,
    geographic_proxy_flag TEXT,
    source_table TEXT,
    source_name TEXT,

    FOREIGN KEY (date_id) REFERENCES dim_date(date_id)
);

-- ============================================================
-- Fact Table: fact_hail_loss_event
-- Grain: One row per catastrophe event
-- ============================================================

CREATE TABLE fact_hail_loss_event (
    event_id INTEGER PRIMARY KEY,
    event_date TEXT NOT NULL,
    date_id INTEGER NOT NULL,
    event_name TEXT NOT NULL,
    primary_region TEXT,
    province TEXT,
    peril_type TEXT,
    initial_loss_cad REAL,
    revised_loss_cad REAL,
    claim_count INTEGER,
    estimate_publication_date TEXT,
    loss_source TEXT,
    source_url TEXT,
    revision_flag INTEGER,
    notes TEXT,

    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    CHECK (revision_flag IN (0, 1) OR revision_flag IS NULL)
);

-- ============================================================
-- Helpful indexes for joins and filtering
-- ============================================================

CREATE INDEX idx_fact_cpi_date_id
ON fact_cpi(date_id);

CREATE INDEX idx_fact_cpi_geo_category
ON fact_cpi(geography, cpi_category);

CREATE INDEX idx_fact_construction_date_id
ON fact_construction_cost(date_id);

CREATE INDEX idx_fact_hail_loss_date_id
ON fact_hail_loss_event(date_id);