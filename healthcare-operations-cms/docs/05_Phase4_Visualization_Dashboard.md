# Phase 4 — Visualization and Dashboarding

## Current Status

Phase 4 is complete.

The project created a compact set of stakeholder-facing visuals to support ED throughput screening and review-priority interpretation.

## Project

Healthcare Operations Analytics — ED Throughput Benchmarking

## Stakeholder and Decision Question

Primary stakeholder:

- Health-system Operations / Quality Improvement Analyst

Secondary stakeholders:

- Hospital Operations Director
- Emergency Department Manager
- Quality Improvement Team

Decision question:

Which hospitals show unusually weak emergency-department throughput indicators relative to available ED-volume peer categories and should receive further operational review?

## Phase Purpose

Phase 4 translates the Phase 3 profiling and benchmarking results into visual evidence.

The visuals are designed to help stakeholders understand:

- how ED wait-time distributions vary by ED-volume category
- how left-without-being-seen percentages vary by ED-volume category
- how review-priority hospitals appear across OP_18b and OP_22
- how review-priority candidates are distributed by flag type

## Why This Phase Matters

Visuals help stakeholders interpret the analysis without reading every QA table or benchmark output.

This phase matters because the project’s final story depends on matching every visual to a clear stakeholder question. The visuals should support operational screening, not imply causality or create a definitive hospital ranking.

## Visualization Inputs

Primary analysis dataset:

`data/processed/healthcare_ed_benchmark_analysis_table.csv`

Review-priority table:

`data/processed/healthcare_ed_review_priority_table.csv`

Peer benchmark summary:

`data/processed/healthcare_ed_peer_benchmark_summary.csv`

The visualizations were created from the complete-case benchmark population:

- 3,777 hospitals
- hospitals with available EDV, OP_18b, and OP_22

## Visual Output Folder

Visuals were saved to:

`outputs/figures/`

## Visual 1 — OP_18b ED Arrival-to-Departure Time by ED Volume Tier

File:

`outputs/figures/op18b_wait_time_by_ed_volume.png`

### Stakeholder Question

How does median ED arrival-to-departure time vary across ED-volume peer categories?

### Visual Type

Boxplot

### Fields Used

- x-axis: `ed_volume_category`
- y-axis: `op_18b_median_wait_min`

### Why This Visual Was Chosen

A boxplot shows the median, spread, and upper-tail values within each EDV group. This is appropriate because the stakeholder needs to compare distributions across peer categories, not only average values.

### What the Visual Shows

The chart shows that median ED arrival-to-departure time generally increases across ED-volume categories.

Observed median pattern:

- low: 120 minutes
- medium: 168 minutes
- high: 190 minutes
- very high: 194 minutes

Very-high-volume EDs also show the widest upper range and several high outliers.

### Interpretation

Supported interpretation:

Higher ED-volume categories generally show longer ED wait-time distributions and wider upper tails.

Unsupported interpretation:

This visual does not prove that ED volume causes longer waits.

---

## Visual 2 — OP_22 Left Without Being Seen by ED Volume Tier

File:

`outputs/figures/op22_lwbs_by_ed_volume_zoomed.png`

### Stakeholder Question

Do left-without-being-seen percentages differ across ED-volume peer categories?

### Visual Type

Boxplot with y-axis capped at 10% for readability

### Fields Used

- x-axis: `ed_volume_category`
- y-axis: `op_22_lwbs_pct`

### Why This Visual Was Chosen

A boxplot is useful because OP_22 has many low values and some high outliers. The zoomed y-axis makes the distribution differences easier to read while preserving the original outlier-aware analysis in the data.

### What the Visual Shows

LWBS percentages are generally low across all EDV categories, but the low-volume group has lower central values than the medium, high, and very-high groups.

Observed p90 pattern:

- low: 3%
- medium: 4%
- high: 5%
- very high: 5%

### Interpretation

Supported interpretation:

Medium, high, and very-high EDV groups show higher central OP_22 values and upper-tail values than low-volume EDs.

Unsupported interpretation:

This visual does not prove that higher ED volume causes patients to leave before being seen.

### Display Caveat

The y-axis is capped at 10% for readability. This improves visibility of the main distribution but should be disclosed when used in a report, README, or portfolio page.

---

## Visual 3 — ED Wait Time vs Left Without Being Seen

File:

`outputs/figures/op18b_vs_op22_review_priority.png`

### Stakeholder Question

Do review-priority hospitals tend to appear in higher OP_18b and/or higher OP_22 regions?

### Visual Type

Scatterplot

### Fields Used

- x-axis: `op_18b_median_wait_min`
- y-axis: `op_22_lwbs_pct`
- color/hue: `review_priority_flag`

### Why This Visual Was Chosen

A scatterplot helps stakeholders see how OP_18b and OP_22 relate at the hospital level and where review-priority candidates appear.

### What the Visual Shows

Review-priority hospitals appear more often in the higher-wait and/or higher-LWBS regions.

Some flagged hospitals appear at moderate global values because the review-priority flag is based on EDV-tier thresholds, not one global threshold.

### Interpretation

Supported interpretation:

Review-priority hospitals are elevated relative to their EDV-tier peer thresholds and often appear in higher-risk areas of the scatterplot.

Unsupported interpretation:

