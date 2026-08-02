# Superstore Commercial Profitability Review — Interview Walkthrough

## Purpose

Spoken explanations for presenting the project in interviews and portfolio reviews.

## 30-Second Opening

I built the **Superstore Commercial Profitability Review** for a Commercial Analytics Manager using the fictitious Sample Superstore dataset. I validated 9,994 line items in SQLite, analyzed profitability in Python, and built a Tableau dashboard. The analysis showed that weaker profitability was concentrated in high-discount Binders, Machines, and Tables rather than entire categories. I recommended targeted commercial review, while noting that the pattern is observational because discount reasons and full cost data were unavailable.

## Two-Minute Walkthrough

The stakeholder for this project is a Commercial Analytics Manager or VP of Sales Operations. The decision question was: **Where is sales volume not translating into proportional profit across product mix, discount tiers, customers, and regions, and where should management prioritize commercial review?**

I used the fictitious Tableau Sample Superstore dataset, so this is a portfolio demonstration rather than a real-company consulting engagement. The data contained 9,994 product line items across 5,009 orders.

I staged and validated the data using SQL and SQLite. The most important grain decision was confirming that one row represents one product line item within an order. I checked row counts, key uniqueness, dates, missingness, category consistency, discount values, and profit ranges. In Python and pandas, I created business summaries and dashboard-ready exports. I used weighted profit margin—total profit divided by total sales—because averaging row-level margins would give small transactions disproportionate influence.

The main finding was that profitability pressure was concentrated in specific sub-category and discount-tier combinations rather than across entire product categories. High-discount Binders, Machines, and Tables showed particularly weak observed margins. Furniture generated about $742,000 in sales but only a 2.5% weighted margin, with the weakness concentrated mainly in Tables and Bookcases. Central also had the weakest regional margin at 7.9%. Separately, the top approximately 20% of customers contributed 47.96% of sales and 59.31% of profit; I describe that as historical contribution, not customer lifetime value.

I delivered the findings through a Tableau Public dashboard with KPI cards, a sub-category and discount-tier matrix, a sales-versus-margin view, and regional context. My recommendation was targeted review of pricing, promotion, and margin controls in the identified combinations—not broad pricing changes.

The findings are observational. The dataset lacks discount reasons, full product costs, promotion details, returns, and fulfillment costs, so it cannot prove that discounts caused losses or explain why a particular region performed differently.

## Technical Follow-Up Answers

### Why did you use weighted profit margin?

The data is at line-item grain and transaction sizes vary. I calculated `SUM(profit) / SUM(sales)` so larger transactions receive the appropriate business weight. Averaging row-level margins could allow small transactions to distort the overall result.

### What was the data grain?

One row represents one product line item within an order. An order can therefore appear across multiple rows when it contains multiple products.

### Did discounts cause the losses?

The project does not establish that. High-discount records were associated with weaker aggregate profitability, but discount reason, promotion strategy, product cost, and other potential drivers were unavailable.

### Is the customer analysis CLV?

No. It measures historical sales and profit contribution within the dataset period. True customer lifetime value would require retention, acquisition cost, repeat-purchase behavior, future value, and an appropriate time horizon.

### What would you investigate next with real company data?

I would add discount reason, promotion campaign, product and fulfillment costs, return information, inventory position, and approval rules. That would allow management to distinguish intentional strategic discounts from avoidable margin leakage.

## Delivery Notes

- Lead with the commercial decision, not the dashboard.
- Say **associated with weaker observed profitability**, not **caused losses**.
- Describe the sub-category and discount-tier combinations as review signals, not diagnosed failures.
- State early that Sample Superstore is fictitious data.
- Describe customer results as historical contribution, not CLV.
- Use the project title consistently: **Superstore Commercial Profitability Review**.
