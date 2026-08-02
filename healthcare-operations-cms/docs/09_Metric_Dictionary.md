# Metric Dictionary

## Project

Healthcare Operations Analytics — ED Throughput Benchmarking

## Current Status

Phase 2 is complete.

This metric dictionary defines the core fields, measures, derived fields, and interpretation rules used in the project.

---

## Source Identifier Fields

### facility_id

Definition:
CMS hospital Facility ID.

Source:
Hospital_General_Information.csv and Timely_and_Effective_Care-Hospital.csv

Type:
Text

Use:
Primary join key and hospital identifier.

Important rule:
Preserve as text to retain leading zeroes.

Example:
010001

---

### facility_name

Definition:
Hospital name.

Source:
Hospital_General_Information.csv

Type:
Text

Use:
Display and stakeholder interpretation.

Caution:
Use facility_id as the key, not facility_name.

---

### city_town

Definition:
Hospital city or town.

Source:
Hospital_General_Information.csv

Type:
Text

Use:
Contextual geography.

Caution:
Do not use as a full geographic adjustment variable.

---

### state

Definition:
Hospital state abbreviation.

Source:
Hospital_General_Information.csv

Type:
Text

Use:
Contextual geography and optional grouping.

Caution:
State does not adjust for hospital complexity, staffing, patient acuity, or capacity.

---

### hospital_type

Definition:
CMS hospital type classification.

Source:
Hospital_General_Information.csv

Type:
Text

Use:
Contextual hospital category.

Caution:
Use only where defensible. Hospital type does not fully adjust for trauma level, acuity, staffing, capacity, or operational constraints.

---

### hospital_ownership

Definition:
CMS hospital ownership classification.

Source:
Hospital_General_Information.csv

Type:
Text

Use:
Contextual descriptor.

Caution:
Do not imply ownership causes throughput differences without further analysis.

---

### emergency_services

Definition:
Indicator showing whether the hospital provides emergency services.

Source:
Hospital_General_Information.csv

Type:
Text

Expected values:
Yes / No

Use:
Contextual filter or validation field.

---

## Core CMS Measures

### EDV — Emergency Department Volume

Measure ID:
EDV

Definition:
Emergency department volume category.

Source:
Timely_and_Effective_Care-Hospital.csv

Type:
Categorical

Role in project:
Primary peer-group field.

Expected values:

- low
- medium
- high
- very high
- Not Available

Available category counts from Phase 2 QA:

- low: 1,666
- medium: 915
- high: 552
- very high: 704
- Not Available: 823

Interpretation:
EDV groups hospitals by emergency department volume category.

Use:
Benchmark OP_18b and OP_22 within EDV peer tiers.

Do not use:
Do not treat EDV as a numeric performance metric. Do not calculate average EDV.

---

### OP_18b — Median ED Arrival-to-Departure Time

Measure ID:
OP_18b

Definition:
Median time patients spent in the emergency department before leaving from the visit for discharged patients.

Project field:
op_18b_median_wait_min

Source:
Timely_and_Effective_Care-Hospital.csv

Type:
Numeric after safe staging conversion.

Unit:
Minutes.

Direction:
Lower is better.

Phase 2 availability:

- Total rows: 4,660
- Available numeric values: 4,077
- Not Available: 583

Use:
Core ED throughput outcome.

Interpretation:
Higher values indicate longer median ED arrival-to-departure time for discharged patients.

Caution:
This measure alone does not explain why waits are longer. It does not adjust for trauma level, acuity, staffing, boarding pressure, or capacity.

---

### OP_22 — Left Before Being Seen

Measure ID:
OP_22

Definition:
Percentage of patients who left the emergency department before being seen.

Project field:
op_22_lwbs_pct

Source:
Timely_and_Effective_Care-Hospital.csv

Type:
Numeric after safe staging conversion.

Unit:
Percent.

Direction:
Lower is better.

Phase 2 availability:

- Total rows: 4,660
- Available numeric values: 3,832
- Not Available: 828

Use:
Core ED access / throughput indicator.

Interpretation:
Higher values indicate a larger percentage of patients left before being seen.

Caution:
Do not claim OP_18b caused OP_22. Their reporting windows differ, and both may reflect broader operational context.

---

## Staging Fields

### score_raw

Definition:
Original CMS score value before type conversion.

Source:
raw_timely_effective_care.score

Type:
Text

Use:
Auditability and missingness preservation.

