# 04_Phase3_Analysis_Metric_Development.md

# Phase 3 — Analysis and Metric Development

## Project

Superstore Commercial Profitability and Revenue Mix

## Current Status

Phase 3 complete.

## Purpose

Phase 3 developed validated commercial metrics and analysis outputs after data grain, fields, dates and QA checks were confirmed in Phase 2.

## Why This Phase Matters

This phase turns staged data into business-facing metrics and analytical findings. It ensures that dashboard visuals are based on validated calculations rather than disconnected chart-building.

## Key Decisions

- Use weighted profit margin as `SUM(profit) / SUM(sales)`.
- Use `order_date` and `order_year` for time-based analysis.
- Use category and sub-category as primary product-mix storytelling levels.
- Use product-level rankings only with caution because product ID and product name are not perfectly one-to-one.
- Treat discount patterns as associations, not causal proof.
- Treat customer contribution as historical contribution, not CLV.
- Use YoY analysis as supporting context, not the main story.

## Confirmed Core Metrics

| Metric | Definition |
|---|---|
| Total Sales | `SUM(sales)` |
| Total Profit | `SUM(profit)` |
| Weighted Profit Margin | `SUM(profit) / SUM(sales)` |
| Line Item Count | `COUNT(*)` |
| Order Count | `COUNT(DISTINCT order_id)` |
| Customer Count | `COUNT(DISTINCT customer_id)` |
| Product Count | `COUNT(DISTINCT product_id)` |
| Loss-Making Line Items | Rows where `profit < 0` |
| Loss-Making Line-Item Share | Loss-making line items / total line items |
| Loss-Making Sales | Sales attached to rows where `profit < 0` |
| Loss-Making Profit | Profit from rows where `profit < 0` |

## Completed Analysis Outputs

### Overall Commercial Summary

- Line items: 9,994
- Orders: 5,009
- Customers: 793
- Products: 1,862
- Sales: 2,297,200.86
- Profit: 286,397.02
- Weighted margin: 12.47%
- Loss-making line items: 1,871
- Loss-making line-item share: 18.72%
- Loss-making sales: 468,707.15
- Loss-making profit: -156,131.29

### Category Profitability

Furniture showed weak profit conversion:
- Sales: 741,999.80
- Profit: 18,451.27
- Weighted margin: 2.49%
- Loss-making line-item share: 33.66%

Technology and Office Supplies both had margins above 17%.

### Sub-Category Profitability

Weakest sub-category profit areas:
- Tables: -17,725.48 profit, -8.56% margin
- Bookcases: -3,472.56 profit, -3.02% margin
- Supplies: -1,189.10 profit, -2.55% margin

High-sales / weak-profit review area:
- Machines: 189,238.63 sales, 3,384.76 profit, 1.79% margin

### Discount Tier by Category

High-discount rows showed negative aggregate profit across all major categories:
- Furniture high discount: -43,782.44 profit
- Office Supplies high discount: -47,140.14 profit
- Technology high discount: -34,084.20 profit

### Sub-Category × Discount Tier

Largest negative-profit combinations:
- Binders / High Discount: 36,140.61 sales, -38,510.50 profit, -106.56% margin
- Machines / High Discount: 73,082.80 sales, -29,881.39 profit, -40.89% margin
- Tables / High Discount: 64,774.39 sales, -27,295.90 profit, -42.14% margin
- Bookcases / High Discount: 24,261.30 sales, -10,541.89 profit, -43.45% margin
- Phones / High Discount: 34,337.35 sales, -6,385.79 profit, -18.60% margin

### Region Profitability

Central had the weakest regional profile:
- Weighted margin: 7.92%
- Loss-making line-item share: 31.90%
- Loss-making profit: -56,314.89

West had the strongest overall regional profit profile.

### Customer Contribution

Top approximately 20% of customers:
- Customer count: 158 of 793
- Sales share: 47.96%
- Profit share: 59.31%

This is historical contribution, not true customer lifetime value.

### Year-over-Year Context

Sales and profit increased from 2014 to 2017, while loss-making line-item share stayed around 18–19% each year.

## Main Phase 3 Finding

Profitability pressure is concentrated in specific sub-category and discount-tier combinations, especially high-discount Binders, Machines, Tables, Bookcases and Phones.

## Dashboard-Ready Exports

Dashboard-ready CSVs were exported to:

`outputs/dashboard_data/`

Files:
- `overall_commercial_summary.csv`
- `category_summary.csv`
- `sub_category_summary.csv`
- `discount_category_summary.csv`
- `subcat_discount_summary.csv`
- `region_summary.csv`
- `customer_top20_share.csv`
- `yoy_summary.csv`

## SQL Views Created

Analytical views were created in `04_analytical_table.sql`:
- `vw_overall_commercial_summary`
- `vw_category_summary`
- `vw_sub_category_summary`
- `vw_discount_category_summary`
- `vw_subcat_discount_summary`
- `vw_region_summary`
- `vw_customer_summary`
- `vw_customer_pareto`
- `vw_yoy_summary`

## Limitations

- Discount patterns are observational.
- The dataset does not include discount reason, campaign, product condition, return reason, inventory status, supplier cost or fulfillment cost.
- Customer analysis is historical contribution only.
- Product-name-level rankings need caveats because product ID and product name are not perfectly one-to-one.

## Phase 3 Checkpoint

Completed:
- Metric definitions
- SQL/Python outputs
- Analytical summaries
- Dashboard-ready CSV exports
- SQL analytical views

Locked decisions:
- Weighted margin is the primary margin metric.
- Sub-category × discount tier is the strongest diagnostic layer.
- Region and customer contribution are supporting lenses.

Clean stopping point:
Yes. Phase 3 is complete.