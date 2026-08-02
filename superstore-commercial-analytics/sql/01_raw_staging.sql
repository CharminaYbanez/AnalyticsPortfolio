-- =============================================================================
-- PROJECT 3: SUPERSTORE COMMERCIAL PROFITABILITY
-- Phase 2: Raw SQL Staging
-- Script: 01_raw_staging.sql
-- Purpose: Create raw staging table for Superstore CSV data
-- SQL Engine: SQLite
-- =============================================================================

DROP TABLE IF EXISTS raw_superstore_sales;

CREATE TABLE raw_superstore_sales (
    row_id INTEGER,
    order_id TEXT,
    order_date TEXT,
    ship_date TEXT,
    ship_mode TEXT,
    customer_id TEXT,
    customer_name TEXT,
    segment TEXT,
    country TEXT,
    city TEXT,
    state TEXT,
    postal_code TEXT,
    region TEXT,
    product_id TEXT,
    category TEXT,
    sub_category TEXT,
    product_name TEXT,
    sales REAL,
    quantity INTEGER,
    discount REAL,
    profit REAL
);