The visual does not prove that longer ED stays caused patients to leave before being seen.

---

## Visual 4 — Review-Priority Hospitals by Flag Type

File:

`outputs/figures/review_priority_by_flag_type.png`

### Stakeholder Question

How many review-priority hospitals are elevated on wait time only, LWBS only, or both indicators?

### Visual Type

Bar chart

### Fields Used

- category: `review_priority_type`
- value: hospital count

### Why This Visual Was Chosen

A bar chart clearly summarizes the review-priority groups and helps stakeholders distinguish broad throughput concerns from measure-specific review needs.

### What the Visual Shows

Review-priority breakdown:

- High wait only: 241 hospitals
- High LWBS only: 292 hospitals
- Both indicators high: 145 hospitals
- Any review-priority flag: 678 hospitals

### Interpretation

Supported interpretation:

Among 678 review-priority hospitals, 145 were elevated on both ED throughput indicators. These hospitals may warrant deeper operational review because both measures exceed EDV-tier 90th percentile thresholds.

Unsupported interpretation:

This chart does not rank hospital quality or diagnose the cause of elevated indicators.

## Visual Coverage Summary

| Visual | Stakeholder Question | Visual Type | Status |
|---|---|---|---|
| OP_18b by EDV tier | How does ED wait time vary by ED volume? | Boxplot | Complete |
| OP_22 by EDV tier | How does LWBS vary by ED volume? | Boxplot | Complete |
| OP_18b vs OP_22 | Do review-priority hospitals cluster in elevated regions? | Scatterplot | Complete |
| Review-priority by flag type | What type of review priority is most common? | Bar chart | Complete |

## Dashboard Decision

A full dashboard was not created for this mini project.

Decision:

Use a compact set of static Python visuals instead of building a full Power BI or Tableau dashboard.

Rationale:

This is a two-day mini project. Static visuals are sufficient to demonstrate:

- SQL QA
- Python profiling
- peer benchmarking
- stakeholder interpretation
- careful limitations

A larger dashboard would create scope creep and is better reserved for the senior Olist project.

## Visualization Design Principles

The visuals were selected using the following principles:

1. Each visual must answer a stakeholder question.
2. Visuals should support operational screening, not causal claims.
3. EDV should be shown as a categorical peer group.
4. OP_18b and OP_22 should remain separate indicators.
5. Review-priority results should not be presented as a definitive ranking.
6. Any axis cap or visual simplification must be disclosed.

## Mathematical Validity Checks

The visuals are mathematically valid because:

- OP_18b and OP_22 are numeric measures after SQL staging.
- EDV is used categorically, not as a numeric scale.
- Boxplots are appropriate for distribution comparison.
- Scatterplot uses hospital-level complete-case observations.
- Review-priority bar chart uses already validated flag counts.
- Visuals use the complete-case benchmark population of 3,777 hospitals.

## Readability Checks

Readability decisions:

- EDV category order is shown as low, medium, high, very high.
- Axis labels use stakeholder-readable descriptions.
- OP_18b is labeled in minutes.
- OP_22 is labeled as a percentage.
- The OP_22 zoomed chart uses a capped y-axis for readability and should be disclosed.
- Review-priority labels distinguish high wait only, high LWBS only, and both indicators high.

## Limitations and Risks

- The visuals are descriptive.
- They do not explain causes of elevated throughput indicators.
- OP_18b and OP_22 are not perfectly time-aligned.
- EDV peer groups do not adjust for trauma level, staffing, capacity, acuity, or local demand shocks.
- The scatterplot may suggest association but should not be interpreted causally.
- The review-priority table and chart are screening tools, not hospital quality rankings.

## Decisions Locked in Phase 4

1. Use 4 visuals for the portfolio version.
2. Use static Python visuals rather than a full dashboard.
3. Use EDV as the categorical comparison axis for OP_18b and OP_22.
4. Use the review-priority flag for the scatterplot and summary chart.
5. Use the zoomed OP_22 chart for readability, with disclosure.
6. Avoid causal or blame-oriented visual captions.
7. Reserve full dashboard expansion for a future project only if needed.

## Phase 4 Checkpoint

✅ Completed work:

- Created OP_18b distribution visual by EDV tier.
- Created OP_22 distribution visual by EDV tier.
- Created zoomed OP_22 visual for readability.
- Created OP_18b vs OP_22 scatterplot with review-priority flag.
- Created review-priority flag-type summary chart.
- Matched each visual to a stakeholder question.
- Checked visual interpretation guardrails.

🔒 Decisions locked:

- Static visuals are sufficient for this mini project.
- No full dashboard will be created.
- Visuals support screening and benchmarking only.
- OP_18b and OP_22 remain separate.
- Review-priority visuals are not rankings.

⚠️ Limitations and risks:

- OP_22 zoomed chart requires y-axis disclosure.
- Scatterplot does not support causal interpretation.
- EDV does not fully adjust for hospital complexity.
- Visuals do not diagnose operational causes.

❓ Unresolved questions:

- Final finding language will be drafted in Phase 5.
- Final README captions will be drafted in Phase 6.
- Final screenshots for the portfolio page may be selected during packaging.

➡️ Immediate next action:

Proceed to Phase 5 — Findings, Recommendations and Limitations.

🛑 Clean stopping point:

Yes. Phase 4 visualization work is complete.