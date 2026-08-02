-- =============================================================================
-- PROJECT 3: SUPERSTORE COMMERCIAL PROFITABILITY
-- Phase 2: Data Understanding, SQL Staging and Quality Checks
-- Script: 02_qa_checks.sql
-- Purpose: Validate row counts, grain, keys, dates, missingness, categories,
--          and numeric measure ranges for the staged Superstore dataset.
-- SQL Engine: SQLite
-- =============================================================================


-- -----------------------------------------------------------------------------
-- QA 001: Core Count Validation
-- Purpose:
-- Confirm row count and distinct key counts.
--
-- Why this matters:
-- This validates the expected line-item grain and checks whether row_id behaves
-- as a unique row-level key.
-- -----------------------------------------------------------------------------

SELECT
    COUNT(*) AS row_count,
    COUNT(DISTINCT row_id) AS distinct_row_ids,
    COUNT(DISTINCT order_id) AS distinct_orders,
    COUNT(DISTINCT customer_id) AS distinct_customers,
    COUNT(DISTINCT product_id) AS distinct_products
FROM raw_superstore_sales;


-- -----------------------------------------------------------------------------
-- QA 002: Duplicate Row ID Check
-- Purpose:
-- Identify whether any row_id appears more than once.
--
-- Expected result:
-- 0 rows returned.
-- -----------------------------------------------------------------------------

SELECT
    row_id,
    COUNT(*) AS duplicate_count
FROM raw_superstore_sales
GROUP BY row_id
HAVING COUNT(*) > 1;


-- -----------------------------------------------------------------------------
-- QA 003: Order-Level Grain Check
-- Purpose:
-- Count how many product line items appear within each order.
--
-- Why this matters:
-- The dataset is expected to have one row per product line item, not one row
-- per order.
-- -----------------------------------------------------------------------------

SELECT
    order_id,
    COUNT(*) AS line_item_count
FROM raw_superstore_sales
GROUP BY order_id
ORDER BY line_item_count DESC
LIMIT 20;


-- -----------------------------------------------------------------------------
-- QA 004: Date Range Validation
-- Purpose:
-- Check the minimum and maximum order and ship dates.
--
-- Why this matters:
-- Order Date is the default business date for sales and profit trends.
-- Ship Date may extend into the next year for late-year orders.
-- -----------------------------------------------------------------------------

SELECT
    MIN(order_date) AS min_order_date,
    MAX(order_date) AS max_order_date,
    MIN(ship_date) AS min_ship_date,
    MAX(ship_date) AS max_ship_date
FROM raw_superstore_sales;


-- -----------------------------------------------------------------------------
-- QA 005: Ship Date Before Order Date Check
-- Purpose:
-- Identify records where ship_date occurs before order_date.
--
-- Expected result:
-- 0 rows.
-- -----------------------------------------------------------------------------

SELECT
    COUNT(*) AS ship_before_order_count
FROM raw_superstore_sales
WHERE ship_date < order_date;


-- -----------------------------------------------------------------------------
-- QA 006: Annual Coverage Check
-- Purpose:
-- Review row count, order count, sales and profit by order year.
--
-- Why this matters:
-- This confirms whether year-over-year analysis is feasible.
-- This is still QA, not final trend analysis.
-- -----------------------------------------------------------------------------

SELECT
    order_year,
    COUNT(*) AS row_count,
    COUNT(DISTINCT order_id) AS order_count,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales), 4) AS weighted_profit_margin
FROM raw_superstore_sales
GROUP BY order_year
ORDER BY order_year;


-- -----------------------------------------------------------------------------
-- QA 007: Missingness Check for Key Fields
-- Purpose:
-- Count missing values in critical fields.
--
-- Note:
-- SQLite loaded empty values as NULL only if pandas stored them as missing.
-- This check still provides useful validation.
-- -----------------------------------------------------------------------------

SELECT
    SUM(CASE WHEN row_id IS NULL THEN 1 ELSE 0 END) AS missing_row_id,
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS missing_order_id,
    SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS missing_order_date,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS missing_customer_id,
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS missing_product_id,
    SUM(CASE WHEN sales IS NULL THEN 1 ELSE 0 END) AS missing_sales,
    SUM(CASE WHEN profit IS NULL THEN 1 ELSE 0 END) AS missing_profit,
    SUM(CASE WHEN discount IS NULL THEN 1 ELSE 0 END) AS missing_discount
