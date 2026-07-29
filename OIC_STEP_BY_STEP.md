# OIC Integration Creation - Step by Step

Follow this exactly. Takes ~90 minutes.

---

## Prerequisites

✅ Both ADB and EBS connections already created in OIC
✅ SQL scripts executed: po_cache_tables.sql, po_cache_control_table.sql, po_initial_load.sql
✅ OIC console open: https://your-oic-instance.oracle.com

---

## STEP 1: Create Integration

**OIC Console → Integrations → Create**

1. **Name**: `PO_Cache_Incremental_Load_Inline`
2. **Description**: Daily incremental load of 5 PO tables from EBS to ADB
3. **Style**: Select **Scheduled**
4. Click **Create**

✅ Canvas opens with blank integration

---

## STEP 2: Configure Schedule Trigger

**Click the lightning bolt icon (Trigger)**

1. **Trigger Type**: Scheduled
2. **Schedule Type**: Daily
3. **Time**: 02:00
4. **Timezone**: UTC
5. **Days**: All days (Mon-Sun)
6. Click **✓ Done**

✅ Trigger now shows "Daily 02:00 UTC"

---

## STEP 3: Add Variables

**Click Variables button (top menu)**

Add these 8 variables:

| Name | Type | Initial Value |
|------|------|---|
| `v_po_headers_watermark` | Timestamp | Leave empty |
| `v_po_lines_watermark` | Timestamp | Leave empty |
| `v_po_dists_watermark` | Timestamp | Leave empty |
| `v_po_locs_watermark` | Timestamp | Leave empty |
| `v_gl_cc_reload` | Boolean | false |
| `v_error_msg` | String | "" |
| `v_has_failures` | Boolean | false |
| `v_final_status` | String | "" |

Click **✓ Done**

✅ Variables configured

---

## STEP 4: Add First Activity - Read Watermarks

**Left panel → Database → Drag "Execute SQL Select Query"**

1. **Activity Name**: `Read_All_Watermarks`
2. **Connection**: ADB_PO_CACHE
3. **SQL Query**:
```sql
SELECT 
    TABLE_NAME,
    NVL(LAST_EXTRACT_DATE, TRUNC(SYSDATE) - 365) as WATERMARK
FROM PO_CACHE_LOAD_CONTROL
ORDER BY TABLE_NAME
```

4. Click activity → **Mapping** tab
5. **Output Mapping**:
   - For each row in ResultSet, extract WATERMARK and map to correct variable:
   - Row 1 (GL_CODE_COMBINATIONS) → `v_gl_cc_reload = true`
   - Row 2 (PO_DISTRIBUTIONS_ALL) → `v_po_dists_watermark = {WATERMARK}`
   - Row 3 (PO_HEADERS_ALL) → `v_po_headers_watermark = {WATERMARK}`
   - Row 4 (PO_LINE_LOCATIONS_ALL) → `v_po_locs_watermark = {WATERMARK}`
   - Row 5 (PO_LINES_ALL) → `v_po_lines_watermark = {WATERMARK}`

6. Click **✓ Done**

✅ Activity 1 added and mapped

---

## STEP 5: Add Second Activity - Set Status RUNNING

**Drag "Execute SQL Update" to canvas (below Read_All_Watermarks)**

1. **Activity Name**: `Set_Status_Running`
2. **Connection**: ADB_PO_CACHE
3. **SQL Query**:
```sql
UPDATE PO_CACHE_LOAD_CONTROL
SET STATUS = 'RUNNING',
    LAST_RUN_START = SYSDATE,
    ERROR_MESSAGE = NULL
WHERE TABLE_NAME IN ('PO_HEADERS_ALL', 'PO_LINES_ALL', 'GL_CODE_COMBINATIONS', 
                     'PO_DISTRIBUTIONS_ALL', 'PO_LINE_LOCATIONS_ALL')
```

4. Click **✓ Done**

**Wire connection**: From Read_All_Watermarks output → Set_Status_Running input

✅ Activity 2 added

---

## STEP 6: Add MERGE Activity 1 - PO_HEADERS_ALL

**Drag "Execute SQL Update" to canvas (below Set_Status_Running)**

