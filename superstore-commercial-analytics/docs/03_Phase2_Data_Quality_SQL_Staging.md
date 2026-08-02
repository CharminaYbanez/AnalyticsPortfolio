# 03_Phase2_Data_Quality_SQL_Staging.md

## Project

Superstore Commercial Profitability and Revenue Mix

## Current Status

Phase 2 started. Initial data understanding and QA checks completed for the primary dataset, Sample - Superstore.csv. The dataset is suitable for SQL/Python staging and commercial profitability analysis, with documented caveats.

## Purpose

Phase 2 confirms the dataset structure, grain, keys, data types, category consistency, missingness, date semantics and QA risks before analysis.

The core question is:
What exactly does one row mean, and can the fields be trusted enough to calculate commercial metrics?

## Why This Matters

If row grain, keys or date semantics are misunderstood, later metrics and dashboards may be mathematically polished but analytically wrong.

Main risks:
- treating line items as orders;
- using product names as stable product keys;
- using average row-level margin instead of weighted margin;
- overinterpreting negative profit or discount patterns;
- assuming product IDs and product names map perfectly.

## Primary Dataset

File:
Sample - Superstore.csv

Shape:
- Rows: 9,994
- Columns: 21

Columns:
- Row ID
- Order ID
- Order Date
- Ship Date
- Ship Mode
- Customer ID
- Customer Name
- Segment
- Country
- City
- State
- Postal Code
- Region
- Product ID
- Category
- Sub-Category
- Product Name
- Sales
- Quantity
- Discount
- Profit

## Data Types

Raw data types:
- Row ID, Postal Code and Quantity are integers.
- Sales, Discount and Profit are numeric floats.
- Order Date and Ship Date are text/object before parsing.
- IDs, names and category fields are text/object.

Required staging changes:
- Convert Order Date to date.
- Convert Ship Date to date.
- Rename fields to snake_case.
- Consider treating Postal Code as text for geography consistency.

## Missing Values

Confirmed:
- Missing values: 0 across all 21 columns.

Interpretation:
The dataset is unusually clean, which is expected for a sample/training dataset.

## Duplicate Checks

Confirmed:
- Duplicate Row ID count: 0
- Fully duplicate row count: 0

Interpretation:
Row ID can be treated as the row-level primary key.

## Date Semantics

Confirmed:
- Order Date range: 2014-01-03 to 2017-12-30
- Ship Date range: 2014-01-07 to 2018-01-05
- Records with Ship Date earlier than Order Date: 0

Decision:
Use Order Date as the default date for sales and profit reporting.

Rationale:
Ship Date may extend into the next year because late-year orders can ship in early January. Ship Date should only be used for shipping or fulfillment questions.

## Confirmed Row Grain

Evidence:
- Unique Row IDs: 9,994
- Unique Orders: 5,009
- Average rows per order: approximately 2.0
- Maximum rows in one order: 14

Confirmed grain:
One row represents one product line item within an order.

Implications:
- COUNT(*) is line-item count, not order count.
- COUNT(DISTINCT order_id) is order count.
- COUNT(DISTINCT customer_id) is customer count.
- COUNT(DISTINCT product_id) is product count.
- Order-level analysis requires grouping by order_id.

## Category Coverage

Confirmed:
- Categories: 3
- Sub-Categories: 17
- Segments: 3
- Regions: 4
- States: 49
- Country: United States only
- Ship Modes: 4

Sub-category counts:
- Furniture: 4
- Office Supplies: 9
- Technology: 4

## Sales, Profit and Discount Checks

Confirmed:
- Sales <= 0: 0 rows
- Negative profit rows: 1,871
- Discount range: 0.0 to 0.8

Observed discount values:
0.00, 0.10, 0.15, 0.20, 0.30, 0.32, 0.40, 0.45, 0.50, 0.60, 0.70, 0.80

Interpretation:
- Sales are positive.
- Profit can be negative.
- Discount values appear intentionally banded.
- Negative profit rows are legitimate analytical records, not automatic data errors.
- Discount and profitability association can be analyzed, but causality cannot be claimed.

