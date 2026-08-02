# Alberta Home Insurance Interview Walkthrough

## Purpose

This file contains my spoken walkthrough for explaining the **Alberta Home Insurance Premium Pressure Monitor** project during an interview or portfolio review.

**Target length:** 5–8 minutes

---

## 1. 30-Second Opening

This project examines **Alberta home insurance price pressure from 2016 to 2025**, using home insurance CPI as the primary monitoring indicator.

I built an end-to-end workflow using **SQL, Python, and Power BI** to assess whether Alberta’s home insurance price growth diverged from general inflation, the Canadian home insurance trend, and selected construction-cost and catastrophe context.

The result is a **defensible monitoring tool** that helps a provincial public-policy analyst decide whether the observed pattern warrants a deeper affordability, insurance-market, or catastrophe-risk review.

---

## 2. Business Question and Stakeholder

The primary stakeholder is a **provincial public-policy or insurance-affordability analyst**.

The decision question is:

> **Has Alberta home insurance price growth diverged enough from relevant benchmarks to warrant a deeper affordability, market, or catastrophe-risk review?**

I intentionally framed the project as a **review-trigger tool rather than a causal model**.

The available aggregate data can identify unusual price patterns and benchmark divergence, but it cannot establish why individual premiums changed or determine whether insurance is affordable for particular households.

---

## 3. Data and Workflow

I used:

- Statistics Canada CPI data for Alberta and Canada
- a selected residential construction-cost series for replacement-cost context
- a curated catastrophe-loss table assembled from public insured-loss announcements
- Alberta passenger vehicle insurance CPI as a sensitivity check

I organized the data in a lightweight **SQLite warehouse** with a date dimension and separate fact tables for CPI, construction costs, and catastrophe events.

I used SQL to validate:

- row counts
- date coverage
- primary-key uniqueness
- joins to the date dimension
- missing values
- numeric fields
- catastrophe-loss totals

During validation, I identified a join-grain problem in the first annual summary view that multiplied catastrophe losses across CPI category rows. I corrected it by pre-aggregating the different datasets before joining the annual results.

I then loaded the validated SQL views into Python. Using pandas, I calculated:

- annual-average CPI trends
- cumulative change from baseline
- benchmark-divergence gaps
- five-year cohort summaries
- catastrophe-event context
- the auto insurance CPI sensitivity check

Finally, I exported analysis-ready CSV tables from Python and imported those files into Power BI.

---

## 4. Main Finding

The main figures compare **2025 annual-average CPI values with 2016 annual-average CPI values**.

From 2016 to 2025:

- Alberta home insurance CPI increased by approximately **74.6%**
- Alberta all-items CPI increased by approximately **27.4%**
- Canada home insurance CPI increased by approximately **64.5%**

This shows that Alberta home insurance prices rose substantially faster than general consumer prices in the province.

Alberta also recorded a larger cumulative increase than the Canadian home insurance benchmark by 2025. However, the large national increase shows that the price pressure was not unique to Alberta.

My interpretation is:

- **Evidence:** Alberta home insurance CPI exceeded both selected benchmarks by 2025.
- **Interpretation:** Alberta participated in a broader national home insurance price trend but experienced greater cumulative growth over the study period.
- **Not established:** The causes of the difference.

---

## 5. Dashboard Walkthrough

The Power BI dashboard has two pages.

### Page 1 — Executive Review

The first page presents the core monitoring view.

It includes:

- KPI cards summarizing cumulative growth and benchmark gaps
- a line chart showing how Alberta home insurance CPI diverged from Alberta all-items CPI and Canada home insurance CPI
- a short stakeholder interpretation
- a **Review Signal**

The Review Signal is a **judgment-based descriptive label**, not an automated threshold or statistical alert.

It indicates that the magnitude and persistence of the observed divergence may justify closer review. It should not be interpreted as a formal regulatory trigger or causal conclusion.

### Page 2 — Context and Sensitivity

The second page provides **contextual and sensitivity views**.

It shows:

- curated catastrophe losses by year
- Alberta home insurance CPI compared with auto insurance CPI and all-items CPI
- methodology caveats

The catastrophe view helps show whether major insured-loss periods coincide with the later years of stronger home insurance growth. It does not demonstrate that those events caused the price increases.

The auto insurance sensitivity check helps assess whether insurance price pressure appears broader across insurance lines or more concentrated in home insurance.

Auto insurance CPI also increased substantially, suggesting that some pressure may be market-wide. However, home insurance still recorded the larger cumulative increase by 2025.

