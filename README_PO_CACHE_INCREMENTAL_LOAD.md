# PO Cache Incremental Load - Complete Implementation

## Overview

Incremental load of 5 PO tables from Oracle EBS to Autonomous Database (ADB) using OIC scheduled integration. Uses watermark-based delta logic (LAST_UPDATE_DATE) for daily syncs with zero downtime.

**All logic implemented in OIC integration**—no stored procedures.

---

## Deliverables

### SQL Scripts

| File | Purpose | Run Order |
|------|---------|-----------|
| **po_cache_tables.sql** | Create 5 cache tables + indexes | 1st |
| **po_cache_control_table.sql** | Create control table + init rows | 2nd |
| **po_initial_load.sql** | First-run bulk extract from EBS | 3rd (once only) |

### OIC Integration Documentation

| File | Purpose |
|------|---------|
| **OIC_INCREMENTAL_LOAD_FULL.md** | **← Start here** Complete setup guide: 14 activities, all SQL templates, variables, error handling |
| **PO_CACHE_LOAD_PLAN.md** | Design document: architecture, watermark logic, operational procedures, monitoring |
| **OIC_INTEGRATION_CONFIG.md** | Legacy guide (uses stored procedure—skip this) |
| **OIC_SETUP_STEPS.md** | Legacy guide (uses stored procedure—skip this) |

### Legacy Files (Ignore)

