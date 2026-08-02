# SQL Python DAX Spellbook

## Project

Healthcare Operations Analytics — ED Throughput Benchmarking

## Current Status

Phase 2 is complete.

This spellbook records reusable SQL and Python patterns used or planned in the project.

DAX is not required for the current mini project, but a placeholder section is included for future dashboard work.

---

# SQL Spellbook

## 1. Row Count

Purpose:
Count all rows in a table.

```sql
SELECT
    COUNT(*) AS row_count
FROM table_name;