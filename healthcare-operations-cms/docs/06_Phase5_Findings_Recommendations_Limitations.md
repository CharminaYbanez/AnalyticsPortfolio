# Phase 5 — Findings, Recommendations and Limitations

## Current Status

Phase 5 is complete.

This phase converts the Phase 3 analysis and Phase 4 visuals into stakeholder-ready findings, cautious recommendations, and clearly stated limitations.

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

Phase 5 translates the analysis into decision-support language.

This phase separates:

- what the data shows
- what the data suggests
- what stakeholders could investigate
- what cannot be concluded

The goal is to provide useful operational screening insights without overclaiming, diagnosing causes, or creating a definitive hospital ranking.

## Evidence Base

Phase 5 is based on:

- SQL-validated analytical mart
- Python profiling results
- EDV-tier peer benchmark table
- review-priority flags
- review-priority candidate table
- four stakeholder-facing visuals

Key outputs used:

- `data/processed/healthcare_ed_throughput_mart.csv`
- `data/processed/healthcare_ed_peer_benchmark_summary.csv`
- `data/processed/healthcare_ed_benchmark_analysis_table.csv`
- `data/processed/healthcare_ed_review_priority_table.csv`

Visuals used:

- `outputs/figures/op18b_wait_time_by_ed_volume.png`
- `outputs/figures/op22_lwbs_by_ed_volume_zoomed.png`
- `outputs/figures/op18b_vs_op22_review_priority.png`
- `outputs/figures/review_priority_by_flag_type.png`

## Key Finding 1 — Higher EDV categories show longer OP_18b wait-time distributions

### What the data shows

Median OP_18b wait time generally increases across ED-volume categories:

| EDV Category | OP_18b Median |
|---|---:|
| low | 120 minutes |
| medium | 168 minutes |
| high | 190 minutes |
| very high | 194 minutes |

The very-high EDV group also shows the highest upper-tail wait-time benchmark:

| EDV Category | OP_18b P90 |
|---|---:|
| low | 162.9 minutes |
| medium | 218.0 minutes |
| high | 252.0 minutes |
| very high | 271.6 minutes |

### What the data suggests

Higher-volume ED categories tend to have longer ED arrival-to-departure time distributions, particularly in the upper tail.

### Stakeholder implication

Operations and quality teams should avoid comparing raw wait times across all hospitals without considering ED-volume category.

EDV-tier peer comparisons provide a more defensible first-pass screening method than global comparisons.

### What cannot be concluded

The analysis does not prove that higher ED volume causes longer waits.

EDV does not fully adjust for trauma level, staffing, ED bed capacity, patient acuity, inpatient boarding pressure, or local demand shocks.

---

## Key Finding 2 — OP_22 values are generally low but show meaningful upper-tail variation

### What the data shows

Overall OP_22 left-without-being-seen percentages are low:

| Statistic | OP_22 Value |
|---|---:|
| Median | 1% |
| 75th percentile | 2% |
| 90th percentile | 4% |
| 95th percentile | 5% |
| Maximum | 23% |

By EDV tier, OP_22 median values are:

| EDV Category | OP_22 Median | OP_22 P90 |
|---|---:|---:|
| low | 1% | 3% |
| medium | 2% | 4% |
| high | 2% | 5% |
| very high | 2% | 5% |

### What the data suggests

Low-volume EDs have lower central OP_22 values, while medium, high, and very-high EDV groups show higher upper-tail LWBS values.

### Stakeholder implication

LWBS review should focus less on average values and more on upper-tail hospitals within each EDV tier.

### What cannot be concluded

The analysis does not prove that longer ED wait times caused patients to leave before being seen.

OP_18b and OP_22 also use different reporting windows, so their relationship should be interpreted cautiously.

---

## Key Finding 3 — 678 hospitals were flagged as review-priority candidates

### What the data shows

Using EDV-tier 90th percentile thresholds, hospitals were flagged if they were at or above the peer-tier 90th percentile for OP_18b and/or OP_22.

Benchmark population:

- 3,777 hospitals

Review-priority results:

| Flag Type | Count | Percent of Benchmark Population |
|---|---:|---:|
| High OP_18b wait | 386 | 10.2% |
| High OP_22 LWBS | 437 | 11.6% |
| Any review-priority flag | 678 | 18.0% |

### What the data suggests

A meaningful subset of hospitals has elevated ED throughput indicators relative to ED-volume peers.

The 18.0% review-priority rate is expected because the flag uses an OR condition across two measures.

