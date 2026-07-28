# OIC PO Cache Incremental Load - Complete Configuration (No Stored Procedure)

All incremental load logic in OIC integration itself. One daily integration handles 5 tables.

---

## Architecture

```
OIC Scheduled Trigger (02:00 UTC daily)
    ↓
Set Status RUNNING for each table
    ↓
Read Watermark from Control Table
    ↓
For each table:
    - Extract changed rows (WHERE LAST_UPDATE_DATE > watermark - 1hr)
    - MERGE into cache table
    - Update control table with new watermark
    ↓
Send success/failure email
```

---

## Prerequisites

✅ Cache tables created (po_cache_tables.sql executed)
✅ Control table created (po_cache_control_table.sql executed)
✅ ADB connection configured in OIC (ADB_PO_CACHE)
✅ EBS database connection in OIC (EBS_DB)

---

## Step-by-Step OIC Setup

### Step 1: Create Scheduled Integration

**Path**: Integrations → Create

1. **Name**: `PO_Cache_Incremental_Load_Inline`
2. **Description**: Daily incremental load with watermark logic (no stored procedure)
3. **Style**: Scheduled
4. **Trigger Configuration**:
   - Type: Scheduled
   - Frequency: Daily
   - Time: 02:00 UTC
   - Timezone: UTC

Click **Create**

---

### Step 2: Initialize Variables

Add variables to track state during execution:

1. Click **Variables** tab
2. Add these variables:

| Variable | Type | Default | Purpose |
|----------|------|---------|---------|
| `v_po_headers_watermark` | Timestamp | NULL | Current watermark for PO_HEADERS |
| `v_po_lines_watermark` | Timestamp | NULL | Current watermark for PO_LINES |
| `v_gl_cc_new_rows` | Number | 0 | Row count GL_CODE_COMBINATIONS |
| `v_po_hdrs_merged` | Number | 0 | MERGE count PO_HEADERS |
| `v_po_lines_merged` | Number | 0 | MERGE count PO_LINES |
| `v_po_dists_merged` | Number | 0 | MERGE count PO_DISTRIBUTIONS |
| `v_po_locs_merged` | Number | 0 | MERGE count PO_LINE_LOCATIONS |
| `v_error_msg` | String | "" | Error capture |
| `v_has_failures` | Boolean | false | Track if any table failed |

---

### Step 3: Read All Watermarks (Initialize)

**Activity Name**: `Read_All_Watermarks`
**Type**: Execute SQL Select Query

**Connection**: ADB_PO_CACHE

**SQL Query**:
```sql
SELECT 
    TABLE_NAME,
    NVL(LAST_EXTRACT_DATE, TRUNC(SYSDATE) - 365) as WATERMARK
FROM PO_CACHE_LOAD_CONTROL
ORDER BY TABLE_NAME
```

**Map Outputs to Variables**:
- For row where TABLE_NAME='PO_HEADERS_ALL': Set `v_po_headers_watermark` = WATERMARK
- For row where TABLE_NAME='PO_LINES_ALL': Set `v_po_lines_watermark` = WATERMARK
- (Store all watermarks in variables)

---

### Step 4: Set Status RUNNING for All Tables

**Activity Name**: `Set_Status_Running`
**Type**: Execute SQL Update

**Connection**: ADB_PO_CACHE

**SQL Query**:
```sql
UPDATE PO_CACHE_LOAD_CONTROL
SET STATUS = 'RUNNING',
    LAST_RUN_START = SYSDATE,
    ERROR_MESSAGE = NULL
WHERE TABLE_NAME IN ('PO_HEADERS_ALL', 'PO_LINES_ALL', 'GL_CODE_COMBINATIONS', 
                     'PO_DISTRIBUTIONS_ALL', 'PO_LINE_LOCATIONS_ALL')
```

---

### Step 5: MERGE PO_HEADERS_ALL

**Activity Name**: `Merge_PO_Headers`
**Type**: Execute SQL Update (MERGE statement)

**Connection**: ADB_PO_CACHE