FROM raw_superstore_sales;


-- -----------------------------------------------------------------------------
-- QA 008: Category Coverage Check
-- Purpose:
-- Validate major categorical fields.
-- -----------------------------------------------------------------------------

SELECT
    category,
    COUNT(*) AS row_count,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM raw_superstore_sales
GROUP BY category
ORDER BY category;


-- -----------------------------------------------------------------------------
-- QA 009: Sub-Category Coverage Check
-- Purpose:
-- Validate sub-category labels and their parent categories.
-- -----------------------------------------------------------------------------

SELECT
    category,
    sub_category,
    COUNT(*) AS row_count,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM raw_superstore_sales
GROUP BY category, sub_category
ORDER BY category, sub_category;


-- -----------------------------------------------------------------------------
-- QA 010: Segment Coverage Check
-- Purpose:
-- Validate customer segment labels.
-- -----------------------------------------------------------------------------

SELECT
    segment,
    COUNT(*) AS row_count,
    COUNT(DISTINCT customer_id) AS customer_count,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM raw_superstore_sales
GROUP BY segment
ORDER BY segment;


-- -----------------------------------------------------------------------------
-- QA 011: Region Coverage Check
-- Purpose:
-- Validate region labels.
-- -----------------------------------------------------------------------------

SELECT
    region,
    COUNT(*) AS row_count,
    COUNT(DISTINCT order_id) AS order_count,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM raw_superstore_sales
GROUP BY region
ORDER BY region;


-- -----------------------------------------------------------------------------
-- QA 012: Ship Mode Coverage Check
-- Purpose:
-- Validate ship mode labels.
-- -----------------------------------------------------------------------------

SELECT
    ship_mode,
    COUNT(*) AS row_count,
    COUNT(DISTINCT order_id) AS order_count
FROM raw_superstore_sales
GROUP BY ship_mode
ORDER BY ship_mode;


-- -----------------------------------------------------------------------------
-- QA 013: Numeric Sanity Check
-- Purpose:
-- Validate ranges for sales, quantity, discount, profit and ship_days.
-- -----------------------------------------------------------------------------

SELECT
    MIN(sales) AS min_sales,
    MAX(sales) AS max_sales,
    MIN(quantity) AS min_quantity,
    MAX(quantity) AS max_quantity,
    MIN(discount) AS min_discount,
    MAX(discount) AS max_discount,
    MIN(profit) AS min_profit,
    MAX(profit) AS max_profit,
    MIN(ship_days) AS min_ship_days,
    MAX(ship_days) AS max_ship_days
FROM raw_superstore_sales;


-- -----------------------------------------------------------------------------
-- QA 014: Sales Less Than or Equal to Zero
-- Purpose:
-- Check for invalid or unusual sales values.
--
-- Expected result:
-- 0 rows.
-- -----------------------------------------------------------------------------

SELECT
    COUNT(*) AS sales_lte_zero_count
FROM raw_superstore_sales
WHERE sales <= 0;


-- -----------------------------------------------------------------------------
-- QA 015: Negative Profit Count
-- Purpose:
-- Count loss-making line items.
--
-- Note:
-- Negative profit rows are analytically meaningful, not automatic data errors.
-- -----------------------------------------------------------------------------

SELECT
    COUNT(*) AS negative_profit_row_count
FROM raw_superstore_sales
WHERE profit < 0;


-- -----------------------------------------------------------------------------
-- QA 016: Discount Value Distribution
-- Purpose:
-- Check the distinct observed discount values.
-- -----------------------------------------------------------------------------

SELECT
    discount,
    COUNT(*) AS row_count,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM raw_superstore_sales
GROUP BY discount
ORDER BY discount;


-- -----------------------------------------------------------------------------
-- QA 017: Discount Tier Coverage
-- Purpose:
-- Validate candidate discount tier labels after staging.
--
-- Note:
-- Discount tiers are still candidate helper fields until metric definitions
-- are finalized.
-- -----------------------------------------------------------------------------

SELECT
    discount_tier,
    COUNT(*) AS row_count,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales), 4) AS weighted_profit_margin
