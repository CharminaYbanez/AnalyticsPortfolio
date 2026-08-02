# Alberta Home Insurance Premium Pressure Monitor  
## Presentation Outline

**Project type:** SQL, Python, and Power BI Analytics Capstone  
**Time period:** 2016–2025  
**Primary stakeholder:** Provincial public policy / insurance affordability analyst  
**Main decision question:** Is Alberta home insurance premium growth unusual enough to warrant deeper affordability, market, or catastrophe-risk review?

---

# Slide 1 – Title Page

## Title

Alberta Home Insurance Premium Pressure Monitor

## Subtitle

SQL, Python, and Power BI Analytics Capstone

## Footer

2016–2025 CPI, benchmark, and catastrophe-context analysis

## Purpose

Introduce the project scope and analytical focus.

## Speaker Notes

This project analyzes Alberta home insurance premium pressure from 2016 to 2025. The goal was to build an end-to-end analytics workflow using SQL, Python, and Power BI to assess whether Alberta home insurance CPI growth appeared unusual relative to general inflation, Canada-wide home insurance trends, and selected catastrophe-event context.

---

# Slide 2 – Business Question & Stakeholder

## Title

Business Question

## Main Content

**Primary stakeholder:**  
Provincial public policy / insurance affordability analyst

**Decision question:**  
Is Alberta home insurance premium growth unusual enough to warrant deeper affordability, market, or catastrophe-risk review?

**Project framing:**  
This analysis is designed as a review-trigger tool, not a causal proof model.

## Suggested Visual

Simple stakeholder/question layout:

- Stakeholder
- Decision question
- Review-trigger framing

## Speaker Notes

The project is not trying to prove whether premiums are justified or caused by one specific factor. Instead, it helps identify whether Alberta home insurance CPI growth diverges enough from relevant benchmarks to justify deeper review. This framing is important because insurance premiums can be influenced by multiple factors, including inflation, construction costs, catastrophe losses, reinsurance, regulation, and broader market pricing cycles.

---

# Slide 3 – Data & Analytics Workflow

## Title

Data and Analytics Workflow

## Main Content

**Data sources used:**

- Alberta homeowners' home and mortgage insurance CPI
- Alberta all-items CPI
- Canada homeowners' home and mortgage insurance CPI
- Residential construction-cost context
- Curated Alberta catastrophe event table
- Alberta passenger vehicle insurance CPI sensitivity check

**Workflow:**

Raw data  
→ SQLite warehouse  
→ SQL quality checks and views  
→ Python analysis  
→ Power BI dashboard  
→ Final stakeholder story

## Suggested Visual

A simple flow diagram:

`Raw data → SQL Warehouse → Python Analysis → Power BI Dashboard → Stakeholder Review`

## Speaker Notes

I structured the project as an end-to-end analytics workflow. The data were first organized in a lightweight SQLite warehouse with a date dimension and fact tables. SQL was used for data modeling, quality checks, and analytical views. Python was then used for annual trend analysis, benchmark comparisons, percent-change calculations, catastrophe-event context, and the optional auto insurance CPI sensitivity check. The final dashboard-ready tables were exported to Power BI for stakeholder visualization.

---

# Slide 4 – Main Finding

## Title

Alberta Home Insurance CPI Rose Faster Than Key Benchmarks

## Main Content

From 2016 to 2025:

- Alberta home insurance CPI increased by approximately **74.6%**
- Alberta all-items CPI increased by approximately **27.4%**
- Canada home insurance CPI increased by approximately **64.5%**

## Key Message

Alberta home insurance CPI rose much faster than Alberta general inflation and exceeded Canada-wide home insurance CPI growth by 2025.

## Suggested Visual

Use either:

- Main indexed-growth line chart, or
- Page 1 dashboard screenshot cropped around KPI cards and line chart

## Speaker Notes

The main finding is that Alberta home insurance CPI increased substantially faster than general consumer prices in Alberta. Alberta also exceeded the Canada-wide home insurance benchmark by 2025. However, Alberta was not consistently above the Canada benchmark across the full period, which means the finding should be interpreted carefully. The stronger conclusion is that Alberta appears to follow broader Canada-wide home insurance pressure, with possible Alberta-specific amplification in the later years.

---

# Slide 5 – Dashboard Page 1: Executive Review

## Title

Executive Review Dashboard

## Main Content

**Dashboard page:** Alberta Home Insurance Premium Pressure Monitor

**Page 1 includes:**

- Five KPI cards
- Main CPI indexed-growth comparison
- Review signal box
- Stakeholder interpretation text

**Main review signal:**  
Further review may be warranted.

## Suggested Visual

Insert screenshot:

`dashboard_page_1_executive_review.png`

## Speaker Notes

The first dashboard page is designed for quick stakeholder review. The KPI cards summarize cumulative growth and benchmark gaps by 2025. The main line chart compares Alberta home insurance CPI growth against Alberta all-items CPI and Canada home insurance CPI. The review signal is intentionally cautious: it says further review may be warranted, not that the dashboard proves causality.