**SQL Query**:
```sql
MERGE INTO PO_HEADERS_ALL tgt
USING (
    SELECT
        pha.PO_HEADER_ID,
        pha.SEGMENT1, pha.SEGMENT2, pha.SEGMENT3, pha.SEGMENT4, pha.SEGMENT5,
        pha.VENDOR_ID, pha.VENDOR_SITE_ID, pha.PO_DATE, pha.CREATION_DATE,
        pha.CREATED_BY, pha.LAST_UPDATE_DATE, pha.LAST_UPDATED_BY, pha.CLOSED_DATE,
        pha.CLOSED_CODE, pha.STATUS, pha.TYPE_LOOKUP_CODE, pha.CURRENCY_CODE,
        pha.APPROVAL_STATUS, pha.REVISION_NUM, pha.AGENT_ID, pha.ORG_ID,
        pha.COMMENTS, pha.AUTHORIZATION_STATUS, pha.QUOTE_VENDOR_QUOTE_NUMBER,
        pha.QUOTE_EXPIRES_DATE, pha.QUOTE_CREATION_DATE, pha.QUOTATION_CLASS_CODE,
        pha.START_DATE, pha.END_DATE
    FROM ebs.PO_HEADERS_ALL pha
    WHERE pha.LAST_UPDATE_DATE > {$v_po_headers_watermark} - INTERVAL '1' HOUR
) src
ON (tgt.PO_HEADER_ID = src.PO_HEADER_ID)
WHEN MATCHED THEN
    UPDATE SET
        tgt.SEGMENT1 = src.SEGMENT1,
        tgt.SEGMENT2 = src.SEGMENT2,
        tgt.SEGMENT3 = src.SEGMENT3,
        tgt.SEGMENT4 = src.SEGMENT4,
        tgt.SEGMENT5 = src.SEGMENT5,
        tgt.VENDOR_ID = src.VENDOR_ID,
        tgt.VENDOR_SITE_ID = src.VENDOR_SITE_ID,
        tgt.PO_DATE = src.PO_DATE,
        tgt.CREATED_BY = src.CREATED_BY,
        tgt.LAST_UPDATE_DATE = src.LAST_UPDATE_DATE,
        tgt.LAST_UPDATED_BY = src.LAST_UPDATED_BY,
        tgt.CLOSED_DATE = src.CLOSED_DATE,
        tgt.CLOSED_CODE = src.CLOSED_CODE,
        tgt.STATUS = src.STATUS,
        tgt.TYPE_LOOKUP_CODE = src.TYPE_LOOKUP_CODE,
        tgt.CURRENCY_CODE = src.CURRENCY_CODE,
        tgt.APPROVAL_STATUS = src.APPROVAL_STATUS,
        tgt.REVISION_NUM = src.REVISION_NUM,
        tgt.AGENT_ID = src.AGENT_ID,
        tgt.ORG_ID = src.ORG_ID,
        tgt.COMMENTS = src.COMMENTS,
        tgt.AUTHORIZATION_STATUS = src.AUTHORIZATION_STATUS,
        tgt.QUOTE_VENDOR_QUOTE_NUMBER = src.QUOTE_VENDOR_QUOTE_NUMBER,
        tgt.QUOTE_EXPIRES_DATE = src.QUOTE_EXPIRES_DATE,
        tgt.QUOTE_CREATION_DATE = src.QUOTE_CREATION_DATE,
        tgt.QUOTATION_CLASS_CODE = src.QUOTATION_CLASS_CODE,
        tgt.START_DATE = src.START_DATE,
        tgt.END_DATE = src.END_DATE
WHEN NOT MATCHED THEN
    INSERT VALUES (
        src.PO_HEADER_ID, src.SEGMENT1, src.SEGMENT2, src.SEGMENT3, src.SEGMENT4,
        src.SEGMENT5, src.VENDOR_ID, src.VENDOR_SITE_ID, src.PO_DATE, src.CREATION_DATE,
        src.CREATED_BY, src.LAST_UPDATE_DATE, src.LAST_UPDATED_BY, src.CLOSED_DATE,
        src.CLOSED_CODE, src.STATUS, src.TYPE_LOOKUP_CODE, src.CURRENCY_CODE,
        src.APPROVAL_STATUS, src.REVISION_NUM, src.AGENT_ID, src.ORG_ID,
        src.COMMENTS, src.AUTHORIZATION_STATUS, src.QUOTE_VENDOR_QUOTE_NUMBER,
        src.QUOTE_EXPIRES_DATE, src.QUOTE_CREATION_DATE, src.QUOTATION_CLASS_CODE,
        src.START_DATE, src.END_DATE
    )
```

**Error Handling**:
- On error: Set `v_error_msg = "PO_HEADERS MERGE failed: {$error}"`
- Set `v_has_failures = true`
- Continue to next activity

---

### Step 6: Update Watermark & Status for PO_HEADERS

**Activity Name**: `Update_PO_Headers_Watermark`
**Type**: Execute SQL Update

**Connection**: ADB_PO_CACHE