1. **Activity Name**: `Merge_PO_Headers`
2. **Connection**: ADB_PO_CACHE
3. **SQL Query**:
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
        tgt.SEGMENT1 = src.SEGMENT1, tgt.SEGMENT2 = src.SEGMENT2, tgt.SEGMENT3 = src.SEGMENT3,
        tgt.SEGMENT4 = src.SEGMENT4, tgt.SEGMENT5 = src.SEGMENT5,
        tgt.VENDOR_ID = src.VENDOR_ID, tgt.VENDOR_SITE_ID = src.VENDOR_SITE_ID,
        tgt.PO_DATE = src.PO_DATE, tgt.CREATED_BY = src.CREATED_BY,
        tgt.LAST_UPDATE_DATE = src.LAST_UPDATE_DATE, tgt.LAST_UPDATED_BY = src.LAST_UPDATED_BY,
        tgt.CLOSED_DATE = src.CLOSED_DATE, tgt.CLOSED_CODE = src.CLOSED_CODE,
        tgt.STATUS = src.STATUS, tgt.TYPE_LOOKUP_CODE = src.TYPE_LOOKUP_CODE,
        tgt.CURRENCY_CODE = src.CURRENCY_CODE, tgt.APPROVAL_STATUS = src.APPROVAL_STATUS,
        tgt.REVISION_NUM = src.REVISION_NUM, tgt.AGENT_ID = src.AGENT_ID,
        tgt.ORG_ID = src.ORG_ID, tgt.COMMENTS = src.COMMENTS,
        tgt.AUTHORIZATION_STATUS = src.AUTHORIZATION_STATUS,
        tgt.QUOTE_VENDOR_QUOTE_NUMBER = src.QUOTE_VENDOR_QUOTE_NUMBER,
        tgt.QUOTE_EXPIRES_DATE = src.QUOTE_EXPIRES_DATE,
        tgt.QUOTE_CREATION_DATE = src.QUOTE_CREATION_DATE,
        tgt.QUOTATION_CLASS_CODE = src.QUOTATION_CLASS_CODE,
        tgt.START_DATE = src.START_DATE, tgt.END_DATE = src.END_DATE
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

4. **Error Handling** (click activity):
   - On Error: **Continue**
   - Set Variable: `v_error_msg = "PO_HEADERS MERGE failed: {$error}"`
   - Set Variable: `v_has_failures = true`

5. Click **✓ Done**

✅ MERGE 1 added (runs in parallel with other MERGEs)

---

## STEP 7: Update PO_HEADERS Watermark

**Drag "Execute SQL Update"**

1. **Activity Name**: `Update_PO_Headers_Watermark`
2. **Connection**: ADB_PO_CACHE
3. **SQL Query**:
```sql
UPDATE PO_CACHE_LOAD_CONTROL
SET LAST_EXTRACT_DATE = (
        SELECT MAX(LAST_UPDATE_DATE)
        FROM ebs.PO_HEADERS_ALL
        WHERE LAST_UPDATE_DATE > {$v_po_headers_watermark} - INTERVAL '1' HOUR
    ),
    ROWS_MERGED = (
        SELECT COUNT(*)
        FROM ebs.PO_HEADERS_ALL
        WHERE LAST_UPDATE_DATE > {$v_po_headers_watermark} - INTERVAL '1' HOUR
    ),
    STATUS = 'SUCCESS',
    LAST_RUN_END = SYSDATE
WHERE TABLE_NAME = 'PO_HEADERS_ALL'
```

4. Click **✓ Done**

**Wire**: Merge_PO_Headers → Update_PO_Headers_Watermark

✅ Update 1 added

---

## STEP 8: Repeat for PO_LINES_ALL (Same Pattern)

**Drag MERGE activity**

1. **Name**: `Merge_PO_Lines`
2. **SQL**: Same structure, replace table names:
   - FROM ebs.PO_LINES_ALL
   - INTO PO_LINES_ALL
   - WHERE {$v_po_lines_watermark}
   - ON (tgt.PO_LINE_ID = src.PO_LINE_ID)
   - WHEN MATCHED UPDATE all columns
   - WHEN NOT MATCHED INSERT

3. Error handling: Set `v_error_msg`, `v_has_failures`

**Drag UPDATE activity**

4. **Name**: `Update_PO_Lines_Watermark`
5. **SQL**: Update control table WHERE TABLE_NAME = 'PO_LINES_ALL'

✅ MERGE 2 + Update 2 added

---

## STEP 9: GL_CODE_COMBINATIONS (Full Reload)

**Drag "Execute SQL Update"**

