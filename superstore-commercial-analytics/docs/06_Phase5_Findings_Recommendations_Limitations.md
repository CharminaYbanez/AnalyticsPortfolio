# 06_Phase5_Findings_Recommendations_Limitations.md

# Phase 5 — Findings, Recommendations and Limitations

## Project

Superstore Commercial Profitability and Revenue Mix

## Current Status

Phase 5 draft prepared after SQL staging, QA, Phase 3 analysis, and Tableau dashboard publication.

## Stakeholder

Commercial Analytics Manager or VP of Sales Operations

## Decision Question

Which products, customer segments, regions and discount patterns contribute to profitable growth or revenue leakage, and where should management prioritize commercial review?

## Key Findings

### Finding 1 — Profitability pressure is concentrated in specific sub-category and discount-tier combinations.

Profitability pressure is not evenly distributed across all products or categories. It is concentrated in specific sub-category and discount-tier combinations.

The clearest review signals are:
- High-discount Binders: 36.1K sales, -38.5K profit, -106.6% weighted margin
- High-discount Machines: 73.1K sales, -29.9K profit, -40.9% weighted margin
- High-discount Tables: 64.8K sales, -27.3K profit, -42.1% weighted margin
- High-discount Bookcases: 24.3K sales, -10.5K profit, -43.5% weighted margin
- High-discount Phones: 34.3K sales, -6.4K profit, -18.6% weighted margin

Interpretation:
These combinations should be prioritized for commercial review. The result shows observed profitability pressure, not causal proof that discounts caused losses.

### Finding 2 — Furniture has strong sales volume but weak profit conversion.

Furniture generated 742.0K in sales but only 18.5K in profit, with a 2.5% weighted margin and 33.7% loss-making line-item share.

Sub-category review shows that Furniture weakness is concentrated mainly in:
- Tables: -17.7K profit and -8.6% weighted margin
- Bookcases: -3.5K profit and -3.0% weighted margin

Interpretation:
Furniture should not be treated as uniformly weak. Tables and Bookcases are the main review areas.

### Finding 3 — High-discount activity is associated with negative profit across categories.

High-discount rows show negative aggregate profit across all three major categories:
- Furniture high discount: -43.8K profit
- Office Supplies high discount: -47.1K profit
- Technology high discount: -34.1K profit

Interpretation:
Higher discount tiers are associated with weaker observed profitability. This supports a discount and margin-control review, but it does not prove discount causality.

### Finding 4 — Central has the weakest regional profit profile.

Central has the lowest weighted margin and highest loss-making exposure among regions:
- Weighted margin: 7.9%
- Loss-making line-item share: 31.9%
- Loss-making profit: -56.3K

Interpretation:
Region should be used as a supporting lens. Central is a priority region for margin review, but the dataset does not explain why its profitability profile is weaker.

### Finding 5 — Customer contribution is meaningful but not the main project story.

The top approximately 20% of customers account for 47.96% of sales and 59.31% of profit.

Interpretation:
Customer contribution is meaningfully concentrated, especially for profit. However, this is historical customer contribution, not true customer lifetime value.

## Recommendations

1. Review high-discount Binders, Machines, Tables, Bookcases and Phones for pricing, promotion rules and margin controls.

2. Investigate Furniture profitability, especially Tables and Bookcases, before making broad category-level product decisions.

3. Use Central as a regional review lens because it has the lowest weighted margin and highest loss-making exposure.

4. Validate discount reasons, product costs, promotion policy and fulfillment or cost drivers before changing pricing strategy.

5. Monitor customer contribution by both sales and profit because high-sales customers are not always high-profit customers.

## Limitations

1. Superstore is a fictitious/sample dataset, so findings are portfolio/demo insights rather than real company conclusions.

2. Discount patterns are observational. The data does not prove that discounts caused losses.

3. The dataset does not include discount reason, promotion campaign, product condition, return reason, inventory status, supplier cost or fulfillment cost.

4. Customer analysis is historical contribution only, not true customer lifetime value.

5. Product-level ranking is limited because product_id and product_name are not perfectly one-to-one.

6. Region/state reflects customer/order geography, not supply-chain routing or product shipment origin.

7. Sales and profit are provided fields. Gross revenue, net revenue and full cost structure cannot be reconstructed.

## Final Interpretation

The dashboard supports a commercial profitability review focused on where sales volume does not translate into proportional profit. The strongest review areas are high-discount sub-category combinations, especially Binders, Machines, Tables, Bookcases and Phones. Findings should be used to prioritize review and further validation, not to make causal claims.