### Stakeholder implication

The review-priority flag can help a health-system operations or QI analyst narrow a broad hospital dataset into a focused operational review queue.

### What cannot be concluded

The flag does not identify poor-performing hospitals.

It identifies hospitals whose OP_18b and/or OP_22 values are elevated relative to EDV-tier thresholds and may warrant further review.

---

## Key Finding 4 — 145 hospitals were elevated on both ED throughput indicators

### What the data shows

Review-priority overlap:

| Review-Priority Type | Count | Percent of Benchmark Population |
|---|---:|---:|
| High wait only | 241 | 6.4% |
| High LWBS only | 292 | 7.7% |
| Both indicators high | 145 | 3.8% |
| Any review priority | 678 | 18.0% |

### What the data suggests

The 145 hospitals elevated on both OP_18b and OP_22 represent the strongest review-priority subset because both throughput indicators exceed EDV-tier 90th percentile thresholds.

### Stakeholder implication

Quality improvement teams could prioritize these hospitals for deeper review before investigating hospitals elevated on only one measure.

### What cannot be concluded

Being elevated on both indicators does not diagnose the cause.

Possible drivers could include staffing, capacity, acuity, boarding pressure, local demand, reporting differences, or other operational factors not available in this dataset.

---

## Recommendations

## Recommendation 1 — Use EDV-tier peer benchmarking as the first screening layer

Stakeholders should use ED-volume peer categories when comparing OP_18b and OP_22.

Rationale:

- EDV groups are large enough for descriptive benchmarking.
- OP_18b wait-time distributions differ meaningfully across EDV categories.
- EDV-tier comparisons are more defensible than global comparisons across all hospitals.

Implementation idea:

Use the EDV-tier median, 75th percentile, and 90th percentile as the first-pass benchmark framework.

Caution:

EDV is not a full risk adjustment model.

---

## Recommendation 2 — Prioritize hospitals elevated on both OP_18b and OP_22 for deeper review

The strongest review-priority subset is the 145 hospitals elevated on both indicators.

Rationale:

- These hospitals exceeded peer-tier 90th percentile thresholds for both wait time and LWBS.
- This dual elevation may indicate broader throughput review needs.

Stakeholders could investigate:

- ED staffing patterns
- ED bed capacity
- inpatient boarding delays
- registration and triage workflows
- arrival surges
- acuity mix
- local demand conditions
- internal process bottlenecks

Caution:

The CMS data cannot determine which of these factors caused elevated indicators.

---

## Recommendation 3 — Use measure-specific review pathways for one-indicator flags

Hospitals flagged on only one measure should not be treated the same as hospitals flagged on both.

Suggested review pathways:

High wait only:

- review ED throughput workflow
- review discharge process timing
- review boarding and bed availability
- review staffing coverage by time period

High LWBS only:

- review front-end access
- review triage and registration timing
- review waiting-room management
- review communication with waiting patients
- review arrival surges and peak demand

Both indicators high:

- prioritize for broader operational review
- investigate both throughput and access workflows

Caution:

These are investigation directions, not conclusions.

---

## Recommendation 4 — Preserve missingness and footnotes in future analysis

Not Available values should remain visible in reporting outputs.

Rationale:

- EDV has 823 Not Available values.
- OP_18b has 583 Not Available values.
- OP_22 has 828 Not Available values.
- Missingness may reflect CMS reporting, suppression, eligibility, or sample-size conditions.

Stakeholders should not interpret missing values as zero performance, poor performance, or normal random missingness.

---

## Limitations

## Limitation 1 — Reporting windows are not perfectly synchronized

EDV and OP_22 use:

- 01/01/2024 to 12/31/2024

OP_18b uses:

- 07/01/2024 to 06/30/2025

Impact:

The measures are recent and relevant, but not perfectly time-aligned.

Interpretation rule:

Do not interpret OP_18b and OP_22 associations as causal or fully synchronized.

---

## Limitation 2 — EDV is not a full adjustment model

EDV groups hospitals by emergency department volume category.

EDV does not adjust for:

- trauma level
- staffing levels
- ED bed capacity
- inpatient boarding pressure
- patient acuity
- case mix
- local demand shocks
- urban/rural operational context

Impact:

EDV-tier benchmarking is useful for descriptive screening, but it does not create fully comparable hospital peer groups.

---

## Limitation 3 — Missingness may be non-random

Not Available values may reflect reporting rules, eligibility, suppression, or sample-size conditions.