1. **Activity Name**: `Reload_GL_Code_Combinations`
2. **Connection**: ADB_PO_CACHE
3. **SQL Query**:
```sql
DELETE FROM GL_CODE_COMBINATIONS;
INSERT INTO GL_CODE_COMBINATIONS
SELECT
    gcc.CODE_COMBINATION_ID,
    gcc.CHART_OF_ACCOUNTS_ID,
    gcc.SEGMENT1, gcc.SEGMENT2, gcc.SEGMENT3, gcc.SEGMENT4, gcc.SEGMENT5,
    gcc.SEGMENT6, gcc.SEGMENT7, gcc.SEGMENT8, gcc.SEGMENT9, gcc.SEGMENT10,
    gcc.CREATION_DATE, gcc.CREATED_BY, gcc.LAST_UPDATE_DATE, gcc.LAST_UPDATED_BY,
    gcc.ENABLED_FLAG, gcc.SUMMARY_FLAG, gcc.DETAIL_POSTING_ALLOWED_FLAG
FROM ebs.GL_CODE_COMBINATIONS_ALL gcc;
UPDATE PO_CACHE_LOAD_CONTROL
SET STATUS = 'SUCCESS', LAST_RUN_END = SYSDATE,
    LAST_EXTRACT_DATE = (SELECT MAX(LAST_UPDATE_DATE) FROM GL_CODE_COMBINATIONS),
    ROWS_MERGED = (SELECT COUNT(*) FROM GL_CODE_COMBINATIONS)
WHERE TABLE_NAME = 'GL_CODE_COMBINATIONS'
```

4. Error handling: Set failure variables
5. Click **✓ Done**

✅ GL reload added

---

## STEP 10: PO_DISTRIBUTIONS_ALL (Same as PO_HEADERS)

**Drag MERGE activity**

1. **Name**: `Merge_PO_Distributions`
2. **SQL**: 
   - FROM ebs.PO_DISTRIBUTIONS_ALL
   - WHERE {$v_po_dists_watermark}
   - ON (tgt.PO_DISTRIBUTION_ID = src.PO_DISTRIBUTION_ID)

**Drag UPDATE activity**

3. **Name**: `Update_PO_Distributions_Watermark`

✅ MERGE 3 + Update 3 added

---

## STEP 11: PO_LINE_LOCATIONS_ALL (Same as PO_HEADERS)

**Drag MERGE activity**

1. **Name**: `Merge_PO_Line_Locations`
2. **SQL**:
   - FROM ebs.PO_LINE_LOCATIONS_ALL
   - WHERE {$v_po_locs_watermark}
   - ON (tgt.LINE_LOCATION_ID = src.LINE_LOCATION_ID)

**Drag UPDATE activity**

3. **Name**: `Update_PO_Line_Locations_Watermark`

✅ MERGE 4 + Update 4 added

---

## STEP 12: Query Final Status

**Drag "Execute SQL Select Query"**

1. **Activity Name**: `Query_Final_Status`
2. **Connection**: ADB_PO_CACHE
3. **SQL Query**:
```sql
SELECT TABLE_NAME, STATUS, LAST_EXTRACT_DATE, ROWS_MERGED, ERROR_MESSAGE, LAST_RUN_END
FROM PO_CACHE_LOAD_CONTROL
ORDER BY TABLE_NAME
```

4. **Output Mapping**: Store ResultSet in `v_final_status`
5. Click **✓ Done**

✅ Final status query added

---

## STEP 13: Check for Failures (Decision)

**Left panel → Logic → Drag "Decision"**

1. **Activity Name**: `Check_Failures`
2. **Condition Expression**:
```
count(Query_Final_Status.ResultSet[STATUS='FAILED']) > 0 OR v_has_failures = true
```

3. **True Path**: Goes to SendFailureAlert
4. **False Path**: Goes to SendSuccessNotification
5. Click **✓ Done**

**Wire**: Query_Final_Status → Check_Failures

✅ Decision added

---

## STEP 14: Send Failure Alert

**Left panel → Notification → Drag "Send Email"**

1. **Activity Name**: `SendFailureAlert`
2. **To**: `po-cache-dba@company.com`
3. **Cc**: `po-ops@company.com`
4. **Subject**: 
```
ALERT: PO Cache Incremental Load Failed - {$date()}
```