**SQL Query**:
```sql
UPDATE PO_CACHE_LOAD_CONTROL
SET LAST_EXTRACT_DATE = (
        SELECT MAX(LAST_UPDATE_DATE)
        FROM ebs.PO_HEADERS_ALL
        WHERE LAST_UPDATE_DATE > {$v_po_headers_watermark} - INTERVAL '1' HOUR
    ),
    ROWS_MERGED = (SELECT COUNT(*) FROM PO_HEADERS_ALL WHERE LAST_UPDATE_DATE > {$v_po_headers_watermark} - INTERVAL '1' HOUR),
    STATUS = 'SUCCESS',
    LAST_RUN_END = SYSDATE
WHERE TABLE_NAME = 'PO_HEADERS_ALL'
```

**Error Handling**: Continue on error, set failure flag

---

### Step 7: Repeat for PO_LINES_ALL (Similar Pattern)

**Activity 7a**: Merge_PO_Lines
```sql
MERGE INTO PO_LINES_ALL tgt
USING (
    SELECT pla.* FROM ebs.PO_LINES_ALL pla
    WHERE pla.LAST_UPDATE_DATE > {$v_po_lines_watermark} - INTERVAL '1' HOUR
) src
ON (tgt.PO_LINE_ID = src.PO_LINE_ID)
WHEN MATCHED THEN UPDATE SET tgt.* = src.*
WHEN NOT MATCHED THEN INSERT VALUES src.*
```

**Activity 7b**: Update_PO_Lines_Watermark (similar to Step 6)

---

### Step 8: GL_CODE_COMBINATIONS (Full Reload Daily)

**Activity Name**: `Reload_GL_Code_Combinations`
**Type**: Execute SQL Update

**Connection**: ADB_PO_CACHE

**SQL Queries** (execute as batch):

```sql
-- 1. Delete all existing
DELETE FROM GL_CODE_COMBINATIONS;

-- 2. Reload all from EBS
INSERT INTO GL_CODE_COMBINATIONS
SELECT gcc.* FROM ebs.GL_CODE_COMBINATIONS_ALL gcc;

-- 3. Update control table
UPDATE PO_CACHE_LOAD_CONTROL
SET STATUS = 'SUCCESS',
    LAST_RUN_END = SYSDATE,
    LAST_EXTRACT_DATE = (SELECT MAX(LAST_UPDATE_DATE) FROM GL_CODE_COMBINATIONS),
    ROWS_MERGED = (SELECT COUNT(*) FROM GL_CODE_COMBINATIONS)
WHERE TABLE_NAME = 'GL_CODE_COMBINATIONS';
```

---

### Step 9: PO_DISTRIBUTIONS_ALL (Incremental)

**Activity 9a**: Merge_PO_Distributions
**Activity 9b**: Update_PO_Distributions_Watermark

(Same pattern as Steps 5-6)

---

### Step 10: PO_LINE_LOCATIONS_ALL (Incremental)

**Activity 10a**: Merge_PO_Line_Locations
**Activity 10b**: Update_PO_Line_Locations_Watermark

(Same pattern as Steps 5-6)

---

### Step 11: Query Final Status

**Activity Name**: `Query_Final_Status`
**Type**: Execute SQL Select Query

**Connection**: ADB_PO_CACHE

**SQL Query**:
```sql
SELECT TABLE_NAME, STATUS, LAST_EXTRACT_DATE, ROWS_MERGED, ERROR_MESSAGE, LAST_RUN_END
FROM PO_CACHE_LOAD_CONTROL
ORDER BY TABLE_NAME
```

Store results in variable `v_final_status`

---

### Step 12: Check for Failures & Send Alerts

**Activity Name**: `Check_Failures`
**Type**: Decision

**Condition**:
```
count(v_final_status[STATUS='FAILED']) > 0 OR v_has_failures = true
```

**True Path** → SendFailureAlert
**False Path** → SendSuccessNotification

---

### Step 13: Send Failure Alert

**Activity Name**: `SendFailureAlert`
**Type**: Send Email

**To**: po-cache-dba@company.com
**Subject**: ALERT: PO Cache Load Failed

**Body Template**:
```
PO Cache Incremental Load Failed

FAILED TABLES:
{for-each v_final_status[STATUS='FAILED']}
  {TABLE_NAME}: {ERROR_MESSAGE}
{/for-each}

Manual retry:
  UPDATE PO_CACHE_LOAD_CONTROL SET STATUS='PENDING', LAST_EXTRACT_DATE=NULL WHERE TABLE_NAME='<table>';
  -- Then re-run integration manually

Next scheduled retry: Tomorrow 02:00 UTC
```

---

### Step 14: Send Success Notification

**Activity Name**: `SendSuccessNotification`
**Type**: Send Email

**To**: po-cache-ops@company.com
**Subject**: SUCCESS: PO Cache Incremental Load Complete

