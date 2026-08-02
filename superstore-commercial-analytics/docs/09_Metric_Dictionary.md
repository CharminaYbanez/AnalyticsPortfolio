# 09_Metric_Dictionary.md

# Metric Dictionary — Superstore Commercial Profitability

## Project

Superstore Commercial Profitability and Revenue Mix

## Current Status

Metric dictionary frozen after Phase 2 SQL staging and QA, and Phase 3 metric validation.

## Confirmed Grain

The staged table `raw_superstore_sales` has product line-item grain.

Confirmed grain:
One row represents one product line item within an order.

Important implications:
- COUNT(*) = line-item count
- COUNT(DISTINCT order_id) = order count
- COUNT(DISTINCT customer_id) = customer count
- COUNT(DISTINCT product_id) = product count

## Default Date Field

Use `order_date` for sales, profit, margin, and year-over-year analysis.

Reason:
Order Date represents the business transaction date. Ship Date may extend into the following year and should only be used for fulfillment or shipping-timing questions.

## Core Metrics

### Total Sales

Definition:
SUM(sales)

Purpose:
Measures total observed sales amount.

SQL:
SUM(sales)

Cautions:
Sales is not gross revenue or net revenue. The dataset does not include list price, returns, taxes, fees, or gross/net revenue fields.

---

### Total Profit

Definition:
SUM(profit)

Purpose:
Measures total observed profit.

SQL:
SUM(profit)

Cautions:
The dataset includes profit but does not expose the underlying cost structure. Do not reconstruct cost of goods sold unless source fields support it.

---

### Weighted Profit Margin

Definition:
SUM(profit) / SUM(sales)

Purpose:
Measures aggregate profit conversion.

SQL:
SUM(profit) / SUM(sales)

Cautions:
Use weighted profit margin for business summaries. Do not use average row-level margin as the primary business margin because it can distort performance when sales values vary across line items.

---

### Line Item Count

Definition:
COUNT(*)

Purpose:
Counts product line-item records.

SQL:
COUNT(*)

Cautions:
This is not order count.

---

### Order Count

Definition:
COUNT(DISTINCT order_id)

Purpose:
Counts distinct customer orders.

SQL:
COUNT(DISTINCT order_id)

Cautions:
Because the dataset has line-item grain, order count must use distinct order_id.

---

### Customer Count

Definition:
COUNT(DISTINCT customer_id)

Purpose:
Counts distinct customers.

SQL:
COUNT(DISTINCT customer_id)

Cautions:
Customer ID was validated as clean in Phase 2. Customer analysis is historical contribution only, not true customer lifetime value.

---

### Product Count

Definition:
COUNT(DISTINCT product_id)

Purpose:
Counts distinct product IDs.

SQL:
COUNT(DISTINCT product_id)

Cautions:
Product ID and Product Name are not perfectly one-to-one. Use product_id as the product key and product_name only as a display label. Category and sub_category are preferred for primary product-mix storytelling.

---

## Profit Leakage / Loss-Making Metrics

### Loss-Making Line Items

Definition:
Count of line items where profit is less than zero.

SQL:
SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END)

Purpose:
Identifies observed loss-making product line items.

Cautions:
Negative profit rows are valid analytical records, not automatic data errors. They show observed losses but do not explain cause.

---

### Loss-Making Line-Item Share

Definition:
Loss-making line items divided by total line items.

SQL:
1.0 * SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) / COUNT(*)

Purpose:
Shows the share of product line items with negative profit.

Cautions:
This is a row-level share, not an order-level or sales-weighted share.

---

### Loss-Making Sales

Definition:
Sales attached to line items where profit is less than zero.

SQL:
SUM(CASE WHEN profit < 0 THEN sales ELSE 0 END)

Purpose:
Measures sales volume associated with negative-profit records.

Cautions:
This does not mean the sales caused the loss. It means those sales are attached to line items with negative observed profit.

---

### Loss-Making Profit

Definition:
Profit from line items where profit is less than zero.

SQL:
SUM(CASE WHEN profit < 0 THEN profit ELSE 0 END)

Purpose:
Measures the negative-profit pool.

Cautions:
Use as observed negative profit only. Do not call it recoverable profit.

---

## Discount Metrics

### Discount Tier

Definition:
Candidate discount grouping created during staging.

Current tiers:
- No Discount = 0%
- Low Discount = greater than 0% to 15%
- Moderate Discount = greater than 15% to 30%
- High Discount = greater than 30%

Purpose:
Groups observed discount values for profitability review.

Cautions:
Discount tier is observational. The data does not explain why discounts were applied. Do not claim discounts caused losses.

