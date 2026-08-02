-- ============================================================
-- Healthcare Operations CMS
-- Block 1: Raw Staging Setup
-- Script: 01_raw_staging.sql
-- Purpose: Create raw SQLite table definitions
-- ============================================================

PRAGMA foreign_keys = ON;

-- Drop tables if they already exist.
-- This allows the build script to be rerun during development.

DROP TABLE IF EXISTS raw_hospital_general;
DROP TABLE IF EXISTS raw_timely_effective_care;

-- ============================================================
-- Raw hospital reference table: raw_hospital_general
-- Expected grain: one row per facility_id
-- ============================================================

CREATE TABLE raw_hospital_general (
    facility_id TEXT,
    facility_name TEXT,
    city_town TEXT,
    state TEXT,
    hospital_type TEXT,
    hospital_ownership TEXT,
    emergency_services TEXT
);

-- ============================================================
-- Raw measure table: raw_timely_effective_care
-- Expected grain: one row per facility_id × measure_id
-- ============================================================

CREATE TABLE raw_timely_effective_care (
    facility_id TEXT,
    facility_name TEXT,
    address TEXT,
    city_town TEXT,
    state TEXT,
    zip_code TEXT,
    county_parish TEXT,
    telephone_number TEXT,
    condition TEXT,
    measure_id TEXT,
    measure_name TEXT,
    score TEXT,
    sample TEXT,
    footnote TEXT,
    start_date TEXT,
    end_date TEXT
);