**Body Template**:
```
PO Cache Incremental Load Completed Successfully

LOAD SUMMARY:
{for-each v_final_status}
  {TABLE_NAME}: {ROWS_MERGED} rows, Watermark={LAST_EXTRACT_DATE}
{/for-each}

Next load: Tomorrow 02:00 UTC
```

---

## Activity Flow Diagram

```
Trigger (02:00 UTC)
  ↓
Read_All_Watermarks
  ↓
Set_Status_Running
  ↓
├─ Merge_PO_Headers → Update_PO_Headers_Watermark
├─ Merge_PO_Lines → Update_PO_Lines_Watermark
├─ Reload_GL_Code_Combinations
├─ Merge_PO_Distributions → Update_PO_Distributions_Watermark
└─ Merge_PO_Line_Locations → Update_PO_Line_Locations_Watermark
  ↓
Query_Final_Status
  ↓
Check_Failures
  ├─ TRUE → SendFailureAlert
  └─ FALSE → SendSuccessNotification
```

**Note**: Steps 5-10 can run in parallel (fan-out) since they don't depend on each other.

---

## Key Implementation Details

### Watermark Variable Substitution

In OIC SQL activities, use `{$variable_name}` syntax:

```sql
WHERE LAST_UPDATE_DATE > {$v_po_headers_watermark} - INTERVAL '1' HOUR
```

OIC replaces `{$v_po_headers_watermark}` with actual timestamp value at execution time.

### MERGE Idempotency

MERGE is safe to rerun:
- **Matched rows**: Updated with latest EBS values
- **New rows**: Inserted
- **No duplicates**: PK constraint prevents reinsert

If integration reruns same cycle, MERGE handles it gracefully.

### Error Handling Strategy

Each MERGE/UPDATE activity:
1. **On Success**: Sets `v_table_merged = SQL%ROWCOUNT`
2. **On Error**: Sets `v_error_msg = $error`, `v_has_failures = true`
3. **Continues**: Doesn't stop; next table processes

Final check: If `v_has_failures = true` OR any status = 'FAILED', send alert.

---

## Testing Checklist

**Before activating schedule:**

1. ✅ Create test data in EBS (insert/update 5 rows per table)
2. ✅ Click **Run Now** on integration
3. ✅ Watch Monitoring → Integrations for execution
4. ✅ Query control table:
   ```sql
   SELECT * FROM PO_CACHE_LOAD_CONTROL;
   ```
   - All STATUS = SUCCESS
   - All ROWS_MERGED > 0
   - All LAST_EXTRACT_DATE recent
5. ✅ Verify cache tables have rows:
   ```sql
   SELECT COUNT(*) FROM PO_HEADERS_ALL;
   ```
6. ✅ Check inbox for success email

**Retest incremental (next day or manual run):**

1. Insert/update 3 new rows in EBS
2. Run integration manually
3. Query control table again
4. ROWS_MERGED should be 3 (only changed rows)
5. LAST_EXTRACT_DATE should advance

---

## Performance Tuning

1. **Parallel execution**: OIC runs activities in parallel by default if no dependencies
   - All 5 MERGE activities run simultaneously
   - Reduces execution time from 5×10min to ~10min

2. **Large extracts**: If any MERGE > 100K rows
   - Add loop/chunk logic in OIC subprocess
   - Split by PO_HEADER_ID ranges

3. **Network latency**: If EBS → OIC → ADB timeout
   - Increase OIC timeout: Settings → Integration Settings
   - Add connection pooling in EBS adapter

---

## Monitoring & Alerts

**OIC Monitoring Dashboard**:

Create dashboard showing:
- Last run timestamp
- Status per table (SUCCESS/FAILED count)
- Rows merged trend (daily)
- Execution time (should be < 30 min)

**Email alerts**: Automatic on failure
**Slack webhook**: Optional (add Send Notification step)

---

## Rollback Procedure

If data corrupts:

```sql
-- Reset control table
UPDATE PO_CACHE_LOAD_CONTROL
SET LAST_EXTRACT_DATE = NULL,
    STATUS = 'PENDING',
    ERROR_MESSAGE = NULL;
COMMIT;

-- Truncate caches
TRUNCATE TABLE PO_HEADERS_ALL;
TRUNCATE TABLE PO_LINES_ALL;
TRUNCATE TABLE GL_CODE_COMBINATIONS;
TRUNCATE TABLE PO_DISTRIBUTIONS_ALL;
TRUNCATE TABLE PO_LINE_LOCATIONS_ALL;

-- Re-run initial load from po_initial_load.sql
@po_initial_load.sql
```

Then reactivate integration.

---

## Sign-Off

**Integration Name**: PO_Cache_Incremental_Load_Inline
**Created**: [Date]
**Tested By**: [Name]
**Approved By**: [DBA/Manager]
