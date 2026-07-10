# SIT Guideline - Invoice Archival Testing

## Overview
This document provides comprehensive guidelines for System Integration Testing (SIT) related to invoice archival processes. It covers both Phase 2 Data Migration and daily run integrations, with detailed parameters and SQL queries for monitoring.

---

## Phase 2: Data Migration Integration

### 1. Main Integration: XXSITA_YOKOY_INVOICE_ARCHIVAL_MAIN_INT_P2_NOSFTP

**View Used:** `XXSITA_YKY_INV_ARCH_METADATA_P2`

**Purpose:**
- Test the upload to Revver for invoices already archived to DARE during Phase 2 Data migration

**Parameters:**
- **4-digit Entity Code** - To process invoices for a specific entity
- **Date Range** - To pick invoices within a specific date range
- **No Parameters** - If no parameters are passed, the integration will archive all invoices fetched by the view (approximately 11,250 invoices)

**Monitoring SQL:**
```sql
SELECT OPERATION_UNIT, count(*) 
FROM apps.xxsita_yky_inv_arch_metadata_p2 
GROUP BY OPERATION_UNIT;
```
*Use this to view entity-wise backlog counts*

---

### 2. Parent Integration: XXSITA_YOKOY_INVOICE_ARCHIVAL_PARENT_DM

**View Used:** `XXSITA_YKY_INV_ARCH_METADATA_P2`

**Purpose:**
This integration supports three use cases:

| Use Case | Description |
|----------|-------------|
| **Test Specific Invoice** | Pass Invoice ID to test a particular invoice |
| **Test by Creation Date** | Pass Invoice Creation Date to test invoices created on a specific date |
| **Reprocess Errored Invoices** | Pass Invoice ID to retry any failed invoices |

**Parameters:**
- Invoice ID
- Invoice Creation Date

---

## Phase 1 + Phase 2: Daily Run Integration

### 3. Daily Integration: XXSITA_YOKOY_INVOICE_ARCHIVAL_DAILY_RUN

**View Used:** `XXSITA_YKY_INV_ARCH_METADATA_DLY`

**Purpose:**
- Test the daily run process that archives invoices to DARE and then Revver
- The view fetches invoices where the DARE URL is blank in Oracle DFF attribute9

**Parameters:**
- **No Parameters Required** - The integration automatically fetches invoices created on the previous day
- **Batch Limit:** For testing purposes, limited to 300 invoices per run
  - *(Note: In Production, there will be no limit and it will process all invoices created on the previous day)*

**Monitoring SQL:**
```sql
SELECT OPERATION_UNIT, count(*) 
FROM APPS.XXSITA_YKY_INV_ARCH_METADATA_DLY 
GROUP BY OPERATION_UNIT;
```
*Use this to view entity-wise backlog counts*

---

### 4. Parent Integration: XXSITA_YOKOY_INVOICE_ARCHIVAL_PARENT_REPROCESS

**View Used:** `XXSITA_YKY_INV_ARCH_METADATA_DLY`

**Purpose:**
This integration supports three use cases:

| Use Case | Description |
|----------|-------------|
| **Test Specific Invoice** | Pass Invoice ID to test a particular invoice |
| **Test by Creation Date** | Pass Invoice Creation Date to test invoices created on a specific date |
| **Reprocess Errored Invoices** | Pass Invoice ID to retry any failed invoices |

**Parameters:**
- Invoice ID
- Invoice Creation Date

---

## Quick Reference Guide

### When to Use Each Integration

| Scenario | Integration to Use | Parameters |
|----------|-------------------|------------|
| Test all Phase 2 invoices | XXSITA_YOKOY_INVOICE_ARCHIVAL_MAIN_INT_P2_NOSFTP | None (or Entity Code / Date Range) |
| Test specific Phase 2 invoice | XXSITA_YOKOY_INVOICE_ARCHIVAL_PARENT_DM | Invoice ID |
| Test Phase 2 invoices by date | XXSITA_YOKOY_INVOICE_ARCHIVAL_PARENT_DM | Invoice Creation Date |
| Reprocess Phase 2 errors | XXSITA_YOKOY_INVOICE_ARCHIVAL_PARENT_DM | Invoice ID |
| Test daily run (P1 + P2) | XXSITA_YOKOY_INVOICE_ARCHIVAL_DAILY_RUN | None (auto-runs for previous day) |
| Test specific daily invoice | XXSITA_YOKOY_INVOICE_ARCHIVAL_PARENT_REPROCESS | Invoice ID |
| Test daily invoices by date | XXSITA_YOKOY_INVOICE_ARCHIVAL_PARENT_REPROCESS | Invoice Creation Date |
| Reprocess daily errors | XXSITA_YOKOY_INVOICE_ARCHIVAL_PARENT_REPROCESS | Invoice ID |

---

## Important Notes

1. **Data Migration Phase 2 (Revver):** Uses view `XXSITA_YKY_INV_ARCH_METADATA_P2`
2. **Daily Run (Phase 1 + Phase 2):** Uses view `XXSITA_YKY_INV_ARCH_METADATA_DLY`
3. **Monitoring:** Run the provided SQL queries to check entity-wise backlog counts before executing integrations
4. **Testing Limit:** Daily run is limited to 300 invoices in test environments; no limit in production
5. **DARE URL:** Daily run depends on invoices where DARE URL is blank in Oracle DFF attribute9

---

## Support
For additional information or clarifications, please contact the integration support team.

*Document Version: 1.0*  
*Last Updated: 2026-07-10*