## Customer Key Consistency

Confirmed:
- Unique Customer IDs: 793
- Customer IDs with multiple names: 0
- Customer names with multiple IDs: 0

Decision:
Customer ID is safe for customer-level aggregation.

## Product Key Caution

Confirmed:
- Unique Product IDs: 1,862
- Unique Product Names: 1,850
- Product IDs with multiple product names: 32
- Product names with multiple product IDs: 16

Interpretation:
Product IDs and Product Names are not perfectly one-to-one.

Decision:
Use Product ID as the product key where possible. Use Product Name as a display label, not the primary key.

Portfolio implication:
For stakeholder storytelling, prefer Category and Sub-Category for primary product-mix analysis. Product-level ranking can be included with caveats.

## Annual Coverage Preview

Annual order-date coverage:

2014:
- Rows: 1,993
- Orders: 969
- Sales: 484,247.50
- Profit: 49,543.97

2015:
- Rows: 2,102
- Orders: 1,038
- Sales: 470,532.51
- Profit: 61,618.60

2016:
- Rows: 2,587
- Orders: 1,315
- Sales: 609,205.60
- Profit: 81,795.17

2017:
- Rows: 3,312
- Orders: 1,687
- Sales: 733,215.26
- Profit: 93,439.27

Interpretation:
Year-over-year analysis is feasible after date validation. However, YoY sales or profit growth may reflect increased row/order volume rather than improved profitability.

## Staging Table Design

Recommended staging table:
stg_superstore_sales

Cleaned column names:
- row_id
- order_id
- order_date
- ship_date
- ship_mode
- customer_id
- customer_name
- segment
- country
- city
- state
- postal_code
- region
- product_id
- category
- sub_category
- product_name
- sales
- quantity
- discount
- profit

Derived fields for later:
- order_year
- order_month
- ship_days
- discount_tier
- profit_flag

Metric caution:
Do not use average row-level margin as the main business margin. Business margin should generally be calculated as SUM(profit) / SUM(sales).

## Phase 2 Initial Checkpoint

Completed work:
- Started Phase 2.
- Confirmed primary dataset shape.
- Confirmed no missing values.
- Confirmed no duplicate Row ID.
- Confirmed no fully duplicate rows.
- Confirmed date ranges.
- Confirmed no Ship Date earlier than Order Date.
- Confirmed row grain as product line item within an order.
- Confirmed Order Date as default sales/profit reporting date.
- Confirmed customer key consistency.
- Identified product key/name ambiguity.
- Confirmed negative profit rows are present and analytically relevant.
- Confirmed YoY analysis is feasible.
- Proposed staging table and cleaned column names.

Decisions locked:
- Row ID is the row-level primary key.
- Confirmed grain: one row per product line item within an order.
- Order Date is the default date for sales/profit reporting.
- Customer ID is safe for customer-level aggregation.
- Product ID should be used as the product key; Product Name is a display label.
- Use Category and Sub-Category for primary product-mix storytelling.
- Use stg_superstore_sales as the main staging table name.
- Use cleaned snake_case column names.

Limitations and risks:
- Product ID and Product Name are not perfectly one-to-one.
- Individual product ranking may need caveats.
- Negative profit rows are not errors, but causal explanation is unavailable.
- No external benchmark or sales target exists.
- YoY growth may reflect higher order/row volume, not necessarily improved efficiency or profitability.
- Dataset is unusually clean because it is sample/training data.

Unresolved questions:
- Which SQL engine should be used locally: SQLite, DuckDB or another tool?
- Should we create a staged CSV for Tableau with cleaned column names?
- Should Postal Code be treated as text instead of numeric for Tableau/geography consistency?
- Should product analysis stop at sub-category or include top/bottom products with caveats?

Immediate next action:
Create the staged working dataset and QA script.

Clean stopping point:
Yes. This is a clean stopping point inside Phase 2.