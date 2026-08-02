-- =============================================================================
-- PROJECT 3: SUPERSTORE COMMERCIAL PROFITABILITY
-- Phase 3: Analysis and Metric Development
-- Script: 04_analytical_table.sql
-- Purpose: Create SQL views for dashboard-ready analytical outputs.
-- SQL Engine: SQLite
-- =============================================================================

-- -----------------------------------------------------------------------------
-- View 001: Overall Commercial Summary
-- Purpose:
-- Create one executive baseline row for Tableau KPI cards and documentation.
-- -----------------------------------------------------------------------------

DROP VIEW IF EXISTS vw_overall_commercial_summary;

CREATE VIEW vw_overall_commercial_summary AS
SELECT
    COUNT(*) AS line_item_count,
    COUNT(DISTINCT order_id) AS order_count,
    COUNT(DISTINCT customer_id) AS customer_count,
    COUNT(DISTINCT product_id) AS product_count,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales), 4) AS weighted_profit_margin,
    SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) AS loss_making_line_items,
    ROUND(
        1.0 * SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) / COUNT(*),
        4
    ) AS loss_making_line_item_share,
    ROUND(SUM(CASE WHEN profit < 0 THEN sales ELSE 0 END), 2) AS loss_making_sales,
    ROUND(SUM(CASE WHEN profit < 0 THEN profit ELSE 0 END), 2) AS loss_making_profit
FROM raw_superstore_sales;


-- -----------------------------------------------------------------------------
-- View 002: Category Summary
-- Purpose:
-- Summarize profitability by major product category.
-- -----------------------------------------------------------------------------

DROP VIEW IF EXISTS vw_category_summary;

CREATE VIEW vw_category_summary AS
SELECT
    category,
    COUNT(*) AS line_item_count,
    COUNT(DISTINCT order_id) AS order_count,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales), 4) AS weighted_profit_margin,
    SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) AS loss_making_line_items,
    ROUND(
        1.0 * SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) / COUNT(*),
        4
    ) AS loss_making_line_item_share,
    ROUND(SUM(CASE WHEN profit < 0 THEN sales ELSE 0 END), 2) AS loss_making_sales,
    ROUND(SUM(CASE WHEN profit < 0 THEN profit ELSE 0 END), 2) AS loss_making_profit
FROM raw_superstore_sales
GROUP BY category;


-- -----------------------------------------------------------------------------
-- View 003: Sub-Category Summary
-- Purpose:
-- Summarize profitability by category and sub-category.
-- -----------------------------------------------------------------------------

DROP VIEW IF EXISTS vw_sub_category_summary;

CREATE VIEW vw_sub_category_summary AS
SELECT
    category,
    sub_category,
    COUNT(*) AS line_item_count,
    COUNT(DISTINCT order_id) AS order_count,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales), 4) AS weighted_profit_margin,
    SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) AS loss_making_line_items,
    ROUND(
        1.0 * SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) / COUNT(*),
        4
    ) AS loss_making_line_item_share,
    ROUND(SUM(CASE WHEN profit < 0 THEN sales ELSE 0 END), 2) AS loss_making_sales,
    ROUND(SUM(CASE WHEN profit < 0 THEN profit ELSE 0 END), 2) AS loss_making_profit
FROM raw_superstore_sales
GROUP BY category, sub_category;


-- -----------------------------------------------------------------------------
-- View 004: Discount Tier by Category
-- Purpose:
-- Summarize profitability by category and discount tier.
-- -----------------------------------------------------------------------------

DROP VIEW IF EXISTS vw_discount_category_summary;

CREATE VIEW vw_discount_category_summary AS
SELECT
    category,
    discount_tier,
    COUNT(*) AS line_item_count,
    COUNT(DISTINCT order_id) AS order_count,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales), 4) AS weighted_profit_margin,
    SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) AS loss_making_line_items,
    ROUND(
        1.0 * SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) / COUNT(*),
        4
    ) AS loss_making_line_item_share,
    ROUND(SUM(CASE WHEN profit < 0 THEN sales ELSE 0 END), 2) AS loss_making_sales,
    ROUND(SUM(CASE WHEN profit < 0 THEN profit ELSE 0 END), 2) AS loss_making_profit
FROM raw_superstore_sales
GROUP BY category, discount_tier;


-- -----------------------------------------------------------------------------
-- View 005: Sub-Category by Discount Tier
-- Purpose:
-- Create the main profitability review matrix layer.
-- This is the strongest diagnostic view for the dashboard.
-- -----------------------------------------------------------------------------

DROP VIEW IF EXISTS vw_subcat_discount_summary;