These files show the stored-procedure approach (you don't need them):
- `po_incremental_load.sql` — (Skip—you're doing this in OIC instead)
- `OIC_PO_INCREMENTAL_LOAD_INTEGRATION.xml` — (Skip—reference only)

---

## Quick Start (3 Hours)

### Phase 1: Database Setup (30 min)

```bash
# In ADB SQL interface (or sqlplus)
@po_cache_tables.sql
@po_cache_control_table.sql
@po_initial_load.sql
```

Verify:
```sql
SELECT * FROM PO_CACHE_LOAD_CONTROL;
-- Should show 5 rows, STATUS=SUCCESS, ROWS_MERGED > 0
```

### Phase 2: OIC Integration (1.5 hours)

Follow **OIC_INCREMENTAL_LOAD_FULL.md** step-by-step:

1. Create scheduled integration (name: `PO_Cache_Incremental_Load_Inline`)
2. Add variables (14 variables tracking watermarks, error flags)
3. Add 14 activities:
   - Read_All_Watermarks
   - Set_Status_Running
   - Merge_PO_Headers + Update_PO_Headers_Watermark
   - Merge_PO_Lines + Update_PO_Lines_Watermark
   - Reload_GL_Code_Combinations
   - Merge_PO_Distributions + Update_PO_Distributions_Watermark
   - Merge_PO_Line_Locations + Update_PO_Line_Locations_Watermark
   - Query_Final_Status
   - Check_Failures
   - SendFailureAlert
   - SendSuccessNotification

4. Wire activities in sequence (read watermarks → merge all tables in parallel → update watermarks → check status → send alerts)

### Phase 3: Test (1 hour)

1. Click **Run Now** in OIC console
2. Watch Monitoring → Integrations for execution
3. Query control table:
   ```sql
   SELECT TABLE_NAME, STATUS, ROWS_MERGED, LAST_EXTRACT_DATE
   FROM PO_CACHE_LOAD_CONTROL;
   ```
4. Verify success emails arrive
5. Check inbox for daily schedule test

---

## Architecture

```
EBS (Source)
    ↓ (OIC reads via EBS DB adapter)
OIC Integration (Daily 02:00 UTC)
    ├─ Read watermarks from PO_CACHE_LOAD_CONTROL
    ├─ For each table:
    │   ├─ MERGE: Extract WHERE LAST_UPDATE_DATE > watermark
    │   └─ Update watermark to MAX(LAST_UPDATE_DATE)
    └─ Alert: Success or Failure email
    ↓
ADB Cache Tables (PO_HEADERS_ALL, PO_LINES_ALL, etc.)
    ↓
Applications read cache (zero direct EBS traffic)
```

---

## How It Works

### Watermark-Based Delta Logic

1. **Day 1 (Initial Load)**:
   - Extract ALL rows from EBS
   - Insert into ADB cache
   - Set `LAST_EXTRACT_DATE = MAX(LAST_UPDATE_DATE)`
   - Store in `PO_CACHE_LOAD_CONTROL` table

2. **Day 2+ (Incremental)**:
   - Read `LAST_EXTRACT_DATE` from control table (watermark)
   - Extract from EBS: `WHERE LAST_UPDATE_DATE > watermark - 1 hour`
   - MERGE into ADB cache:
     - **Matched rows**: Update all columns
     - **New rows**: Insert
   - Update watermark to new MAX(LAST_UPDATE_DATE)
   - Advance to next day

**1-hour overlap buffer**: Accounts for clock skew + late-arriving updates. Safe to rerun same cycle (MERGE is idempotent).

### MERGE Safety

```sql
MERGE INTO cache tgt
USING (SELECT * FROM ebs_source WHERE LAST_UPDATE_DATE > watermark - 1hr) src
ON (tgt.PK = src.PK)
WHEN MATCHED THEN UPDATE ...
WHEN NOT MATCHED THEN INSERT ...
```

- **Rerun safety**: If integration reruns same cycle, MERGE handles duplicates via PK
- **No data loss**: Updates matched, inserts new, skips unchanged
- **Atomic**: All-or-nothing per table

### Control Table

Tracks state per cache table:

| Column | Purpose |
|--------|---------|
| `TABLE_NAME` | Cache table name (PK) |
| `LOAD_TYPE` | INCREMENTAL or FULL_RELOAD |
| `LAST_EXTRACT_DATE` | Watermark (max LAST_UPDATE_DATE processed) |
| `STATUS` | RUNNING, SUCCESS, FAILED |
| `ROWS_MERGED` | Count of rows updated/inserted |
| `ERROR_MESSAGE` | Error details if failed |
| `LAST_RUN_START`, `LAST_RUN_END` | Execution timestamps |

---

## Configuration Details

### Scheduled Trigger

**Time**: 02:00 UTC daily (adjust as needed)

**Why 02:00 UTC?**: Avoids peak hours, runs after EBS nightly loads complete, cache ready for morning apps

### Tables Cached

| Cache Table | Source | Load Type | PK | Volume |
|---|---|---|---|---|
| PO_HEADERS_ALL | PO_HEADERS_ALL | Incremental | PO_HEADER_ID | ~100K |
| PO_LINES_ALL | PO_LINES_ALL | Incremental | PO_LINE_ID | ~500K |
| GL_CODE_COMBINATIONS | GL_CODE_COMBINATIONS_ALL | Full reload* | CODE_COMBINATION_ID | ~50K |
| PO_DISTRIBUTIONS_ALL | PO_DISTRIBUTIONS_ALL | Incremental | PO_DISTRIBUTION_ID | ~1M |
| PO_LINE_LOCATIONS_ALL | PO_LINE_LOCATIONS_ALL | Incremental | LINE_LOCATION_ID | ~200K |

*GL_CODE_COMBINATIONS: Small reference table, full reload cheaper than delta logic

### Variables in OIC

| Variable | Type | Usage |
|----------|------|-------|
| `v_po_headers_watermark` | Timestamp | Current watermark for PO_HEADERS |
| `v_po_lines_watermark` | Timestamp | Current watermark for PO_LINES |
| `v_*_merged` | Number | Row counts after MERGE |
| `v_error_msg` | String | Error capture during execution |
| `v_has_failures` | Boolean | Flag: true if any table failed |

---

## Error Handling

### During Execution

Each MERGE/UPDATE activity:
1. **On success**: Advances watermark, sets STATUS=SUCCESS
2. **On error**: Captures error in ERROR_MESSAGE, sets STATUS=FAILED
3. **Continues**: Doesn't stop; next table processes (fail-safe)

### After Execution

Query control table:
- If any STATUS=FAILED → Send alert email to DBA
- If all STATUS=SUCCESS → Send success email to ops

**Retry logic**:
- If failed, watermark stays put
- Next day's run retries from same watermark
- MERGE handles re-run safely (idempotent)

### Manual Recovery

```sql
-- Reset watermark to retry from beginning
UPDATE PO_CACHE_LOAD_CONTROL
SET LAST_EXTRACT_DATE = NULL,
    STATUS = 'PENDING',
    ERROR_MESSAGE = NULL
WHERE TABLE_NAME = 'PO_HEADERS_ALL';
```

---

## Monitoring & Operations

### Daily Health Check

```sql
SELECT TABLE_NAME, STATUS, ROWS_MERGED, LAST_EXTRACT_DATE, LAST_RUN_END
FROM PO_CACHE_LOAD_CONTROL
ORDER BY LAST_RUN_END DESC;
```

Expected: All STATUS=SUCCESS, ROWS_MERGED appropriate, LAST_RUN_END within last 24 hours

### OIC Monitoring

**Path**: Integrations → Monitoring → Integrations

- Watch execution logs
- Confirm all activities succeed
- Check execution time (should be < 30 min)

### Email Alerts

**Failure**: po-cache-dba@company.com (immediate)
**Success**: po-cache-ops@company.com (daily)

---

## Performance

### Current Setup

- **Execution time**: ~10-20 minutes (all 5 tables)
- **Network**: OIC → EBS → ADB (3 hops)
- **Data freshness**: 0-24 hours stale (daily load)

### Optimization Options

1. **Hourly load** (if SLA requires fresher):
   - Change schedule to hourly
   - Reduce 1-hour overlap buffer to 30 min
   - Monitor network load

2. **Parallel execution**:
   - OIC runs MERGE activities in parallel (fan-out)
   - No dependency between tables
   - Already optimized

3. **Chunking large tables**:
   - If PO_DISTRIBUTIONS_ALL (1M rows) timeout:
   - Add subprocess loop to chunk by DISTRIBUTION_ID % 10
   - Run 10 parallel subprocesses

---

## Troubleshooting

| Symptom | Cause | Fix |
|---------|-------|-----|
| STATUS=FAILED, ERROR_MESSAGE empty | Exception in activity | Check OIC Monitoring logs. Enable variable tracking. |
| Watermark not advancing | Previous cycle failed | Reset LAST_EXTRACT_DATE to NULL, retry. |
| Timeout > 30 min | EBS slow or large extract | Increase OIC timeout. Add chunking. Check EBS performance. |
| Duplicate rows in cache | MERGE failed silently | Verify PK constraint on cache table. Check alert logs. |
| Email not sent | SMTP not configured | Verify OIC notification settings. Check mail server. |
| All STATUS=RUNNING (never completes) | Integration hung | Check OIC for active executions. Manually stop if needed. Reset status. |

---

## Testing Workflow

**Before going live:**

1. Run `po_initial_load.sql` (populate cache)
2. Manually run integration (Test Run Now)
3. Query control table (verify SUCCESS)
4. Check emails (success notification)
5. Insert test data in EBS
6. Run integration again
7. Verify only changed rows merged (ROWS_MERGED should be low)
8. Activate schedule

**Post-activation:**

- Monitor daily execution at 02:00 UTC
- Weekly check: `SELECT COUNT(*) FROM PO_*` (row counts stable)
- Monthly: Review control table trend (watermark advancing consistently)

---

## Files Reference

### Phase 1: Database Setup
```
po_cache_tables.sql
po_cache_control_table.sql
po_initial_load.sql
```

### Phase 2: OIC Integration
```
OIC_INCREMENTAL_LOAD_FULL.md ← Follow this exactly
```

### Reference Documentation
```
PO_CACHE_LOAD_PLAN.md (design, architecture, operational procedures)
```

### Legacy (Skip)
```
OIC_INTEGRATION_CONFIG.md (stored procedure approach)
OIC_SETUP_STEPS.md (stored procedure approach)
OIC_PO_INCREMENTAL_LOAD_INTEGRATION.xml (stored procedure approach)
po_incremental_load.sql (stored procedure—you don't need this)
```

---

## Next Steps

1. ✅ Execute SQL scripts (po_cache_tables.sql → po_initial_load.sql)
2. ✅ Follow OIC_INCREMENTAL_LOAD_FULL.md to build integration (14 activities)
3. ✅ Test manually (Run Now in OIC)
4. ✅ Verify control table + emails
5. ✅ Activate schedule (daily 02:00 UTC)
6. ✅ Monitor for 1 week (ensure stability)
7. ✅ Hand off to ops (daily health checks)

---

## Support

**Design Questions**: See PO_CACHE_LOAD_PLAN.md

**OIC Setup Issues**: See OIC_INCREMENTAL_LOAD_FULL.md (14-step guide with error handling)

**SQL/ADB Issues**: Check control table error_message, ADB alert logs

---

**Last Updated**: 2026-07-28
**Owner**: Ayush Rathore
**Status**: Ready for implementation