---

## 6. Caveats and Limitations

This is a **descriptive and exploratory analysis**, not a causal model or forecast.

Home insurance CPI measures aggregate price change within the CPI basket. It does not represent:

- individual household premium amounts
- policy-level coverage changes
- deductibles
- insurer-specific pricing
- property characteristics
- local risk territories

Because the project does not include household income, premium-to-income ratios, or expenditure data, it identifies **price pressure relevant to an affordability review**, but it does not directly measure affordability.

Catastrophe events are used as contextual timing markers. The analysis does not claim that a particular wildfire, hailstorm, or severe-weather event caused a subsequent CPI increase.

The construction-cost benchmark also begins in 2017, so it provides replacement-cost context but is not directly aligned with the 2016 CPI baseline.

The analysis does not isolate the effects of:

- reinsurance costs
- claims severity
- regulatory changes
- market competition
- coverage exclusions
- insurer pricing cycles
- climate change

---

## 7. Recommendation and Future Work

I recommend using **benchmark divergence as a monitoring signal**.

If Alberta home insurance CPI continues to rise faster than both general inflation and the national home insurance benchmark, that would justify a more detailed investigation using insurer, regulatory, or policy-level data.

A deeper review could examine:

- claim frequency and severity
- repair and rebuilding costs
- reinsurance expenses
- deductibles and coverage changes
- insurer and market competition
- regional risk territories
- household income and premium-to-income measures

Future work could also:

- compare Alberta with other provinces
- add a more complete catastrophe-loss dataset
- incorporate income-based affordability indicators
- use spatial data to examine geographic differences in catastrophe exposure and insurance price pressure

These would be separate extensions rather than additions to the current project scope.

---

## 8. Closing Answer

Ultimately, this project provides a reproducible framework for identifying when Alberta home insurance price growth **diverges from selected economic and insurance benchmarks**.

It does not diagnose the cause of that divergence or directly measure household affordability. Instead, it gives stakeholders evidence for deciding whether a deeper affordability, insurance-market, or catastrophe-risk review is warranted.

---

# Interview Reasoning Chain

Do not memorize the full script word for word. Remember this sequence:

> **Stakeholder decision → home insurance CPI as the monitoring indicator → benchmark divergence → national context → contextual and sensitivity checks → no causal claim → recommendation for deeper review.**

---

# Technical Follow-Up Answers

## How were the percentage changes calculated?

The percentage changes were calculated using annual-average CPI values, comparing the 2025 annual average with the 2016 annual average.

## How was the Review Signal calculated?

The Review Signal is a judgment-based descriptive label based on the magnitude and persistence of benchmark divergence.

It is not generated by a formal statistical threshold, automated rule, or regulatory standard.

## How did Power BI receive the data?

Validated SQL views were analyzed in Python.

The final analysis-ready tables were exported as CSV files from Python and imported into Power BI.

## What does “curated catastrophe data” mean?

The table contains selected major Alberta insured-loss events assembled from public industry announcements.

It is intentionally limited and is not an exhaustive catastrophe database.

## Does the project directly measure affordability?

No.

It measures aggregate insurance price pressure that may justify an affordability review.

A direct affordability analysis would require household income, expenditure, premium-to-income, or policy-level premium data.

## Why was auto insurance CPI included?

Auto insurance CPI was included as a sensitivity check to assess whether price pressure appeared broader across insurance lines.

It was not treated as a direct property-insurance benchmark because auto and home insurance have different pricing drivers, claims structures, and regulatory conditions.

## What was the most important data-quality issue?

The first annual summary SQL view multiplied catastrophe losses because event totals were joined to multiple CPI category rows.

I corrected the issue by pre-aggregating CPI, construction-cost, and catastrophe-event data separately before joining the annual results.

## Why does the construction comparison use a different baseline?

The selected construction-cost series begins in 2017, while the CPI series begins in 2016.

For that reason, construction costs were used only as replacement-cost context and were not treated as directly aligned with the CPI-to-CPI comparisons.

---

# Delivery Notes

- Speak naturally rather than reading every paragraph.
- Lead with the stakeholder decision, not the software.
- Explain the main finding in plain language before discussing caveats.
- Distinguish clearly between evidence, interpretation, and what was not established.
- Do not describe catastrophe context as the cause of price growth.
- Do not claim that the project directly measures affordability.
- Be prepared to explain the annual-average calculation grain and the judgment-based Review Signal.