FROM raw_superstore_sales
GROUP BY discount_tier
ORDER BY
    CASE discount_tier
        WHEN 'No Discount' THEN 1
        WHEN 'Low Discount' THEN 2
        WHEN 'Moderate Discount' THEN 3
        WHEN 'High Discount' THEN 4
        ELSE 5
    END;


-- -----------------------------------------------------------------------------
-- QA 018: Customer ID to Customer Name Consistency
-- Purpose:
-- Check whether any customer_id maps to multiple customer names.
--
-- Expected result:
-- 0 rows.
-- -----------------------------------------------------------------------------

SELECT
    customer_id,
    COUNT(DISTINCT customer_name) AS distinct_customer_names
FROM raw_superstore_sales
GROUP BY customer_id
HAVING COUNT(DISTINCT customer_name) > 1;


-- -----------------------------------------------------------------------------
-- QA 019: Customer Name to Customer ID Consistency
-- Purpose:
-- Check whether any customer_name maps to multiple customer IDs.
--
-- Expected result:
-- 0 rows.
-- -----------------------------------------------------------------------------

SELECT
    customer_name,
    COUNT(DISTINCT customer_id) AS distinct_customer_ids
FROM raw_superstore_sales
GROUP BY customer_name
HAVING COUNT(DISTINCT customer_id) > 1;


-- -----------------------------------------------------------------------------
-- QA 020: Product ID to Product Name Consistency
-- Purpose:
-- Check whether product_id maps to multiple product names.
--
-- Note:
-- Some product IDs may map to multiple names. If present, use product_id as
-- the product key and product_name as a display label only.
-- -----------------------------------------------------------------------------

SELECT
    product_id,
    COUNT(DISTINCT product_name) AS distinct_product_names
FROM raw_superstore_sales
GROUP BY product_id
HAVING COUNT(DISTINCT product_name) > 1
ORDER BY distinct_product_names DESC, product_id;


-- -----------------------------------------------------------------------------
-- QA 021: Product Name to Product ID Consistency
-- Purpose:
-- Check whether product_name maps to multiple product IDs.
--
-- Note:
-- This affects product-level ranking and display labels.
-- -----------------------------------------------------------------------------

SELECT
    product_name,
    COUNT(DISTINCT product_id) AS distinct_product_ids
FROM raw_superstore_sales
GROUP BY product_name
HAVING COUNT(DISTINCT product_id) > 1
ORDER BY distinct_product_ids DESC, product_name;


-- -----------------------------------------------------------------------------
-- QA 022: Country Coverage
-- Purpose:
-- Validate geographic scope.
-- -----------------------------------------------------------------------------

SELECT
    country,
    COUNT(*) AS row_count,
    COUNT(DISTINCT state) AS state_count,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM raw_superstore_sales
GROUP BY country;


-- -----------------------------------------------------------------------------
-- QA 023: State Coverage
-- Purpose:
-- Validate state-level coverage and confirm whether state-level geography can
-- support optional dashboard filtering or review.
-- -----------------------------------------------------------------------------

SELECT
    state,
    region,
    COUNT(*) AS row_count,
    COUNT(DISTINCT order_id) AS order_count,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit
FROM raw_superstore_sales
GROUP BY state, region
ORDER BY state;


-- -----------------------------------------------------------------------------
-- QA 024: Staging Summary for Documentation
-- Purpose:
-- Produce one compact summary row for Phase 2 documentation.
-- -----------------------------------------------------------------------------

SELECT
    COUNT(*) AS row_count,
    COUNT(DISTINCT row_id) AS distinct_row_ids,
    COUNT(DISTINCT order_id) AS distinct_orders,
    COUNT(DISTINCT customer_id) AS distinct_customers,
    COUNT(DISTINCT product_id) AS distinct_products,
    MIN(order_date) AS min_order_date,
    MAX(order_date) AS max_order_date,
    MIN(ship_date) AS min_ship_date,
    MAX(ship_date) AS max_ship_date,
    SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) AS negative_profit_rows,
    SUM(CASE WHEN sales <= 0 THEN 1 ELSE 0 END) AS sales_lte_zero_rows,
    SUM(CASE WHEN ship_date < order_date THEN 1 ELSE 0 END) AS ship_before_order_rows
FROM raw_superstore_sales;