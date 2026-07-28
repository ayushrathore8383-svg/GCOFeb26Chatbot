# OIC Integration Configuration Guide

## Overview
This guide walks through wiring the PO incremental load in Oracle Integration Cloud (OIC).

## Prerequisites
- OIC instance configured
- ADB connectivity configured (Connections → Database)
- EBS connectivity configured (Connections → Database or EBS adapter)
- Both `PO_INCREMENTAL_LOAD()` procedure and `PO_CACHE_LOAD_CONTROL` table created in ADB

---

## Step 1: Create ADB Stored Procedure Connector

**Location**: Connections → Create Connection

1. **Name**: `ADB_PO_CACHE`
2. **Type**: Oracle Database
3. **Configuration**:
   - Hostname: `<your-adb-instance>.oraclecloud.com`
   - Port: `1521`
   - Database Name: `<your-adb-service-name>`
   - Username: `PO_CACHE_ADMIN` (or your cache schema)
   - Password: `<secure-password>`
4. **Test Connection** → should succeed
5. **Save**

---

## Step 2: Create Scheduled Integration

**Location**: Integrations → Create Integration

### Basic Configuration
- **Name**: `PO_Cache_Incremental_Load`
- **Type**: Scheduled
- **Application**: Cloud Applications (or Custom)

### Schedule
- **Trigger Type**: Scheduled
- **Frequency**: Daily
- **Time**: 02:00 UTC (adjust as needed; should be after EBS nightly loads complete)
- **Timezone**: UTC

---

## Step 3: Add Invoke ADB Procedure

**Map Activities**:

1. **Drag**: `Invoke → Stored Procedure` to canvas
2. **Connection**: Select `ADB_PO_CACHE`
3. **Configuration**:
   - Schema: `PO_CACHE_ADMIN` (your schema)
   - Stored Procedure: `PO_INCREMENTAL_LOAD`
   - Direction: Synchronous (get response)

4. **Mapping**: (Usually no input params needed)
   - Input: Leave blank (procedure takes no parameters)
   - Output: Map to response object

**Example output mapping**:
```xml
<ns0:PoIncrementalLoadResponse>
    <status>SUCCESS</status>
    <timestamp>{current timestamp}</timestamp>
</ns0:PoIncrementalLoadResponse>
```

---

## Step 4: Add Control Table Query (Optional but Recommended)

Add a second activity to verify load success:

1. **Drag**: `Invoke → SQL Select` to canvas
2. **Connection**: Select `ADB_PO_CACHE`
3. **SQL Query**:
```sql
SELECT TABLE_NAME, STATUS, LAST_EXTRACT_DATE, ROWS_MERGED, ERROR_MESSAGE
FROM PO_CACHE_LOAD_CONTROL
WHERE STATUS != 'SUCCESS'
```

4. **Mapping**: Map results to alert notification (see Step 5)

**Purpose**: If any table status ≠ SUCCESS, sends alert. Helps catch failures fast.

---

## Step 5: Add Error Notification (Optional but Recommended)

1. **Drag**: `Notifications → Send Notification` to canvas
2. **Configure**:
   - **Type**: Email
   - **To**: `po-cache-dba@company.com` (or Slack webhook)
   - **Subject**: `PO Cache Load Failed: {TABLE_NAME}`
   - **Body**: 
   ```
   Load Status: {STATUS}
   Error: {ERROR_MESSAGE}
   Watermark: {LAST_EXTRACT_DATE}
   Time: {LAST_RUN_END}
   ```

3. **Add Condition**: 
   - Activity runs **only if** previous SQL query returns rows (status ≠ SUCCESS)

---

## Step 6: Configure Tracking

1. **Tracking**: Enable tracking on key variables:
   - Table name processed
   - Status result
   - Rows merged count

2. **Monitoring**: 
   - View execution logs in OIC → Monitoring → Integrations
   - Check for any failures

---

## Step 7: Activate & Test

1. **Save** integration
2. **Activate** (toggle on)
3. **Test Run** (manual trigger):
   - Integrations → Find `PO_Cache_Incremental_Load`
   - Click **Run Now**
   - Watch for success (green checkmark)
   - Check `PO_CACHE_LOAD_CONTROL` table:
   ```sql
   SELECT * FROM PO_CACHE_LOAD_CONTROL;
   ```
   - All statuses should be `SUCCESS`

---

## Advanced: Chunking Large Tables (if needed)

If `PO_LINES_ALL` or `PO_DISTRIBUTIONS_ALL` extract slowly (>100K rows/hr), add chunking:

1. Modify `PO_INCREMENTAL_LOAD()` to loop by PK ranges:
   ```sql
   FOR v_chunk IN 0..9
   LOOP
       MERGE INTO PO_LINES_ALL tgt
       USING (
           SELECT ... FROM ebs.PO_LINES_ALL
           WHERE LAST_UPDATE_DATE > v_watermark - INTERVAL '1' HOUR
             AND MOD(PO_LINE_ID, 10) = v_chunk
       ) src
       ...
   END LOOP;
   ```

2. Parallel OIC subprocess per chunk (if available in your OIC tier)

3. Monitor chunk completion + merge each result

---

## Troubleshooting

| Issue | Cause | Fix |
|---|---|---|
| **Integration times out (>30min)** | Table extract too large | Add chunking. Increase OIC timeout in settings. |
| **STATUS=FAILED, no error** | Procedure exception swallowed | Check ADB alert logs. Check ERROR_MESSAGE in control table. |
| **Watermark not advancing** | Status stays RUNNING | Manual reset: `UPDATE PO_CACHE_LOAD_CONTROL SET STATUS='FAILED'...` Re-run. |
| **Duplicate rows in cache** | MERGE failed silently | Verify PK constraint on cache table. Check ADB constraints. |
| **EBS connection refused** | EBS DB down or firewall | Test EBS connectivity from ADB SQLNet. Check OIC security groups. |

---

## Monitoring Dashboard (Optional)

Create a simple OIC dashboard to track:
- Last load timestamp per table
- Rows merged per load
- Load frequency (should be daily)
- Status trend (success vs fail rate)

Map control table query to dashboard widgets.

---

## Scale-Out (Future)

If load frequency increases to hourly or more:
1. Increase schedule frequency
2. Reduce watermark overlap (1 hr → 30 min) if EBS clock stable
3. Add table-level parallelism (run PO_HEADERS and PO_LINES in parallel subprocesses)
4. Consider Kafka/event-driven triggering (advanced)

---

## Rollback Procedure

If load corrupts cache:
1. Reset all control rows:
   ```sql
   UPDATE PO_CACHE_LOAD_CONTROL
   SET LAST_EXTRACT_DATE = NULL,
       STATUS = 'PENDING',
       ERROR_MESSAGE = NULL;
   COMMIT;
   ```
2. Truncate cache tables:
   ```sql
   TRUNCATE TABLE PO_HEADERS_ALL;
   TRUNCATE TABLE PO_LINES_ALL;
   ...
   ```
3. Re-run initial load: `@po_initial_load.sql`
4. Resume OIC integration

---

## Sign-Off

- **Configured By**: [Your Name]
- **Date**: [Date]
- **Reviewed By**: [DBA Name]
- **Approved By**: [Manager Name]