Examples:

- very high
- low
- 217
- 3
- Not Available

---

### availability_status

Definition:
Derived availability label from raw score.

Source logic:

- If score = Not Available, then Not Available
- If score is null or blank, then Missing
- Otherwise Available

Type:
Text

Expected values:

- Available
- Not Available
- Missing

Use:
Missingness tracking and measure-specific valid population counts.

---

### score_numeric

Definition:
Numeric version of score for OP_18b and OP_22 only.

Type:
Real / numeric

Logic:
If measure_id is OP_18b or OP_22 and score is available, cast score to numeric.
Otherwise null.

Use:
Python profiling, benchmarking, and visual analysis.

---

### score_category

Definition:
Categorical version of score for EDV only.

Type:
Text

Logic:
If measure_id is EDV and score is available, keep the score text.
Otherwise null.

Use:
ED-volume peer grouping.

---

## Analytical Mart Fields

### ed_volume_category

Definition:
Hospital ED volume category derived from EDV.

Source:
stg_ed_measures.score_category where measure_id = EDV

Type:
Categorical

Use:
Primary peer-group field.

Caution:
Hospitals with missing EDV cannot be included in EDV-tier benchmarking.

---

### op_18b_median_wait_min

Definition:
Numeric OP_18b value for each hospital.

Source:
stg_ed_measures.score_numeric where measure_id = OP_18b

Type:
Numeric

Unit:
Minutes

Use:
Main ED wait-time outcome.

---

### op_22_lwbs_pct

Definition:
Numeric OP_22 value for each hospital.

Source:
stg_ed_measures.score_numeric where measure_id = OP_22

Type:
Numeric

Unit:
Percent

Use:
Main left-without-being-seen outcome.

---

### edv_availability_status

Definition:
Availability status for EDV.

Use:
Track whether EDV category is usable for peer benchmarking.

---

### op_18b_availability_status

Definition:
Availability status for OP_18b.

Use:
Track whether OP_18b is usable for analysis.

---

### op_22_availability_status

Definition:
Availability status for OP_22.

Use:
Track whether OP_22 is usable for analysis.

---

### edv_footnote

Definition:
CMS footnote associated with EDV value.

Use:
Missingness and interpretation review.

---

### op_18b_footnote

Definition:
CMS footnote associated with OP_18b value.

Use:
Missingness and interpretation review.

---

### op_22_footnote

Definition:
CMS footnote associated with OP_22 value.

Use:
Missingness and interpretation review.

---

## Planned Phase 3 Benchmark Fields

These fields will be created during Day 2 Python analysis.

### op_18b_edv_peer_median

Definition:
Median OP_18b value within the hospital’s EDV category.

Use:
Peer benchmark.

---

### op_18b_variance_from_peer_median

Definition:
Hospital OP_18b minus EDV-tier median OP_18b.

Formula:
op_18b_median_wait_min - op_18b_edv_peer_median

Interpretation:
Positive values indicate longer median ED time than the EDV-tier median.

---

### op_22_edv_peer_median

Definition:
Median OP_22 value within the hospital’s EDV category.

Use:
Peer benchmark.

---

### op_22_variance_from_peer_median

Definition:
Hospital OP_22 minus EDV-tier median OP_22.

Formula:
op_22_lwbs_pct - op_22_edv_peer_median

Interpretation:
Positive values indicate higher left-without-being-seen percentage than the EDV-tier median.

---

### review_priority_flag

Definition:
Potential Day 2 flag identifying hospitals with elevated ED throughput indicators relative to EDV-tier peers.

Possible logic:
Hospital is above a selected percentile threshold for OP_18b and/or OP_22 within its EDV category.

Status:
Not yet finalized.

Caution:
This flag should identify candidates for operational review, not poor performers.

---

## Interpretation Rules

Supported language:

- elevated relative to ED-volume peers
- may warrant operational review
- review-priority candidate
- throughput indicator requiring further investigation

Avoid:

- bad hospital
- inefficient hospital
- poor management
- caused patients to leave
- definitive hospital ranking

## Major Limitations

- EDV and OP_22 use calendar year 2024.
- OP_18b uses July 2024 to June 2025.
- EDV peer groups do not fully adjust for trauma level, staffing, capacity, boarding pressure, patient acuity, or local demand shocks.
- Missingness may reflect CMS reporting or suppression conditions.
- The project can support screening but not causal diagnosis.