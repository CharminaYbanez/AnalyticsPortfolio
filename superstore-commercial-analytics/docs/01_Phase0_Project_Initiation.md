# 01_Phase0_Project_Initiation.md

## Project

Superstore Commercial Profitability and Revenue Mix

## Current Status

Phase 0 complete. Project initiated. Business question, stakeholder, scope, candidate metrics, source caveats and analytical guardrails have been defined. Metrics are not frozen until dataset source, fields and grain are verified in Phase 1 and Phase 2.

## Stakeholder

Primary stakeholder:
Commercial Analytics Manager / VP of Sales Operations

This stakeholder would care about:
- sales and profit concentration;
- products, regions and segments associated with strong or weak profitability;
- discount patterns associated with margin pressure;
- customer concentration and historical contribution;
- areas requiring commercial review or testing.

## Business Problem

The business may be generating sales volume while leaking profit through unfavorable product mix, discounting, or regional/customer concentration.

The project investigates whether revenue concentration, product mix, regional performance and discount patterns are associated with profit concentration or profit leakage in the Superstore sample dataset.

This is a commercial profitability and revenue mix project, not a generic dashboard exercise.

## Decision Question

Which products, customer segments, regions and discount patterns contribute to profitable growth or revenue leakage, and where should management prioritize commercial review?

## Dataset Position

Two Superstore-style files are available:

1. Sample - Superstore.csv
   - Primary analysis candidate.
   - 9,994 rows and 21 columns.
   - Includes Row ID, Order ID, Customer ID, Product ID, Sales, Profit, Quantity and Discount.
   - Contains numeric sales, profit and discount fields.
   - Initial order date range: 2014-01-03 to 2017-12-30.
   - Likely grain: one row per product line item within an order.

2. sample-superstore.csv
   - Source/reference comparison file.
   - 9,994 rows and 22 columns.
   - Contains formatted currency and percentage strings.
   - Does not include Customer ID, Product ID or Row ID.
   - Initial order date range appears shifted to 2015–2018.
   - Rounded sales and profit values make it weaker for detailed profitability analysis.

Working position:
Use Sample - Superstore.csv as the primary analytical file because it preserves the identifiers and numeric fields required for row-level, product-level and customer-level analysis. Use sample-superstore.csv only as source/provenance comparison evidence unless Phase 1 identifies a better direct official file.

## Source Caveat

Tableau documentation identifies Superstore as a Tableau sample data source. Tableau Public sample data describes Superstore Sales as a fictitious company dataset containing product, sales and profit information that can be used to identify improvement areas.

This project should document the dataset as Tableau Sample Superstore / Superstore Sales sample data, while being transparent that the working CSV is a mirror/copy used for accessible analysis.

## Metric Candidates

Metrics are candidates only and are not frozen until Phase 1 and Phase 2 validation.

Candidate metrics:
- Total Sales = SUM(Sales)
- Total Profit = SUM(Profit)
- Weighted Profit Margin = SUM(Profit) / SUM(Sales)
- Order Count = COUNT(DISTINCT Order ID)
- Row Count = COUNT(*) or COUNT(Row ID)
- Customer Count = COUNT(DISTINCT Customer ID)
- Product Count = COUNT(DISTINCT Product ID)
- Discount Tier = CASE-based discount grouping
- Loss-Making Sales = sales where Profit < 0
- Loss-Making Row Share = rows where Profit < 0 divided by total rows
- Customer Pareto Share = cumulative sales/profit share by customer
- Product Pareto Share = cumulative sales/profit share by product or sub-category

Metric caution:
Use weighted profit margin for business summaries: SUM(Profit) / SUM(Sales). Avoid using average row-level margin as the main business margin because it gives small and large transactions equal weight.

## Working Data Grain

Initial working grain:
One row represents one product line item within an order.

Implications:
- COUNT(*) is line-item count, not order count.
- COUNT(DISTINCT Order ID) is order count.
- COUNT(DISTINCT Customer ID) is customer count.
- COUNT(DISTINCT Product ID) is product count.
- Product-level and customer-level analysis must aggregate carefully.
- Order-level analysis requires grouping by Order ID.

This grain is not fully frozen until Phase 2 QA.

## Scope

Core scope:
1. Sales and profit trends
2. Discount tier and margin analysis
3. Category, sub-category, product, region and segment mix
4. Customer historical contribution and Pareto concentration
5. Tableau dashboard for stakeholder-facing review

Out of scope unless core is complete:
- basket analysis
- forecasting
- causal modeling
- true customer lifetime value
- promotional optimization
- gross/net revenue reconstruction
- external market benchmarking

## Terminology Constraints

Locked terminology constraints:
- Do not call historical customer contribution true customer lifetime value.
- Do not reconstruct gross or net revenue without source support.
- Do not claim discounts caused losses.
- Do not say recommendations guarantee revenue growth.
- Basket analysis is optional only after core project completion.

## Success Criteria

The project is successful if it produces:
- a clean source and grain explanation;
- validated SQL/Python metric outputs;
- a Tableau dashboard mapped to stakeholder questions;
- clear findings separated from interpretations;
- commercially useful recommendations framed as review/testing priorities;
- a portfolio-ready README and methodology explanation.

## Scope Creep and Analytical Error Risks

Main risks:
1. Treating row count as order count.
2. Using average row margin instead of weighted margin.
3. Calling historical customer contribution true CLV.
4. Claiming discounts caused profit losses.
5. Overbuilding Tableau visuals before metric validation.
6. Using the rounded source-style file for detailed profit analysis.
7. Doing basket analysis before core profitability analysis.
8. Making recommendations without explaining uncertainty.

## Phase 0 Checkpoint

Completed work:
- Project thread started.
- Stakeholder defined.
- Main decision question confirmed.
- Business problem framed.
- Dataset candidates identified.
- Primary analytical file provisionally selected.
- Source caveat documented.
- Metric candidates listed but not frozen.
- Data grain assumption stated.
- Scope and exclusions defined.
- Overclaiming rules locked.

Decisions locked:
- Project focus: commercial profitability and revenue mix.
- Primary stakeholder: Commercial Analytics Manager / VP Sales Operations.
- Main decision question locked.
- Phase-based CRISP-DM-informed workflow locked.
- Do not freeze metrics until Phase 1 and Phase 2 verification.
- Use weighted profit margin for business-level profitability summaries.
- Treat basket analysis as optional post-core scope.

Limitations and risks:
- Superstore is a sample/fictitious dataset, not a real company dataset.
- The direct/source-style file appears rounded and less suitable for detailed analysis.
- Primary mirror needs provenance documentation.
- Customer and product analysis depends on fields present in the primary file.
- Metric validity depends on confirming grain and duplicates in Phase 2.

Unresolved questions:
- Which file will be documented as the final primary source after Phase 1?
- Are there any duplicate line items that require special handling?
- Should Tableau use the primary CSV directly or a cleaned/staged export?
- Which SQL engine will be used: SQLite, PostgreSQL-style SQL or DuckDB?

Immediate next action:
Start Phase 1 — Data Acquisition and Feasibility.

Clean stopping point:
Yes. Phase 0 is a clean stopping point.