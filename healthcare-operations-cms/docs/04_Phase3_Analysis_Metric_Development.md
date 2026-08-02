# Phase 3 — Analysis and Metric Development

## Current Status

Phase 3 is complete.

The SQL-validated analytical mart was loaded into Python, profiled, benchmarked by ED-volume peer category, and used to create review-priority flags for operational screening.

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

Phase 3 converts the validated SQL mart into analytical evidence.

This phase answers:

- What does the analytical population look like?
- How much usable data exists for each core measure?
- How do OP_18b and OP_22 vary by ED-volume peer category?
- Which hospitals appear elevated relative to EDV-tier peer benchmarks?
- Which hospitals should be considered review-priority candidates for further operational review?

## Why This Phase Matters

Phase 2 confirmed that the data structure was reliable.

Phase 3 determines whether the staged data can support useful analysis for stakeholders.

The main risk in this phase is overclaiming. The analysis supports descriptive screening and benchmarking, not causal diagnosis or definitive hospital ranking.

## Input File

Phase 3 used the SQL-validated analytical mart exported from Phase 2:

`data/processed/healthcare_ed_throughput_mart.csv`

This file contains:

- 4,660 hospital records
- 22 columns
- one row per hospital
- preserved facility IDs as text
- EDV category
- OP_18b numeric outcome
- OP_22 numeric outcome
- availability statuses
- footnotes
- reporting dates

## Python Notebooks

Phase 3 work was completed across Day 2 notebooks:

- `02_healthcare_ops_analysis.ipynb`
- `03_healthcare_peer_benchmarking.ipynb`

## Core Measures

### EDV — Emergency Department Volume

Role:

- Peer-group category

Use:

- Used to group hospitals into ED-volume peer categories.

Important rule:

- EDV is categorical.
- EDV is not a numeric performance metric.

### OP_18b — Median ED Arrival-to-Departure Time

Role:

- Numeric ED throughput outcome

Unit:

- Minutes

Direction:

- Lower is better

Use:

- Measures median time patients spent in the ED before leaving from the visit for discharged patients.

### OP_22 — Left Without Being Seen

Role:

- Numeric ED access / throughput outcome

Unit:

- Percent

Direction:

- Lower is better

Use:

- Measures percentage of patients who left before being seen.

## Analytical Questions

Phase 3 addressed the following analytical questions:

1. How many hospitals are available for each core measure?
2. How many hospitals have complete data for EDV, OP_18b, and OP_22?
3. How are hospitals distributed across EDV peer categories?
4. What are the overall distributions of OP_18b and OP_22?
5. How do OP_18b and OP_22 differ by EDV tier?
6. What are the EDV-tier median, 75th percentile, and 90th percentile benchmarks?
7. Which hospitals exceed EDV-tier 90th percentile thresholds for OP_18b and/or OP_22?
8. Which hospitals are review-priority candidates?

## Python Input Validation

The analytical mart was loaded successfully.

Validation results:

- Row count: 4,660
- Unique facilities: 4,660
- Facility ID preserved as text
- Example preserved IDs:
  - 010001
  - 010005
  - 010006

## Missingness Profile

Core fields checked:

- `ed_volume_category`
- `op_18b_median_wait_min`
- `op_22_lwbs_pct`

Missingness results:

| Field | Missing Count | Available Count | Missing Percent |
|---|---:|---:|---:|
| ed_volume_category | 823 | 3,837 | 17.7% |
| op_18b_median_wait_min | 583 | 4,077 | 12.5% |
| op_22_lwbs_pct | 828 | 3,832 | 17.8% |

Complete-case population for EDV + OP_18b + OP_22:

- 3,777 hospitals
- 81.1% of the analytical mart

## Population Decision

Measure-specific profiling can use each measure’s valid population:

- EDV profiling: 3,837 hospitals with known EDV category
- OP_18b profiling: 4,077 hospitals with available OP_18b
- OP_22 profiling: 3,832 hospitals with available OP_22

EDV peer benchmarking requires complete cases:

- EDV available
- OP_18b available
- OP_22 available

Benchmarking population:

- 3,777 hospitals