---

### Discount-Tier Weighted Profit Margin

Definition:
SUM(profit) / SUM(sales), grouped by discount_tier.

Purpose:
Compares profitability across discount levels.

Cautions:
Use association language. Avoid causal language.

Supported wording:
Higher discount tiers are associated with weaker observed profitability.

Unsupported wording:
Discounts caused the losses.

---

## Product-Mix Metrics

### Category Sales / Profit / Margin

Definition:
Sales, profit, and weighted margin grouped by category.

Purpose:
Identifies high-level product-mix performance.

Cautions:
Category-level findings should be checked against sub-category results before making recommendations.

---

### Sub-Category Sales / Profit / Margin

Definition:
Sales, profit, and weighted margin grouped by category and sub_category.

Purpose:
Identifies more precise product-mix review areas.

Cautions:
Sub-category is preferred over product-name-level ranking because product names are not reliable unique product keys.

---

### Sub-Category × Discount Tier Metrics

Definition:
Sales, profit, weighted margin, and loss-making share grouped by category, sub_category, and discount_tier.

Purpose:
Identifies where profit leakage is concentrated.

Cautions:
This is the strongest diagnostic layer, but still observational.

---

## Geographic Metrics

### Region Sales / Profit / Margin

Definition:
Sales, profit, and weighted margin grouped by region.

Purpose:
Identifies geographic profit-quality differences.

Cautions:
Region describes customer/order geography, not supply-chain routing or product shipment origin.

---

### State Sales / Profit / Margin

Definition:
Sales, profit, and weighted margin grouped by state and region.

Purpose:
Provides geographic drill-down.

Cautions:
State-level results should be interpreted with sales volume and order count. Avoid overemphasizing very low-volume states.

---

## Customer Contribution Metrics

### Customer Sales Contribution

Definition:
Customer total sales divided by total sales.

Purpose:
Measures historical customer sales contribution.

Cautions:
This is not true customer lifetime value.

---

### Customer Profit Contribution

Definition:
Customer total profit divided by total profit.

Purpose:
Measures historical customer profit contribution.

Cautions:
This is historical contribution only. It does not measure future value, retention, acquisition cost, or lifecycle value.

---

### Top 20% Customer Sales Share

Definition:
Sales from the top 20% of customers ranked by sales divided by total sales.

Result:
Top approximately 20% of customers account for 47.96% of total sales.

Purpose:
Measures sales concentration.

Cautions:
This is a Pareto-style concentration measure, not true CLV.

---

### Top 20% Customer Profit Share

Definition:
Profit from the top 20% of customers ranked by sales divided by total profit.

Result:
Top approximately 20% of customers account for 59.31% of total profit.

Purpose:
Measures profit concentration.

Cautions:
Because customers are ranked by sales, this metric shows profit contribution among the top sales customers, not necessarily the top profit customers.

---

## Year-over-Year Metrics

### Annual Sales

Definition:
SUM(sales) grouped by order_year.

Purpose:
Shows sales trend over time.

Cautions:
Sales growth may reflect higher order activity, not necessarily improved commercial efficiency.

---

### Annual Profit

Definition:
SUM(profit) grouped by order_year.

Purpose:
Shows profit trend over time.

Cautions:
Profit growth should be reviewed alongside order count and weighted margin.

---

### Annual Weighted Profit Margin

Definition:
SUM(profit) / SUM(sales), grouped by order_year.

Purpose:
Shows annual profit conversion.

Cautions:
Use weighted margin, not average row-level margin.

---

### Annual Loss-Making Line-Item Share

Definition:
Loss-making line items divided by total line items, grouped by order_year.

Purpose:
Checks whether loss-making activity is isolated to one year or persistent over time.

Result:
Loss-making line-item share stayed around 18–19% from 2014 to 2017.

Cautions:
This does not explain cause.

## Rejected / Out-of-Scope Metrics

### True Customer Lifetime Value

Rejected because:
The dataset does not include acquisition cost, retention horizon, future value, or lifecycle fields.

---

### Gross Revenue

Rejected because:
The dataset does not include list price or gross sales before discount.

---

### Net Revenue

Rejected because:
The dataset does not include returns, taxes, fees, or net revenue fields.

---

### Discount Causal Impact

Rejected because:
The dataset is observational and does not include an experiment, control group, promotion reason, or causal design.

---

### Profit Recovery from Removing Discounts

Rejected because:
This is an unsupported counterfactual.

---

### Product-Name-Only Ranking

Rejected because:
Product names are not reliable unique product keys. Product ID and Product Name are not perfectly one-to-one.