5. **Body**:
```
PO Cache Incremental Load Failed

FAILED TABLES:
{Loop through Query_Final_Status.ResultSet where STATUS='FAILED'}
  Table: {TABLE_NAME}
  Error: {ERROR_MESSAGE}
  Time: {LAST_RUN_END}

ACTIONS:
1. Check ADB space: SELECT * FROM DBA_FREE_SPACE;
2. Review error in PO_CACHE_LOAD_CONTROL table
3. Manual retry: UPDATE PO_CACHE_LOAD_CONTROL SET STATUS='PENDING' WHERE TABLE_NAME='<table>';
4. Escalate if persistent

Next automatic retry: Tomorrow 02:00 UTC
```

6. Click **✓ Done**

**Wire**: Check_Failures (TRUE) → SendFailureAlert

✅ Failure alert added

---

## STEP 15: Send Success Notification

**Drag "Send Email"**

1. **Activity Name**: `SendSuccessNotification`
2. **To**: `po-cache-ops@company.com`
3. **Subject**:
```
SUCCESS: PO Cache Incremental Load Complete - {$date()}
```

4. **Body**:
```
PO Cache Incremental Load Completed Successfully

LOAD SUMMARY:
{Loop through Query_Final_Status.ResultSet}
  {TABLE_NAME}: {ROWS_MERGED} rows merged, Watermark={LAST_EXTRACT_DATE}

All cache tables synchronized with EBS.
Next load: Tomorrow 02:00 UTC
```

5. Click **✓ Done**

**Wire**: Check_Failures (FALSE) → SendSuccessNotification

✅ Success notification added

---

## STEP 16: Wire All Connections

Canvas should look like:

```
Trigger
  ↓
Read_All_Watermarks
  ↓
Set_Status_Running
  ├→ Merge_PO_Headers → Update_PO_Headers_Watermark
  ├→ Merge_PO_Lines → Update_PO_Lines_Watermark
  ├→ Reload_GL_Code_Combinations
  ├→ Merge_PO_Distributions → Update_PO_Distributions_Watermark
  └→ Merge_PO_Line_Locations → Update_PO_Line_Locations_Watermark
  ↓
Query_Final_Status
  ↓
Check_Failures
  ├─ TRUE → SendFailureAlert
  └─ FALSE → SendSuccessNotification
```

**How to wire in OIC**:
- Click small circle on activity output
- Drag to circle on next activity input
- Connection line appears

✅ All wired

---

## STEP 17: Save

**Click Save button (top right)**

✅ Integration saved

---

## STEP 18: Test (Manual Run)

**In Integrations list, find `PO_Cache_Incremental_Load_Inline`**

1. Click **⋮ (menu)**
2. Select **Run Now**
3. Integration starts immediately

**Watch execution**:
- Click Monitoring → Integrations
- Find the running instance
- Watch each activity complete (green checkmarks)
- Execution time should be ~10-20 min

**Check results**:
```sql
SELECT TABLE_NAME, STATUS, ROWS_MERGED, LAST_EXTRACT_DATE
FROM PO_CACHE_LOAD_CONTROL;
```

Expected:
- All STATUS = SUCCESS
- ROWS_MERGED > 0 (or 0 if no changes since initial load)
- LAST_EXTRACT_DATE = recent timestamp

**Check email**: Success notification should arrive

✅ Integration tested successfully

---

## STEP 19: Activate Schedule

**In integration details**:

1. Click **Activate** (toggle switch, top right)
2. Confirm activation
3. Integration now scheduled for daily 02:00 UTC

✅ Integration live

---

## Troubleshooting During Setup

| Problem | Fix |
|---------|-----|
| **Variable not found in SQL** | Check variable name syntax: `{$variable_name}` with dollar sign |
| **MERGE syntax error** | Paste exact SQL from this guide, replace table names |
| **Activity won't wire** | Ensure output circle connects to input circle |
| **Email not sending** | Verify OIC notification settings, check SMTP relay |
| **Execution times out** | Check EBS is responsive, increase OIC timeout in settings |
| **Can't find EBS/ADB connection** | Create them first: Connections → Oracle Database |

---

## Daily Operations

**Every day at 02:00 UTC**:
✅ Integration runs automatically
✅ All 5 tables MERGE with changes from EBS
✅ Success email arrives (or failure alert if needed)

**Weekly check**:
```sql
SELECT * FROM PO_CACHE_LOAD_CONTROL ORDER BY LAST_RUN_END DESC;
```

✅ Done! You now have a fully operational PO cache incremental load.
