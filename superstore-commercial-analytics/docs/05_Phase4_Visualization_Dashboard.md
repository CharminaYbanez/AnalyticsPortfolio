# 05_Phase4_Visualization_Dashboard.md

# Phase 4 — Visualization and Dashboarding

## Project

Superstore Commercial Profitability and Revenue Mix

## Current Status

Phase 4 complete.

## Purpose

Phase 4 translated validated analysis outputs into a Tableau Public dashboard for portfolio review.

## Why This Phase Matters

The dashboard gives stakeholders a fast way to identify where sales volume does not translate into proportional profit. It also demonstrates business intelligence design, metric selection and visual communication.

## Dashboard Platform

Tableau Public

Published dashboard:
https://public.tableau.com/views/SuperstoreCommercialProfitabilityReview/Dashboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link

## Dashboard Title

Superstore Commercial Profitability Review

## Dashboard Subtitle

Identifying where sales volume does not translate into proportional profit across product mix, discount tiers, and regions.

## Dashboard Components

### KPI Header

KPI cards:
- Sales: $2.30M
- Profit: $286K
- Weighted Margin: 12.5%
- Orders: 5,009
- Loss-Making Share: 18.7%
- Loss-Making Sales: $469K

Purpose:
Establish the overall commercial baseline.

### Main Visual — Profitability by Sub-Category and Discount Tier

Visual type:
Matrix / heatmap

Rows:
- Sub-Category

Columns:
- Discount Tier

Color:
- Weighted Profit Margin

Color logic:
- Red = negative or weak margin
- Neutral = near zero margin
- Blue = positive margin

Purpose:
Identify product and discount combinations with the strongest commercial review signals.

Main review areas:
- High-discount Binders
- High-discount Machines
- High-discount Tables
- High-discount Bookcases
- High-discount Phones

### Supporting Visual — Sub-Category Sales vs Margin

Visual type:
Scatter plot

X-axis:
- Total Sales

Y-axis:
- Weighted Profit Margin

Color:
- Category

Purpose:
Identify sub-categories where sales volume is high but profit margin is weak.

### Supporting Visual — Region Profitability

Visual type:
Bar chart

X-axis:
- Region

Y-axis:
- Total Profit

Tooltip:
- Sales
- Profit
- Weighted margin
- Loss-making share
- Loss-making sales

Purpose:
Use region as a supporting lens for profitability differences.

### Collapsible Commercial Insights Panel

Purpose:
Provide dashboard interpretation without crowding the main view.

Key message:
Profitability pressure is concentrated in specific sub-category and discount-tier combinations rather than entire product categories.

### Collapsible Recommended Actions Panel

Purpose:
Provide careful business actions based on observed patterns.

Action framing:
Recommendations are review and validation actions, not guaranteed profit recovery claims.

### Footer

Footer text:
Created by Charmina Ybanez | Data Analytics Portfolio Project | 2026

Subfooter:
Dataset: Tableau Sample Superstore | Tools: SQL, Python, Tableau

## Dashboard Screenshots

Default dashboard screenshot:
`outputs/screenshots/superstore_profitability_dashboard.png`

Expanded dashboard screenshot:
`outputs/screenshots/superstore_profitability_dashboard_expanded.png`

## Key Design Decisions

- Use collapsed insight/action panels as the default view to keep the dashboard clean.
- Keep the matrix as the main visual because it directly supports the decision question.
- Use scatter and region charts as supporting views.
- Use compact KPI formatting for executive readability.
- Use red for negative/weak margin and blue for positive margin.
- Avoid product-name-level rankings because of product ID/name caveats.

## Tooltip Corrections

Several Tableau tooltip issues were corrected:
- Removed overall-project metrics from cell-level tooltips.
- Corrected margin display using cell-level calculations.
- Removed fields that created misleading aggregate values.
- Ensured Sheet 1 and Sheet 2 tooltips show metrics aligned with the selected mark.

## Tableau Public Publishing Notes

Tableau Public required data sources to be saved as extracts before publishing.

A local Tableau workbook file is not included because the dashboard was built and published using Tableau Public Web.

## Phase 4 Checkpoint

Completed:
- Tableau Public profile created
- Dashboard built
- Dashboard published
- KPI cards added
- Main matrix visual created
- Scatter visual created
- Region visual created
- Footer added
- Collapsible Commercial Insights and Recommended Actions panels added
- Screenshots saved

Locked decisions:
- Tableau Public is the final dashboard platform.
- Published dashboard link is the primary interactive artifact.
- Default screenshot uses the collapsed dashboard view.

Clean stopping point:
Yes. Phase 4 is complete.