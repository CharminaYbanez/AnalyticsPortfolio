# 00_Project_Overview.md

# Project Overview — Superstore Commercial Profitability

## Project

Superstore Commercial Profitability and Revenue Mix

## Current Status

Project is in Phase 6 — Portfolio Packaging.

Phases 0 through 5 are complete:
- Project initiation
- Data acquisition and feasibility
- SQL staging and QA
- Analysis and metric development
- Tableau dashboarding
- Findings, recommendations and limitations

The Tableau Public dashboard has been published.

## Stakeholder

Primary stakeholder:
Commercial Analytics Manager or VP of Sales Operations

## Decision Question

Which products, customer segments, regions and discount patterns contribute to profitable growth or revenue leakage, and where should management prioritize commercial review?

## Project Objective

Identify where sales volume does not translate into proportional profit across product mix, discount tiers and regions.

## Tools Used

- SQL / SQLite
- Python / pandas
- Jupyter Notebook
- Tableau Public
- Markdown documentation

## Dataset

Primary file:
`Sample - Superstore.csv`

Dataset type:
Fictitious/sample Superstore dataset used for analytics and Tableau practice.

## Confirmed Grain

One row represents one product line item within an order.

Important implications:
- `COUNT(*)` = line-item count
- `COUNT(DISTINCT order_id)` = order count
- `COUNT(DISTINCT customer_id)` = customer count
- `COUNT(DISTINCT product_id)` = product count

## Main Analytical Story

Profitability pressure is concentrated in specific sub-category and discount-tier combinations rather than entire product categories.

The clearest commercial review signals are:
- High-discount Binders
- High-discount Machines
- High-discount Tables
- High-discount Bookcases
- High-discount Phones

## Dashboard

Published Tableau Public dashboard:
https://public.tableau.com/views/SuperstoreCommercialProfitabilityReview/Dashboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link

Dashboard components:
- KPI header
- Sub-category × discount tier profitability matrix
- Sub-category sales vs margin scatter plot
- Region profitability summary
- Collapsible Commercial Insights panel
- Collapsible Recommended Actions panel
- Footer and source/tool notes

## Main Limitations

- Superstore is a fictitious/sample dataset.
- Discount patterns are observational, not causal.
- Discount reason, product cost, return reason, inventory status and fulfillment cost are unavailable.
- Customer contribution is historical contribution only, not true CLV.
- Product ID and product name are not perfectly one-to-one.
- Region reflects customer/order geography, not logistics routing.