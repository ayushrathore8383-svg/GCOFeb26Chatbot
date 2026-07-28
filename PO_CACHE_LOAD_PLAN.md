# PO Cache Load Plan — EBS to ADB
## Goal
Cache EBS PO tables in ADB. Reduce direct EBS traffic. OIC handles daily incremental extract and load.

## Architecture

```
EBS (Source)
    ↓ (OIC DB Adapter - Scheduled)
ADB Cache Tables
    ↓
Applications read from cache
```

## Load Strategy

| Cache Table | EBS Source | PK | Load Type | Frequency |
|---|---|---|---|---|
| PO_HEADERS_ALL | PO_HEADERS_ALL | PO_HEADER_ID | Incremental | Daily |
| PO_LINES_ALL | PO_LINES_ALL | PO_LINE_ID | Incremental | Daily |
| GL_CODE_COMBINATIONS | GL_CODE_COMBINATIONS_ALL | CODE_COMBINATION_ID | Full reload | Daily |
| PO_DISTRIBUTIONS_ALL | PO_DISTRIBUTIONS_ALL | PO_DISTRIBUTION_ID | Incremental | Daily |
| PO_LINE_LOCATIONS_ALL | PO_LINE_LOCATIONS_ALL | LINE_LOCATION_ID | Incremental | Daily |

**Incremental tables**: Use LAST_UPDATE_DATE watermark to fetch only changed rows.  
**Full reload tables**: Small reference tables. Cheaper to truncate-reload daily than compute deltas.

---

## Control Table

Table: `PO_CACHE_LOAD_CONTROL`

Tracks state per cache table:

| Column | Type | Purpose |
|---|---|---|
| TABLE_NAME | VARCHAR2(30) | Cache table name (PK) |
| LOAD_TYPE | VARCHAR2(20) | INCREMENTAL or FULL_RELOAD |
| LAST_EXTRACT_DATE | TIMESTAMP | Last successful watermark (max LAST_UPDATE_DATE from source) |
| LAST_RUN_START | TIMESTAMP | Start time of last load cycle |
| LAST_RUN_END | TIMESTAMP | End time of last load cycle |
| STATUS | VARCHAR2(20) | PENDING, RUNNING, SUCCESS, FAILED |
| ROWS_READ | NUMBER | Rows extracted from EBS |
| ROWS_MERGED | NUMBER | Rows inserted/updated in ADB |
| ERROR_MESSAGE | VARCHAR2(4000) | Error details if status=FAILED |

The `LAST_EXTRACT_DATE` serves as the watermark. Each incremental load:
1. Reads `LAST_EXTRACT_DATE` from control table
2. Extracts WHERE `LAST_UPDATE_DATE > watermark - 1 hour` (1 hour buffer for overlap safety)
3. MERGEs into cache (update if exists, insert if new)
4. Updates `LAST_EXTRACT_DATE` to the max LAST_UPDATE_DATE processed

If load fails, `LAST_EXTRACT_DATE` stays put. Next run retries from same watermark. MERGE is idempotent — safe to rerun.

---

## Initial Load (First Run Only)

Run `po_initial_load.sql` to populate cache tables:

1. Set control status → `RUNNING`
2. Extract all rows from each EBS table
3. Insert into cache tables
4. Set `LAST_EXTRACT_DATE = MAX(LAST_UPDATE_DATE)` from each table
5. Set status → `SUCCESS`

Handles errors gracefully: if any step fails, all controls are set to `FAILED` with error message logged.

---

## Incremental Load (Daily)

Procedure: `PO_INCREMENTAL_LOAD()` (in `po_incremental_load.sql`)

**For each table (except GL_CODE_COMBINATIONS):**

1. Read watermark from control table
2. Set status → `RUNNING`
3. Extract from EBS: `WHERE LAST_UPDATE_DATE > watermark - 1 hour`
4. MERGE into ADB cache:
   - **MATCHED**: Update all columns
   - **NOT MATCHED**: Insert new row
5. Calculate new watermark: `MAX(LAST_UPDATE_DATE)` from extracted rows
6. Update control: `LAST_EXTRACT_DATE`, `STATUS=SUCCESS`, `ROWS_MERGED`
7. On error: `STATUS=FAILED`, log error message

**For GL_CODE_COMBINATIONS (full reload):**

1. Set status → `RUNNING`
2. DELETE all rows
3. INSERT all rows from EBS
4. Set status → `SUCCESS`

Each table in its own exception block — if one fails, others continue.

---

## OIC Integration Setup

### Create OIC Integration: PO_INCREMENTAL_LOAD

**Trigger**: Scheduled, daily at 02:00 UTC (or suitable time outside peak hours)

**Activities**:

1. **Invoke ADB Procedure**
   - Connection: ADB_CACHE
   - SQL: `BEGIN PO_INCREMENTAL_LOAD(); END;`
   - Map stored procedure output to response

