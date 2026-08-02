# 10_SQL_Python_DAX_Spellbook.md

# SQL / Python / Tableau Spellbook — Superstore Commercial Profitability

## Project

Superstore Commercial Profitability and Revenue Mix

## Purpose

This note records reusable syntax and logic patterns used in the project.

## SQL Patterns

### Count Rows and Distinct Keys

```sql
SELECT
    COUNT(*) AS row_count,
    COUNT(DISTINCT row_id) AS distinct_row_ids,
    COUNT(DISTINCT order_id) AS distinct_orders,
    COUNT(DISTINCT customer_id) AS distinct_customers,
    COUNT(DISTINCT product_id) AS distinct_products
FROM raw_superstore_sales;
```

Use for:
- grain checks
- duplicate checks
- key validation

### Weighted Profit Margin

```sql
ROUND(SUM(profit) / SUM(sales), 4) AS weighted_profit_margin
```

Use for:
- aggregate margin
- category margin
- region margin
- sub-category margin

Do not use average row-level margin as the main business margin.

### Loss-Making Line Items

```sql
SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) AS loss_making_line_items
```

Use for:
- count of negative-profit rows

### Loss-Making Line-Item Share

```sql
ROUND(
    1.0 * SUM(CASE WHEN profit < 0 THEN 1 ELSE 0 END) / COUNT(*),
    4
) AS loss_making_line_item_share
```

Use for:
- share of line items with negative profit

### Loss-Making Sales

```sql
ROUND(SUM(CASE WHEN profit < 0 THEN sales ELSE 0 END), 2) AS loss_making_sales
```

Use for:
- sales attached to negative-profit rows

### Loss-Making Profit

```sql
ROUND(SUM(CASE WHEN profit < 0 THEN profit ELSE 0 END), 2) AS loss_making_profit
```

Use for:
- total negative-profit pool

### Grouped Profitability Summary

```sql
SELECT
    category,
    sub_category,
    COUNT(*) AS line_item_count,
    COUNT(DISTINCT order_id) AS order_count,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / SUM(sales), 4) AS weighted_profit_margin
FROM raw_superstore_sales
GROUP BY category, sub_category
ORDER BY total_profit ASC;
```

Use for:
- category analysis
- sub-category analysis
- region analysis
- segment analysis

### Customer Pareto Pattern

```sql
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
```

Use for:
- customer contribution ranking
- Pareto-style cumulative share analysis

## Python Patterns

### Project Paths

```python
from pathlib import Path

project_root = Path.cwd().parent

raw_path = project_root / "data" / "raw" / "Sample - Superstore.csv"
processed_path = project_root / "data" / "processed" / "stg_superstore_sales.csv"
db_path = project_root / "data" / "database" / "superstore_commercial_analytics.db"
```

Use for:
- consistent project-relative paths

### Read CSV

```python
import pandas as pd

df = pd.read_csv(raw_path, encoding="latin-1")
```

### Convert Dates

```python
df["order_date"] = pd.to_datetime(df["order_date"])
df["ship_date"] = pd.to_datetime(df["ship_date"])
```

### Create Derived Date Fields

```python
df["order_year"] = df["order_date"].dt.year
df["order_month"] = df["order_date"].dt.to_period("M").astype(str)
df["ship_days"] = (df["ship_date"] - df["order_date"]).dt.days
```

### Create Profit Flag

```python
df["profit_flag"] = df["profit"].apply(
    lambda x: "Loss-Making" if x < 0 else "Profitable"
)
```

### Create Discount Tier

```python
def assign_discount_tier(discount):
    if discount == 0:
        return "No Discount"
    elif discount <= 0.15:
        return "Low Discount"
    elif discount <= 0.30:
        return "Moderate Discount"
    else:
        return "High Discount"

df["discount_tier"] = df["discount"].apply(assign_discount_tier)
```

### Save Staged CSV

```python
df.to_csv(processed_path, index=False)
```

### Run SQL Query from Python

```python
import sqlite3
import pandas as pd

def run_sql(query):
    conn = sqlite3.connect(db_path)
    try:
        result = pd.read_sql_query(query, conn)
    finally:
        conn.close()
    return result
```

### Execute SQL Script

```python
sql_script_path = project_root / "sql" / "04_analytical_table.sql"
sql_script = sql_script_path.read_text(encoding="utf-8")

conn = sqlite3.connect(db_path)

try:
    conn.executescript(sql_script)
    conn.commit()
    print("SQL script executed successfully.")
finally:
    conn.close()
```

### Export Dashboard-Ready CSVs

```python
dashboard_data_path = project_root / "outputs" / "dashboard_data"
dashboard_data_path.mkdir(parents=True, exist_ok=True)

exports = {
    "overall_commercial_summary.csv": overall_summary,
    "category_summary.csv": category_summary,
    "sub_category_summary.csv": sub_category_summary,
    "discount_category_summary.csv": discount_category_summary,
    "subcat_discount_summary.csv": subcat_discount_summary,
    "region_summary.csv": region_summary,
    "customer_top20_share.csv": customer_top20_share,
    "yoy_summary.csv": yoy_summary
}

for filename, dataframe in exports.items():
    output_path = dashboard_data_path / filename
    dataframe.to_csv(output_path, index=False)
    print(f"Saved: {output_path}")
```

## Tableau Patterns

### KPI Formatting

Recommended KPI labels:
- Sales
- Profit
- Weighted Margin
- Orders
- Loss-Making Share
- Loss-Making Sales

Formatting:
- Sales: currency, millions, 2 decimals
- Profit: currency, thousands, 0 decimals
- Weighted Margin: percentage, 1 decimal
- Orders: whole number
- Loss-Making Share: percentage, 1 decimal
- Loss-Making Sales: currency, thousands, 0 decimals

### Matrix Color Logic

For weighted profit margin:
- Red = negative / weak margin
- Neutral = around 0%
- Blue = positive margin

Discount tier order:
1. No Discount
2. Low Discount
3. Moderate Discount
4. High Discount

### Tableau Tooltip Guardrail

Use cell-level fields only.

Do not mix overall summary fields into sub-category or matrix tooltips.

Correct matrix tooltip fields:
- Sub Category
- Discount Tier
- Category
- Total Sales
- Total Profit
- Weighted Margin
- Line Items
- Loss-Making Share

Avoid:
- overall order count
- overall loss-making sales
- unrelated data source fields

## DAX

DAX was not used in this project.

Note:
Power BI and DAX are reserved for other projects or practice labs. Tableau Public is the final dashboard platform for this mini project.
```

After creating these, update the README repository structure back to include the full docs list and use the corrected screenshot filenames.