Impact:

Measure-specific populations differ.

The complete-case benchmarking population includes 3,777 hospitals, while the full analytical mart contains 4,660 hospitals.

Interpretation rule:

Report valid populations clearly.

---

## Limitation 4 — Review-priority flags are screening indicators

The review-priority flag identifies hospitals at or above EDV-tier 90th percentile thresholds.

Impact:

Flags help prioritize review but do not diagnose performance issues.

Interpretation rule:

Use “review-priority candidate” or “may warrant operational review.”

Avoid “worst hospital,” “bad hospital,” or “poorly managed.”

---

## Limitation 5 — OP_22 percentile ties affect flag counts

OP_22 values are whole-number percentages with many ties.

Impact:

The number of hospitals at or above the 90th percentile may be slightly more than 10% of the benchmark population.

Interpretation rule:

This is a normal threshold/tie effect, not a calculation error.

---

## What the Data Shows

The data shows:

1. The full analytical mart contains 4,660 hospitals.
2. The EDV complete-case benchmarking population contains 3,777 hospitals.
3. EDV peer groups are large enough for descriptive benchmarking.
4. OP_18b median wait time generally increases across EDV categories.
5. OP_22 values are generally low but show upper-tail differences by EDV tier.
6. 678 hospitals were flagged as review-priority candidates.
7. 145 hospitals were elevated on both OP_18b and OP_22.

## What the Data Suggests

The data suggests:

1. EDV peer grouping improves the fairness of first-pass comparisons.
2. Higher ED-volume groups tend to have longer ED arrival-to-departure distributions.
3. Upper-tail LWBS values are higher in medium, high, and very-high EDV groups than in low EDV hospitals.
4. Hospitals elevated on both indicators may warrant deeper operational review than hospitals elevated on only one indicator.
5. Measure-specific flags can guide different operational review pathways.

## What Stakeholders Could Investigate

Stakeholders could investigate:

1. Whether review-priority hospitals have identifiable staffing, capacity, or workflow constraints.
2. Whether high OP_18b hospitals have boarding, discharge, or bed-turnover bottlenecks.
3. Whether high OP_22 hospitals have front-end access or triage delay issues.
4. Whether hospitals elevated on both indicators share operational patterns.
5. Whether missing CMS values reflect reporting, eligibility, or suppression conditions.
6. Whether local data confirms the CMS screening results.

## What Cannot Be Concluded

The data cannot conclude:

1. That ED volume causes longer wait times.
2. That longer wait times caused patients to leave before being seen.
3. That flagged hospitals are poorly managed.
4. That review-priority hospitals are definitively worse hospitals.
5. That EDV fully adjusts for hospital complexity.
6. That operational causes can be identified from CMS data alone.
7. That OP_18b and OP_22 are perfectly time-aligned.

## Final Stakeholder Message

The analysis provides a defensible ED throughput screening framework using CMS hospital data.

By validating the data structure, preserving missingness, benchmarking within ED-volume categories, and flagging hospitals above EDV-tier 90th percentile thresholds, the project identifies hospitals that may warrant further operational review.

The results should be used as a prioritization tool for deeper investigation, not as a causal diagnosis or definitive hospital quality ranking.

## Phase 5 Checkpoint

✅ Completed work:

- Translated Phase 3 analysis into stakeholder-ready findings.
- Interpreted Phase 4 visuals.
- Separated evidence from interpretation.
- Drafted operational review recommendations.
- Documented limitations.
- Clarified what cannot be concluded.
- Preserved review-priority language.

🔒 Decisions locked:

- Findings will use cautious screening language.
- Review-priority candidates are not labeled as poor performers.
- Recommendations are investigation directions, not diagnoses.
- EDV peer benchmarking remains descriptive.
- No causal claims will be made.

⚠️ Limitations and risks:

- Reporting windows are not perfectly synchronized.
- EDV does not fully adjust for hospital complexity.
- Missingness may be non-random.
- Review-priority flags are threshold-based screening indicators.
- OP_22 tied values affect threshold counts.

❓ Unresolved questions:

- Final README wording still needs to be drafted in Phase 6.
- Final project-page copy still needs to be drafted in Phase 6.
- Final interview explanation still needs to be drafted in Phase 6.

➡️ Immediate next action:

Proceed to Phase 6 — Portfolio Packaging.

🛑 Clean stopping point:

Yes. Phase 5 findings, recommendations, and limitations are complete.