CREATE VIEW vw_subcat_discount_summary AS
SELECT
    category,
    sub_category,
    discount_tier,
    COUNT(*) AS line_item_count,
    COUNT(DISTINCT order_id) AS order_count,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales), 4) AS weighted_profit_margin,
    SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) AS loss_making_line_items,
    ROUND(
        1.0 * SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) / COUNT(*),
        4
    ) AS loss_making_line_item_share,
    ROUND(SUM(CASE WHEN profit < 0 THEN sales ELSE 0 END), 2) AS loss_making_sales,
    ROUND(SUM(CASE WHEN profit < 0 THEN profit ELSE 0 END), 2) AS loss_making_profit
FROM raw_superstore_sales
GROUP BY category, sub_category, discount_tier;


-- -----------------------------------------------------------------------------
-- View 006: Region Summary
-- Purpose:
-- Summarize profitability by customer/order region.
-- -----------------------------------------------------------------------------

DROP VIEW IF EXISTS vw_region_summary;

CREATE VIEW vw_region_summary AS
SELECT
    region,
    COUNT(*) AS line_item_count,
    COUNT(DISTINCT order_id) AS order_count,
    COUNT(DISTINCT customer_id) AS customer_count,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales), 4) AS weighted_profit_margin,
    SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) AS loss_making_line_items,
    ROUND(
        1.0 * SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) / COUNT(*),
        4
    ) AS loss_making_line_item_share,
    ROUND(SUM(CASE WHEN profit < 0 THEN sales ELSE 0 END), 2) AS loss_making_sales,
    ROUND(SUM(CASE WHEN profit < 0 THEN profit ELSE 0 END), 2) AS loss_making_profit
FROM raw_superstore_sales
GROUP BY region;


-- -----------------------------------------------------------------------------
-- View 007: Year-over-Year Summary
-- Purpose:
-- Provide annual sales, profit, margin and loss-making context.
-- -----------------------------------------------------------------------------

DROP VIEW IF EXISTS vw_yoy_summary;

CREATE VIEW vw_yoy_summary AS
SELECT
    order_year,
    COUNT(*) AS line_item_count,
    COUNT(DISTINCT order_id) AS order_count,
    COUNT(DISTINCT customer_id) AS customer_count,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales), 4) AS weighted_profit_margin,
    SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) AS loss_making_line_items,
    ROUND(
        1.0 * SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) / COUNT(*),
        4
    ) AS loss_making_line_item_share
FROM raw_superstore_sales
GROUP BY order_year;


-- -----------------------------------------------------------------------------
-- View 008: Customer Summary
-- Purpose:
-- Summarize historical customer contribution.
-- Note:
-- This is not customer lifetime value.
-- -----------------------------------------------------------------------------

DROP VIEW IF EXISTS vw_customer_summary;

CREATE VIEW vw_customer_summary AS
SELECT
    customer_id,
    customer_name,
    COUNT(*) AS line_item_count,
    COUNT(DISTINCT order_id) AS order_count,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales), 4) AS weighted_profit_margin,
    SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) AS loss_making_line_items,
    ROUND(
        1.0 * SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) / COUNT(*),
        4
    ) AS loss_making_line_item_share
FROM raw_superstore_sales
GROUP BY customer_id, customer_name;


-- -----------------------------------------------------------------------------
-- View 009: Customer Pareto Ranking
-- Purpose:
-- Rank customers by sales and calculate cumulative sales/profit shares.
-- Note:
-- This uses SQLite window functions.
-- -----------------------------------------------------------------------------

DROP VIEW IF EXISTS vw_customer_pareto;

CREATE VIEW vw_customer_pareto AS
WITH customer_totals AS (
    SELECT
        customer_id,
        customer_name,
        SUM(sales) AS total_sales,
        SUM(profit) AS total_profit
    FROM raw_superstore_sales
    GROUP BY customer_id, customer_name
),

ranked_customers AS (
    SELECT
        customer_id,
        customer_name,
        total_sales,
        total_profit,
        ROW_NUMBER() OVER (ORDER BY total_sales DESC) AS sales_rank,
        COUNT(*) OVER () AS total_customers,
        SUM(total_sales) OVER () AS grand_total_sales,
        SUM(total_profit) OVER () AS grand_total_profit,
        SUM(total_sales) OVER (
            ORDER BY total_sales DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS cumulative_sales,
        SUM(total_profit) OVER (
            ORDER BY total_sales DESC
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS cumulative_profit
    FROM customer_totals
)

SELECT
    customer_id,
    customer_name,
    sales_rank,
    total_customers,
    ROUND(total_sales, 2) AS total_sales,
    ROUND(total_profit, 2) AS total_profit,
    ROUND(1.0 * sales_rank / total_customers, 4) AS customer_rank_share,
    ROUND(cumulative_sales, 2) AS cumulative_sales,
    ROUND(1.0 * cumulative_sales / grand_total_sales, 4) AS cumulative_sales_share,
    ROUND(cumulative_profit, 2) AS cumulative_profit,
    ROUND(1.0 * cumulative_profit / grand_total_profit, 4) AS cumulative_profit_share
FROM ranked_customers;