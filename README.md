# 📊 Analytics Portfolio — Charmina Ybanez

Selected end-to-end analytics projects demonstrating SQL data validation, Python analysis, BI dashboarding, stakeholder framing, and evidence-based business communication.

Portfolio website: [charminaybanez.github.io](https://charminaybanez.github.io/)

## 🚀 Featured Projects

### Alberta Home Insurance Premium Pressure Monitor

A stakeholder-focused monitoring project assessing whether Alberta home-insurance CPI growth diverged from provincial inflation, national home-insurance trends, and selected cost and catastrophe context.

- **Tools:** SQL, SQLite, Python, pandas, Power BI
- **Project:** [alberta-home-insurance](alberta-home-insurance/)

### Superstore Commercial Profitability Review

A commercial analytics mini project using the fictitious Tableau Sample Superstore dataset to identify where sales volume did not translate into proportional profit across product mix, discount tiers, customers, and regions. Findings are observational portfolio insights rather than real-company conclusions.

- **Tools:** SQL, SQLite, Python, pandas, Tableau Public
- **Project:** [superstore-commercial-analytics](superstore-commercial-analytics/)
- **Dashboard:** [View on Tableau Public](https://public.tableau.com/views/SuperstoreCommercialProfitabilityReview/Dashboard?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

### Healthcare Operations Analytics — ED Throughput Benchmarking

An operational-screening project using CMS hospital data and ED-volume peer benchmarks to identify hospitals that may warrant further review. Review-priority flags are screening indicators, not hospital rankings or causal diagnoses.

- **Tools:** SQL, SQLite, Python, pandas, matplotlib, seaborn
- **Project:** [healthcare-operations-cms](healthcare-operations-cms/)

## 🧭 In Progress

### Olist Marketplace Operations

A planned senior-level marketplace analytics project focused on multi-table modeling, delivery performance, seller operations, customer reviews, and executive BI.

## 🗂️ Repository Organization

Each completed project is stored in its own folder with the relevant SQL scripts, notebooks, documentation, outputs, and project README. Raw datasets, processed datasets, local databases, and environment files are excluded from version control where appropriate.

```text
AnalyticsPortfolio/
├── alberta-home-insurance/
├── healthcare-operations-cms/
├── superstore-commercial-analytics/
├── olist-marketplace-analytics/
└── docs/
```

## ✅ Analytical Standards

- Define the stakeholder and decision question before selecting metrics.
- Confirm source grain, keys, date coverage, missingness, and joins before analysis.
- Separate observed evidence, interpretation, recommendations, and limitations.
- Avoid causal claims when the data supports only descriptive or exploratory analysis.
- Preserve reproducible SQL, Python, documentation, and dashboard-ready outputs.
