# OIC Integration Setup - Step-by-Step

## Quick Start: Create PO_Cache_Incremental_Load Integration in OIC

Follow these exact steps in your OIC console to wire the integration.

---

## Prerequisites

✅ ADB instance running with cache tables created
✅ PO_INCREMENTAL_LOAD() procedure deployed
✅ PO_CACHE_LOAD_CONTROL table initialized
✅ OIC instance with DBA role or equivalent

---

## Step 1: Create ADB Connection

**Path**: Integrations → Connections

1. Click **Create**
2. Search for **Oracle Database**
3. **Name**: `ADB_PO_CACHE`
4. **Description**: Autonomous Database for PO cache tables
5. **Hostname**: `<your-adb>.oraclecloud.com`
6. **Port**: `1521`
7. **Database Name**: `<your-adb-service-name>` (e.g., `POCACHE_high`)
8. **Username**: `PO_CACHE_ADMIN`
9. **Password**: `<your-password>`
10. **SSL Enabled**: Toggle ON
11. Click **Test Connection** → should return **Success**
12. Click **Save**

---

## Step 2: Create Scheduled Integration

**Path**: Integrations → Integrations

1. Click **Create**
2. **Name**: `PO_Cache_Incremental_Load`
3. **Description**: Daily incremental load of PO tables from EBS to ADB
4. **Style**: Select **Scheduled**
5. Click **Create**

---

## Step 3: Configure Schedule

In the canvas:

1. Click **Trigger** (lightning bolt icon)
2. **Trigger Type**: Scheduled
3. **Configuration**:
   - **Schedule Type**: Daily
   - **Time**: 02:00 (2:00 AM UTC)
   - **Timezone**: UTC
   - **Days of Week**: Select all (runs every day)
4. Click **✓ (Done)**

---

## Step 4: Add Database Invoke Activity (Procedure Call)

1. In Activities panel (left side), expand **Database**
2. Drag **Execute Stored Procedure** onto canvas
3. **Name**: `Invoke_PO_Incremental_Load`
4. **Connection**: Select `ADB_PO_CACHE` (from dropdown)
5. **Schema Name**: `PO_CACHE_ADMIN`
6. **Procedure Name**: `PO_INCREMENTAL_LOAD` (should autocomplete)
7. **Click → Mappings** (icon in activity)
   - **Input**: No parameters, leave empty
   - **Output**: Leave defaults (returns result set)
8. Click **✓ (Done)**

---

## Step 5: Add Database Query Activity (Status Check)

1. Drag **Execute SQL Select Query** onto canvas (below Invoke activity)
2. **Name**: `Query_Load_Status`
3. **Connection**: `ADB_PO_CACHE`
4. **SQL Query**: 
```sql
SELECT TABLE_NAME, STATUS, LAST_EXTRACT_DATE, ROWS_MERGED, ERROR_MESSAGE, LAST_RUN_END
FROM PO_CACHE_LOAD_CONTROL
ORDER BY TABLE_NAME
```
5. Click **✓ (Done)**

Connect output of **Invoke_PO_Incremental_Load** → input of **Query_Load_Status**

---

## Step 6: Add Decision (Branch on Status)

1. Drag **Decision** activity onto canvas
2. **Name**: `Check_For_Failures`
3. **Expression**:
   ```
   count(Query_Load_Status.ResultSet[STATUS='FAILED']) > 0
   ```
   (This returns TRUE if any table has STATUS=FAILED)
4. **True Path**: Goes to SendFailureAlert (Step 7)
5. **False Path**: Goes to SendSuccessNotification (Step 8)
6. Click **✓ (Done)**

---

## Step 7: Add Failure Alert Activity

1. Drag **Send Notification** (or **Email** if available) onto canvas
2. **Name**: `SendFailureAlert`
3. **Type**: Email
4. **Recipients**: 
   - **To**: `po-cache-dba@company.com`
   - **Cc**: `po-ops@company.com`
5. **Subject**: 
   ```
   ALERT: PO Cache Incremental Load Failed - {$timestamp}
   ```
6. **Body**:
   ```
   PO Cache Incremental Load Failed

   DETAILS:
   --------
   Integration: PO_Cache_Incremental_Load
   Time: {$timestamp}
   
   FAILED TABLES:
   {for-each Query_Load_Status.ResultSet[STATUS='FAILED']}
     • {TABLE_NAME}: {ERROR_MESSAGE}
   {/for-each}

   NEXT STEPS:
   1. Check ADB space: SELECT * FROM DBA_FREE_SPACE;
   2. Check error_message in PO_CACHE_LOAD_CONTROL
   3. Manual retry: EXEC PO_INCREMENTAL_LOAD();
   
   Next scheduled retry: Tomorrow 02:00 UTC
   ```
7. Click **✓ (Done)**

---

## Step 8: Add Success Notification Activity