---

# Slide 6 – Context & Sensitivity Review

## Title

Context and Sensitivity Checks

## Main Content

**Page 2 includes:**

- Curated Alberta catastrophe losses by year
- Home vs auto insurance CPI sensitivity check
- Method caveats

**Key interpretation:**

- Curated catastrophe events cluster more heavily in later years.
- Auto insurance CPI also increased, suggesting some broader insurance-market pressure.
- Home insurance still exceeded auto insurance growth by 2025.
- Context supports further review but does not prove causality.

## Suggested Visual

Insert screenshot:

`dashboard_page_2_context_sensitivity_review.png`

## Speaker Notes

The second dashboard page provides supporting context. The catastrophe-loss chart shows the timing and concentration of selected major insured-loss events. The sensitivity chart compares Alberta home insurance CPI with Alberta passenger vehicle insurance CPI and Alberta all-items CPI. This sensitivity check helps test whether insurance premium pressure appears broader than home insurance alone. However, auto insurance is not a property benchmark because it has different pricing drivers, claim structures, and regulatory conditions.

---

# Slide 7 – Limitations and Interpretation Guardrails

## Title

Limitations and Interpretation Guardrails

## Main Content

This analysis is descriptive and exploratory.

**Key limitations:**

- Catastrophe events are contextual markers, not causal proof.
- The catastrophe event table is curated, not exhaustive.
- Construction-cost comparison uses a 2017 baseline.
- CPI data are aggregated and do not show individual policy premiums, deductibles, coverage changes, or regional risk territories.
- Auto insurance CPI is a sensitivity check, not a direct home insurance benchmark.
- The analysis does not isolate climate change, reinsurance, regulation, construction costs, insurer pricing models, or claims severity.

## Key Sentence

Limitations define the valid use case: this dashboard supports review and follow-up investigation, not causal attribution.

## Suggested Visual

Use a clean text slide with icons or simple grouped bullets.

## Speaker Notes

The limitations are important because they define how the dashboard should be used. This project identifies divergence and review signals. It does not claim to explain every driver of premium change. That distinction is what keeps the analysis defensible. The dashboard is best interpreted as a tool for identifying where deeper affordability, market, or catastrophe-risk review may be needed.

---

# Slide 8 – Recommendation & Future Work

## Title

Recommendation and Future Work

## Main Recommendation

Use benchmark divergence as a monitoring signal for affordability, market, and catastrophe-risk review.

## Future Work

Future extensions could include:

- Comparing Alberta against other provinces
- Adding more complete catastrophe-event data
- Investigating property-specific drivers such as claims severity, reinsurance costs, deductibles, exclusions, and regional risk territories
- Exploring GIS or regional exposure analysis as a separate project
- Comparing additional insurance markets such as commercial property, condo/strata, agricultural/crop, and municipal/public-sector insurance

## Closing Message

The project identifies when Alberta home insurance CPI diverges from relevant benchmarks and helps stakeholders decide where deeper review is warranted.

## Footer

Charmina Ybanez | Portfolio: yourwebsite.com

## Speaker Notes

The recommendation is not to make a policy conclusion from this dashboard alone. The recommendation is to use benchmark divergence as a monitoring signal. If Alberta home insurance CPI continues to rise faster than general inflation and national home insurance trends, that should trigger deeper review into affordability, market conditions, and catastrophe-risk exposure. Future work can expand the analysis by adding provincial comparisons, more detailed catastrophe data, and regional or property-specific risk indicators.

---

# Presentation Timing Guide

Target length: **5–8 minutes**

Suggested timing:

- Slide 1: 20 seconds
- Slide 2: 45 seconds
- Slide 3: 60 seconds
- Slide 4: 90 seconds
- Slide 5: 90 seconds
- Slide 6: 90 seconds
- Slide 7: 60 seconds
- Slide 8: 45 seconds

---

# Presentation Delivery Notes

## Main Story

This is a review-trigger analytics project. The dashboard helps stakeholders identify whether Alberta home insurance CPI growth appears unusual relative to selected benchmarks.

## What to Emphasize

- The project is end-to-end: SQL, Python, Power BI, and documentation.
- The analysis is stakeholder-framed.
- The findings are cautious and benchmarked.
- The dashboard does not overclaim causality.
- The sensitivity check strengthens the interpretation by testing broader insurance-market pressure.

## What Not to Overclaim

Avoid saying:

- “Hail caused premiums to rise.”
- “The dashboard proves insurers increased prices because of catastrophe losses.”
- “The analysis forecasts future premiums.”
- “Alberta’s increase is entirely province-specific.”

Use instead:

- “The pattern supports further review.”
- “Catastrophe events are timing/context markers.”
- “Alberta appears to follow broader Canada-wide pressure, with possible Alberta-specific amplification by 2024–2025.”
- “The dashboard is descriptive and exploratory.”