Rationale:

Peer benchmarking requires all three fields because hospitals are compared within EDV categories across both throughput outcomes.

## EDV Distribution

EDV distribution including missing values:

| EDV Category | Hospital Count | Percent of Total |
|---|---:|---:|
| low | 1,666 | 35.8% |
| medium | 915 | 19.6% |
| Not Available | 823 | 17.7% |
| very high | 704 | 15.1% |
| high | 552 | 11.8% |

EDV distribution excluding missing values:

| EDV Category | Hospital Count | Percent of Valid EDV |
|---|---:|---:|
| low | 1,666 | 43.4% |
| medium | 915 | 23.8% |
| very high | 704 | 18.3% |
| high | 552 | 14.4% |

## EDV Peer-Group Adequacy

EDV peer groups were considered large enough for descriptive benchmarking because each valid EDV category contained hundreds of hospitals.

Smallest valid EDV group:

- high: 552 hospitals

Practical interpretation:

EDV peer groups are large enough for descriptive median and percentile benchmarking.

Important limitation:

Large peer-group size does not mean hospitals are fully comparable. EDV does not adjust for trauma level, staffing, ED bed capacity, patient acuity, inpatient boarding pressure, or local demand shocks.

## Overall Outcome Distributions

### OP_18b — Median ED Arrival-to-Departure Time

Summary:

| Statistic | Value |
|---|---:|
| Count | 4,077 |
| Mean | 157.1 |
| Standard deviation | 51.3 |
| Minimum | 42 |
| 25th percentile | 119 |
| Median | 148 |
| 75th percentile | 188 |
| 90th percentile | 225 |
| 95th percentile | 250 |
| Maximum | 464 |

Interpretation:

Median ED arrival-to-departure time across available hospitals was 148 minutes. The upper tail was substantial, with the 90th percentile at 225 minutes and the maximum at 464 minutes.

### OP_22 — Left Without Being Seen

Summary:

| Statistic | Value |
|---|---:|
| Count | 3,832 |
| Mean | 1.7 |
| Standard deviation | 1.8 |
| Minimum | 0 |
| 25th percentile | 1 |
| Median | 1 |
| 75th percentile | 2 |
| 90th percentile | 4 |
| 95th percentile | 5 |
| Maximum | 23 |

Interpretation:

LWBS percentages were generally low, with a median of 1%. However, upper-tail values reached 4% at the 90th percentile and 5% at the 95th percentile.

## EDV-Tier Outcome Summary

Outcome summary by EDV tier:

| EDV Category | Hospital Count | OP_18b Available | OP_18b Median | OP_18b P75 | OP_18b P90 | OP_22 Available | OP_22 Median | OP_22 P75 | OP_22 P90 |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| high | 552 | 551 | 190.0 | 219.0 | 252.0 | 552 | 2.0 | 3.0 | 4.9 |
| low | 1,666 | 1,612 | 120.0 | 140.0 | 162.9 | 1,661 | 1.0 | 1.0 | 3.0 |
| medium | 915 | 911 | 168.0 | 194.0 | 218.0 | 915 | 2.0 | 3.0 | 4.0 |
| very high | 704 | 703 | 194.0 | 231.0 | 271.6 | 704 | 2.0 | 3.0 | 5.0 |

Interpretation:

OP_18b median wait time generally increased across ED-volume categories:

- low: 120 minutes
- medium: 168 minutes
- high: 190 minutes
- very high: 194 minutes

High and very-high categories were close at the median, but very-high EDs showed the highest upper-tail wait-time values.

OP_22 medians were lower overall and showed less variation than OP_18b, but upper-tail LWBS values were higher in medium, high, and very-high EDV categories than in low EDV hospitals.

## Benchmarking Population

For EDV peer benchmarking, the analysis used complete cases only.

Benchmarking population:

- 3,777 hospitals
- 3,777 unique facilities

Complete-case criteria:

- EDV category is available
- OP_18b is available
- OP_22 is available

## EDV-Tier Peer Benchmark Table

Final EDV-tier benchmark summary:

| EDV Category | Hospital Count | OP_18b Median | OP_18b P75 | OP_18b P90 | OP_22 Median | OP_22 P75 | OP_22 P90 |
|---|---:|---:|---:|---:|---:|---:|---:|
| high | 551 | 190.0 | 219.0 | 252.0 | 2.0 | 3.0 | 5.0 |
| low | 1,612 | 120.0 | 140.0 | 162.9 | 1.0 | 1.0 | 3.0 |
| medium | 911 | 168.0 | 194.0 | 218.0 | 2.0 | 3.0 | 4.0 |
| very high | 703 | 194.0 | 231.0 | 271.6 | 2.0 | 3.0 | 5.0 |

The benchmark counts sum to 3,777 hospitals.

## Peer Benchmark Fields Created

The following hospital-level peer benchmark fields were created:

- `op_18b_peer_median`
- `op_18b_peer_p75`
- `op_18b_peer_p90`
- `op_18b_variance_from_peer_median`
- `op_22_peer_median`
- `op_22_peer_p75`
- `op_22_peer_p90`
- `op_22_variance_from_peer_median`

Variance logic:

`hospital value - EDV-tier peer median`

Interpretation:

- Positive variance means the hospital is above the EDV-tier peer median.
- Negative variance means the hospital is below the EDV-tier peer median.

## Peer Benchmark Validation

Peer benchmark fields were validated by comparing assigned hospital-level peer medians to actual EDV-tier medians.

Validation results:

| EDV Category | Hospital Count | Assigned OP_18b Peer Median | Actual OP_18b Median | Assigned OP_22 Peer Median | Actual OP_22 Median | OP_18b Median Match | OP_22 Median Match |
|---|---:|---:|---:|---:|---:|---|---|
| high | 551 | 190.0 | 190.0 | 2.0 | 2.0 | True | True |
| low | 1,612 | 120.0 | 120.0 | 1.0 | 1.0 | True | True |
| medium | 911 | 168.0 | 168.0 | 2.0 | 2.0 | True | True |
| very high | 703 | 194.0 | 194.0 | 2.0 | 2.0 | True | True |

Conclusion:

Peer benchmark fields were assigned correctly.

## Review-Priority Flag Logic

Review-priority flags were created using EDV-tier 90th percentile thresholds.

A hospital was flagged if it was at or above the EDV-tier 90th percentile for:

- OP_18b median ED arrival-to-departure time, or
- OP_22 left-without-being-seen percentage

Fields created:

- `op_18b_high_wait_flag`
- `op_22_high_lwbs_flag`
- `review_priority_flag`
- `review_priority_type`
- `priority_rank`

Priority type categories:

- Both indicators high
- High wait only
- High LWBS only

Priority rank:

1. Both indicators high
2. High wait only
3. High LWBS only

## Review-Priority Results

Benchmark population:

- 3,777 hospitals

Flag summary:

| Metric | Count | Percent of Benchmark Population |
|---|---:|---:|
| High OP_18b wait | 386 | 10.2% |
| High OP_22 LWBS | 437 | 11.6% |
| Any review-priority flag | 678 | 18.0% |

Overlap summary:

| Review-Priority Type | Count | Percent of Benchmark Population |
|---|---:|---:|
| High wait only | 241 | 6.4% |
| High LWBS only | 292 | 7.7% |
| Both indicators high | 145 | 3.8% |
| Any review priority | 678 | 18.0% |

Interpretation:

Using EDV-tier 90th percentile thresholds, 678 of 3,777 benchmark-eligible hospitals were flagged for potential operational review.

Among those, 145 hospitals were elevated on both indicators and represent the strongest review-priority subset.

The total review-priority percentage is higher than 10% because the logic uses an OR condition across two indicators. OP_22 also has tied whole-number values around percentile thresholds, which can produce more than exactly 10% flagged at the 90th percentile.

## Outputs Exported

The following Phase 3 outputs were exported to `data/processed/`:

- `healthcare_ed_peer_benchmark_summary.csv`
- `healthcare_ed_benchmark_analysis_table.csv`
- `healthcare_ed_review_priority_table.csv`

Expected row counts:

- `healthcare_ed_peer_benchmark_summary.csv`: 4 rows
- `healthcare_ed_benchmark_analysis_table.csv`: 3,777 rows
- `healthcare_ed_review_priority_table.csv`: 678 rows

## What the Data Shows

The data shows:

1. The analytical mart contains 4,660 hospitals with target ED-measure records.
2. The complete-case EDV benchmarking population contains 3,777 hospitals.
3. OP_18b median ED time generally increases across EDV categories.
4. OP_22 values are generally low but have meaningful upper-tail variation.
5. Using EDV-tier 90th percentile thresholds, 678 hospitals are flagged for review.
6. Of the flagged hospitals, 145 are elevated on both OP_18b and OP_22.

## What the Data Suggests

The data suggests:

1. ED-volume category is a useful peer-grouping variable for descriptive screening.
2. Higher EDV categories tend to have longer OP_18b wait-time distributions.
3. Some hospitals show elevated values on both throughput indicators relative to EDV-tier peers.
4. Review-priority groups can help stakeholders distinguish broad throughput concerns from measure-specific review needs.

## What Cannot Be Concluded

The data cannot conclude:

1. That ED volume causes longer wait times.
2. That longer wait times caused patients to leave before being seen.
3. That flagged hospitals are poorly managed.
4. That review-priority hospitals are definitively worse hospitals.
5. That EDV fully adjusts for hospital complexity.
6. That results explain trauma level, staffing, capacity, boarding pressure, patient acuity, or local demand effects.

## Decisions Locked in Phase 3

1. Python analysis uses the SQL-validated mart as input.
2. EDV peer benchmarking uses complete cases only.
3. EDV categories are large enough for descriptive peer benchmarking.
4. Benchmarking uses EDV-tier medians, 75th percentiles, and 90th percentiles.
5. Review-priority flags use EDV-tier 90th percentile thresholds.
6. OP_18b and OP_22 remain separate metrics.
7. No composite score is used.
8. Review-priority results are screening indicators, not definitive rankings.

## Limitations and Risks

- EDV and OP_22 use calendar year 2024.
- OP_18b uses July 2024 to June 2025.
- OP_18b and OP_22 should not be interpreted as perfectly time-aligned.
- EDV does not adjust for trauma level, staffing, bed capacity, patient acuity, boarding pressure, or local demand shocks.
- Missingness may reflect CMS reporting or suppression conditions.
- Review-priority flags identify candidates for review, not causes.
- OP_22 tied values can make percentile-based flags include more than exactly 10% of hospitals.

## Phase 3 Checkpoint

✅ Completed work:

- Loaded the SQL-validated analytical mart into Python.
- Validated row count and unique facility count.
- Confirmed facility_id preservation.
- Profiled missingness.
- Confirmed complete-case population.
- Profiled EDV distribution.
- Profiled OP_18b and OP_22 overall distributions.
- Profiled OP_18b and OP_22 by EDV tier.
- Created EDV-tier peer benchmark table.
- Assigned hospital-level peer benchmark fields.
- Validated peer median fields.
- Created review-priority flags.
- Created review-priority candidate table.
- Exported Phase 3 benchmark outputs.

🔒 Decisions locked:

- Benchmarking uses complete cases.
- EDV is the peer category.
- Medians and upper percentiles are the benchmark statistics.
- Review-priority flags use EDV-tier p90 thresholds.
- OP_18b and OP_22 remain separate.
- No composite score is used.
- Review-priority language must remain cautious.

⚠️ Limitations and risks:

- Reporting windows are not perfectly synchronized.
- EDV is not a complete adjustment variable.
- Missingness may be non-random.
- Percentile flags are screening tools, not diagnoses.
- OP_22 ties affect threshold counts.

❓ Unresolved questions:

- Final written findings will be drafted in Phase 5.
- Final visual selection and captions will be documented in Phase 4.
- Footnote decoding may be expanded only if needed for interpretation.

➡️ Immediate next action:

Proceed to Phase 4 — Visualization and Dashboarding documentation.

🛑 Clean stopping point:

Yes. Phase 3 analysis and metric development are complete.