1. Drag **Send Notification** onto canvas
2. **Name**: `SendSuccessNotification`
3. **Type**: Email
4. **Recipients**: 
   - **To**: `po-cache-ops@company.com`
5. **Subject**: 
   ```
   SUCCESS: PO Cache Load Complete - {$timestamp}
   ```
6. **Body**:
   ```
   PO Cache Incremental Load Completed Successfully

   SUMMARY:
   --------
   Integration: PO_Cache_Incremental_Load
   Time: {$timestamp}

   LOAD RESULTS:
   {for-each Query_Load_Status.ResultSet}
     {TABLE_NAME}
       Status: {STATUS}
       Rows Merged: {ROWS_MERGED}
       Watermark: {LAST_EXTRACT_DATE}
   {/for-each}

   All cache tables synchronized.
   Next load: Tomorrow 02:00 UTC
   ```
7. Click **✓ (Done)**

---

## Step 9: Wire Connections

In the canvas, connect activities:

```
Trigger (02:00 daily)
    ↓
Invoke_PO_Incremental_Load
    ↓
Query_Load_Status
    ↓
Check_For_Failures
    ├─ TRUE → SendFailureAlert
    └─ FALSE → SendSuccessNotification
```

**To connect**: Click small circle on output of Activity A, drag to input circle of Activity B.

---

## Step 10: Enable Tracking (Optional)

1. Click **Tracking** button (top menu)
2. Add tracked variables:
   - `procStatus` → {Invoke_PO_Incremental_Load.Result}
   - `rowsMerged` → {Query_Load_Status.ResultSet.ROWS_MERGED}
   - `failureCount` → count(Query_Load_Status.ResultSet[STATUS='FAILED'])
3. Click **✓ (Done)**

---

## Step 11: Save & Activate

1. Click **Save** (top right)
2. Click **Activate** (toggle switch)
3. Confirm activation → integration now scheduled

---

## Step 12: Test Execution

**Option A: Wait for schedule** (02:00 UTC next day)

**Option B: Trigger manual run** (test now):

1. Go to **Integrations** → Find `PO_Cache_Incremental_Load`
2. Click **⋮ (menu)** → **Run Now**
3. Integration starts immediately
4. Check **Monitoring** → **Integrations** for execution status
5. Verify `PO_CACHE_LOAD_CONTROL` table:
   ```sql
   SELECT TABLE_NAME, STATUS, LAST_EXTRACT_DATE, ROWS_MERGED, ERROR_MESSAGE
   FROM PO_CACHE_LOAD_CONTROL
   ORDER BY LAST_RUN_END DESC;
   ```
   - All statuses should be `SUCCESS`
   - ROWS_MERGED should be > 0 (or 0 if no changes since last run)
   - LAST_EXTRACT_DATE should be recent

---

## Troubleshooting

| Problem | Check |
|---------|-------|
| **Procedure not found** | Verify `PO_INCREMENTAL_LOAD` compiled in ADB. Query: `SELECT * FROM USER_PROCEDURES WHERE OBJECT_NAME='PO_INCREMENTAL_LOAD';` |
| **Connection fails** | Test ADB connectivity. Verify firewall rules, VCN security groups. Check hostname/port correct. |
| **Timeout** | Increase OIC timeout (Settings → Integration Settings). Check if EBS is slow. |
| **All status = FAILED** | Check error_message in PO_CACHE_LOAD_CONTROL. Common: ADB space full, EBS unavailable, lock timeout. |
| **No email sent** | Verify email relay configured in OIC. Check email recipients are valid. |

---

## Monitoring Checklist

Daily (or via dashboard):

- [ ] Integration ran at 02:00 UTC
- [ ] All tables have `STATUS=SUCCESS`
- [ ] `ROWS_MERGED` > 0 (or expected for your data)
- [ ] `LAST_EXTRACT_DATE` advancing (watermark moving forward)
- [ ] No `ERROR_MESSAGE` entries
- [ ] Success emails arriving

---

## Scale-Out (Future Enhancements)

1. **Parallelism**: Run queries for different tables in parallel subprocesses
2. **Chunking**: If PO_LINES_ALL extract > 1 hour, add loop to chunk by PK range
3. **Alerts**: Add Slack webhook instead of email for faster visibility
4. **Dashboard**: Create OIC dashboard showing load metrics, trends
5. **Hourly load**: Change schedule to hourly if SLA requires fresher cache

---

## Rollback

If something breaks:

1. **Deactivate** integration (toggle off)
2. Reset control table:
   ```sql
   UPDATE PO_CACHE_LOAD_CONTROL
   SET LAST_EXTRACT_DATE = NULL, STATUS = 'PENDING', ERROR_MESSAGE = NULL;
   COMMIT;
   ```
3. Truncate cache tables and re-run initial load
4. Reactivate integration

---

**Integration Created**: [Date]
**Tested By**: [Name]
**Approved By**: [DBA/Manager]
