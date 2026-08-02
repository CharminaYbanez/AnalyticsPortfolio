# 02_Phase1_Data_Acquisition_Feasibility.md

## Project

Superstore Commercial Profitability and Revenue Mix

## Current Status

Phase 1 complete. Data acquisition and feasibility reviewed. The project can proceed using Sample - Superstore.csv as the primary analytical dataset, with source caveats documented.

## Purpose

Phase 1 verifies whether the available data can support the project decision question:

Which products, customer segments, regions and discount patterns contribute to profitable growth or revenue leakage, and where should management prioritize commercial review?

This phase checks source authority, field availability, reporting coverage, joinability, missing variables and whether the project should proceed, narrow or reject the dataset.

## Why This Matters

Superstore is a common training dataset. Different versions exist online, and they may differ in fields, formatting, date range and identifiers. Phase 1 prevents the project from using unsupported claims or invalid metrics.

## Authoritative Source Verification

Tableau documentation identifies Superstore as a Tableau sample data source containing product, customer and sales information for a fictitious retail company.

Tableau Public sample data describes Superstore Sales as a fictitious company dataset containing product, sales and profit information that can be used to identify improvement areas.

Source statement for portfolio use:
The project uses Tableau’s Sample Superstore / Superstore Sales sample dataset, a fictitious retail dataset commonly used for Tableau training and portfolio practice. The working CSV is an accessible mirror/copy used for SQL and Python analysis, with source caveats documented.

## Available Files Compared

### File 1 — Sample - Superstore.csv

Role:
Primary analytical file.

Confirmed structure:
- Rows: 9,994
- Columns: 21
- Order Date range: 2014-01-03 to 2017-12-30
- Ship Date range: 2014-01-07 to 2018-01-05
- Order years: 2014, 2015, 2016, 2017
- Country coverage: United States only
- Duplicate Row ID count: 0
- Fully duplicate rows: 0
- Unique orders: 5,009
- Unique customers: 793
- Unique product IDs: 1,862
- Unique product names: 1,850

Important fields:
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

Feasibility:
This file supports sales and profit analysis, weighted margin analysis, discount tier analysis, product and regional mix analysis, customer historical contribution, customer Pareto analysis, and year-over-year trends.

### File 2 — sample-superstore.csv

Role:
Source/reference comparison file only.

Confirmed structure:
- Rows: 9,994
- Columns: 22
- Encoding/delimiter: UTF-16, tab-delimited
- Order Date range: 2015-01-03 to 2018-12-30
- Ship Date range: 2015-01-07 to 2019-01-05
- Sales and Profit format: rounded currency strings
- Discount format: percent strings
- Missing important analytical fields: Row ID, Customer ID, Product ID

Additional fields:
- Profit Ratio
- ONE
- Number of Records
- Manufacturer

Feasibility:
This file is weaker for detailed analysis because numeric measures are formatted and rounded, key identifiers are missing, and the date range differs from the primary file. It should not be used as the main analytical file.

## Field Availability Against Planned Scope

Planned area: Sales and profit trends
Required fields: Order Date, Sales, Profit
Feasible: Yes

Planned area: Discount leakage / margin pressure
Required fields: Discount, Sales, Profit
Feasible: Yes, but causal claims are prohibited

Planned area: Product and regional mix
Required fields: Category, Sub-Category, Product Name, Region, State, Sales, Profit
Feasible: Yes

Planned area: Customer contribution / Pareto
Required fields: Customer ID, Customer Name, Sales, Profit
Feasible: Yes, using primary file only

Planned area: Year-over-year analysis
Required fields: Order Date, Sales, Profit
Feasible: Yes, after date validation

Planned area: Basket analysis
Required fields: Order ID, Product ID, Product Name
Feasible: Technically yes, but optional and out of core scope

Unsupported areas:
- True customer lifetime value
- Gross or net revenue reconstruction
- Marketing attribution
- Inventory analysis
- Causal discount impact
- Sales target variance

## Reporting Coverage

Confirmed primary file coverage:
- Geography: United States only
- Time period: Order Date from 2014 through 2017
- Transaction type: product line items within customer orders
- Business domain: sample retail sales
- Measures: Sales, Profit, Quantity, Discount

Date caveat:
Ship Date extends into 2018 because late-2017 orders may ship in early 2018. Order Date should be the default business date for sales and profit trend analysis.

## Joinability

The primary file is denormalized and already includes order, customer, product, geography and sales fields.

Possible SQL staging options:
- fact_sales_line: one row per Row ID
- dim_customer: one row per Customer ID
- dim_product: one row per Product ID
- dim_geography: city/state/postal geography view

However, because this is a two-day mini project, avoid unnecessary over-normalization. A clean staging table plus QA views may be sufficient.

## Missing Variables

The dataset does not include:
- cost of goods sold
- list price
- gross revenue before discount
- returns
- taxes
- shipping cost
- marketing spend
- inventory
- sales targets
- customer acquisition cost
- true customer lifecycle fields
- promotion campaign identifiers
- causal experiment/control data

Impact:
The project can analyze observed sales, profit, discount, contribution and mix patterns.

The project cannot prove:
- why discounts occurred
- whether discounts caused losses
- whether any recommendation will increase revenue
- true customer lifetime value
- performance against real external market benchmarks

## Feasibility Decision

Decision:
Proceed, with narrowed claims.

Primary analytical dataset:
Sample - Superstore.csv

Source/reference comparison file:
sample-superstore.csv

Reason:
The primary file supports the project decision question through available product, segment, region, customer, discount, sales and profit fields.

Narrowing:
The dataset is fictitious/sample data and does not support causal, operational cost, marketing attribution, inventory or true CLV conclusions.

## Phase 1 Checkpoint

Completed work:
- Verified Tableau Superstore / Superstore Sales as an official Tableau sample dataset.
- Compared both uploaded Superstore files.
- Confirmed primary analytical file structure.
- Confirmed source/reference file limitations.
- Checked row counts, column counts, date ranges, IDs and field availability.
- Confirmed the primary file supports the planned commercial profitability project.
- Identified missing variables and unsupported claims.
- Made proceed/narrow/reject decision.

Decisions locked:
- Proceed with the project.
- Use Sample - Superstore.csv as the primary analytical dataset.
- Use sample-superstore.csv only as source/reference comparison evidence.
- Treat the dataset as fictitious/sample data, not real company data.
- Use Order Date as the default date for sales/profit trend analysis.
- Do not use the rounded source/reference file for detailed profit, discount, customer or product analysis.
- Do not claim causality from discounts to losses.
- Keep basket analysis out of scope unless core analysis is complete.

Limitations and risks:
- The working CSV is a mirror/copy, not downloaded directly from Tableau inside this chat.
- Tableau sample data versions vary across locations and years.
- The two available files differ in date range, formatting and identifiers.
- Profit is available, but cost structure is not.
- Discount is available, but discount rationale is not.
- No sales targets or external benchmark data are available.
- No causal design exists.

Unresolved questions:
- Confirm exact grain in Phase 2.
- Check duplicates beyond Row ID.
- Check category consistency.
- Validate date parsing.
- Review negative profit rows and outliers.
- Check whether Product ID and Product Name have one-to-one or many-to-one issues.
- Choose SQL engine for local staging.

Immediate next action:
Start Phase 2 — Data Understanding, SQL Staging and Quality Checks.

Clean stopping point:
Yes. Phase 1 is complete and this is a clean stopping point.