2. **Query PO_CACHE_LOAD_CONTROL**
   - Verify all tables have `STATUS=SUCCESS`
   - If any `STATUS=FAILED`, send alert email to DBA

3. **Error Handling**
   - Catch exceptions from procedure
   - Log to OIC monitoring
   - Send Slack/email notification to on-call

**Schedule**: Daily, 02:00 UTC

---

## First-Run Checklist

1. ✅ Create cache tables: `sqlplus @po_cache_tables.sql`
2. ✅ Create control table: `sqlplus @po_cache_control_table.sql`
3. ✅ Create incremental procedure: `sqlplus @po_incremental_load.sql`
4. ✅ Run initial load: `sqlplus @po_initial_load.sql`
5. ✅ Verify row counts: `SELECT * FROM PO_CACHE_LOAD_CONTROL;`
6. ✅ Create OIC scheduled integration pointing to `PO_INCREMENTAL_LOAD()`
7. ✅ Test OIC integration manually (trigger run, watch control table)
8. ✅ Enable schedule

---

## Operational Procedures

### Monitor Load Status
```sql
SELECT TABLE_NAME, STATUS, LAST_EXTRACT_DATE, ROWS_MERGED, ERROR_MESSAGE
FROM PO_CACHE_LOAD_CONTROL
ORDER BY LAST_RUN_END DESC;
```

### Force Reload of a Single Table
If a table corrupts or needs restart:
```sql
-- Reset watermark
UPDATE PO_CACHE_LOAD_CONTROL
SET LAST_EXTRACT_DATE = NULL,
    STATUS = 'PENDING',
    ERROR_MESSAGE = NULL
WHERE TABLE_NAME = 'PO_HEADERS_ALL';

-- Next OIC run will reload from day 1
```

### Manual Incremental Run
```sql
EXEC PO_INCREMENTAL_LOAD();
```

### Check for Stale Watermarks
If loads are blocked (e.g., extraction hangs):
```sql
SELECT TABLE_NAME, LAST_RUN_START, LAST_RUN_END, STATUS
FROM PO_CACHE_LOAD_CONTROL
WHERE STATUS = 'RUNNING' AND LAST_RUN_START < SYSDATE - 2/24; -- >2 hours old
```

---

## Performance Tuning

1. **Index on LAST_UPDATE_DATE**: Already created on all cache tables and EBS staging. Ensures incremental queries scan efficiently.

2. **Parallel MERGE**: If tables >100M rows, consider:
   ```sql
   ALTER SESSION SET PARALLEL_EXECUTION_ENABLED=TRUE;
   ALTER SESSION SET PARALLEL_DML_MODE=FORCE;
   ```

3. **Partition Strategy**: For very large tables (PO_LINES_ALL >10M rows), consider range partitioning by PO_HEADER_ID + monthly interval to speed archive/truncate operations.

4. **1-Hour Overlap Buffer**: Catches clock skew + late-arriving updates. Adjust if needed:
   - Reduce to 30 min for tighter consistency
   - Increase to 2 hours if EBS has high clock skew

---

## Error Handling & Retry Logic

**Status-Driven Retry:**

1. Load runs daily at 02:00 UTC
2. If status=`FAILED`, `LAST_EXTRACT_DATE` unchanged
3. Next day's load retries from same watermark (overlaps with prior run, but MERGE is idempotent)
4. Once `FAILED` cleared, watermark advances

**Alerts (OIC Integration):**

- If any table status=`FAILED` after 3 consecutive runs, escalate to DBA
- Email OIC Integration activity log to on-call oncall email (DBA)
- Check error_message column in PO_CACHE_LOAD_CONTROL for details

**Manual Intervention:**

- Review error_message in control table
- Check ADB space/locks (common causes: tablespace full, lock timeout)
- Check EBS connectivity (network issues, EBS maintenance)
- Reset status to PENDING + retry

---

## Risks & Mitigations

| Risk | Mitigation |
|---|---|
| **Watermark skew** (EBS server clock incorrect) | 1-hour overlap buffer catches drift. Monitor system clock drift. |
| **Merge performance** (large extracts) | Index on LAST_UPDATE_DATE. Parallel execution. Partition if >10M rows. |
| **Data freshness SLA** | Daily 02:00 UTC load. Cache is 0-24h stale. Adjust schedule if stricter SLA needed. |
| **Rerun safety** | MERGE is idempotent. Safe to rerun same cycle. No duplication risk. |
| **Referential integrity** | Load order: GL_CODE_COMBINATIONS → Headers → Lines → Distributions → Line Locations. Foreign keys disabled during load, checked post-load. |

---

## References

- EBS PO Module Documentation: [EBS Docs]
- ADB Autonomous Database: [Oracle Docs]
- OIC Scheduled Integration: [OIC Docs]
- MERGE Syntax: Oracle SQL Reference

---

## Change Log

| Date | Change | Owner |
|---|---|---|
| 2026-07-28 | Initial design: 5-table PO cache with watermark-based incremental load | Ayush Rathore |
