# Phase 1 — Data Acquisition and Feasibility

## Current Status

Phase 1 is complete.

The CMS source files were acquired, stored in the project raw data folder, reviewed for relevance, and confirmed as feasible for the Healthcare Operations Analytics mini project.

## Project

Healthcare Operations Analytics — ED Throughput Benchmarking

## Business Context

This project analyzes hospital emergency-department throughput using CMS public hospital data.

The project focuses on identifying hospitals with unusually weak ED throughput indicators relative to available ED-volume peer categories. The analysis is designed as an operational screening project, not a causal diagnosis of hospital performance.

## Stakeholder and Decision Question

Primary stakeholder:
Health-system Operations / Quality Improvement Analyst

Secondary stakeholders:
Hospital Operations Director, Emergency Department Manager, Quality Improvement Team

Decision question:
Which hospitals show unusually weak emergency-department throughput indicators relative to available ED-volume peer categories and should receive further operational review?

## Authoritative Source

Source:
Centers for Medicare & Medicaid Services CMS Care Compare / Provider Data Catalog hospital downloadable database files.

Files used:

- Hospital_General_Information.csv
- Timely_and_Effective_Care-Hospital.csv
- HOSPITAL_Data_Dictionary.pdf

Raw files are stored in:

data/raw/

## Source Documentation

The CMS data dictionary was retained as the source documentation file:

HOSPITAL_Data_Dictionary.pdf

The data dictionary supports interpretation of:

- hospital general information fields
- Timely and Effective Care measures
- measure IDs
- reporting windows
- file structure
- public reporting context
- footnotes and missingness interpretation

## Field Availability

The source files contain the required fields for the planned analysis.

Hospital_General_Information.csv provides hospital metadata, including:

- Facility ID
- Facility Name
- City/Town
- State
- Hospital Type
- Hospital Ownership
- Emergency Services

Timely_and_Effective_Care-Hospital.csv provides measure-level records, including:

- Facility ID
- Facility Name
- Measure ID
- Measure Name
- Score
- Sample
- Footnote
- Start Date
- End Date

## Core Measures

The project uses three ED-related CMS measures:

- EDV — Emergency department volume
- OP_18b — Median ED arrival-to-departure time for discharged patients
- OP_22 — Left before being seen

## Confirmed Reporting Windows

The target measure windows are:

- EDV: 01/01/2024 to 12/31/2024
- OP_22: 01/01/2024 to 12/31/2024
- OP_18b: 07/01/2024 to 06/30/2025

## Source Grain

Expected source grain:

Hospital_General_Information.csv:
One row per Facility ID

Timely_and_Effective_Care-Hospital.csv:
One row per Facility ID × Measure ID

Planned analytical layer:
One row per hospital after filtering to EDV, OP_18b, and OP_22, then pivoting measure rows into columns.

## Joinability

The planned join key is:

Facility ID

Facility ID must be treated as text because leading zeroes are meaningful.

Expected join:

Timely_and_Effective_Care-Hospital.csv
joined to
Hospital_General_Information.csv

on Facility ID.

## Missing Variables

The CMS files do not fully provide operational drivers or adjustment variables such as:

- trauma level
- staffing levels
- ED bed capacity
- inpatient boarding pressure
- patient acuity
- local demand shocks
- real-time wait times
- shift-level operational data
- facility-specific process constraints

These missing variables limit the analysis to screening and benchmarking, not causal diagnosis.

## Feasibility Assessment

The project is feasible because:

- CMS is an authoritative public data source.
- Required ED measures are available.
- Hospital metadata is available.
- Facility ID provides a usable join key.
- The three target measures support a compact mini-project scope.
- The planned analysis can be completed through SQL staging, QA, Python profiling, peer benchmarking, and concise portfolio reporting.

## Proceed / Narrow / Reject Decision

Decision:
Proceed.

Rationale:
The available CMS files support a defensible two-day mini project focused on ED throughput benchmarking by ED-volume peer category.

Scope is narrowed to:

- EDV
- OP_18b
- OP_22
- hospital metadata needed for context
- ED-volume peer benchmarking
- operational review prioritization

Rejected expansions:

- causal modeling
- trauma-level adjustment
- hospital ranking platform
- full healthcare policy analysis
- composite performance score
- advanced predictive modeling

## Assumptions

- Facility ID is stable and usable as the join key.
- EDV can be used as a peer-group category.
- OP_18b and OP_22 are lower-is-better operational indicators.
- Not Available values require preservation and documentation.
- Reporting-window mismatch must be disclosed.
- Available peer categories do not fully adjust for hospital complexity.

## Risks and Limitations

- EDV and OP_22 use calendar year 2024, while OP_18b uses July 2024 to June 2025.
- Not Available values may reflect reporting, suppression, eligibility, or sample-size conditions.
- EDV volume tiers do not fully adjust for trauma level, capacity, staffing, or patient acuity.
- The project can identify hospitals for further review but cannot conclude operational causes.
- Results should not be framed as a definitive ranking of hospital quality.

## Immediate Next Action

Begin Phase 2: Data Understanding, SQL Staging and Quality Checks.

Phase 2 should:

- load raw files into SQLite
- preserve Facility ID as text
- confirm source grain
- check duplicates
- validate target measure coverage
- verify reporting windows
- inspect score availability
- preserve footnotes
- create a typed staging view
- create a one-row-per-hospital analytical mart