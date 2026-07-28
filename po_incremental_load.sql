-- Incremental load procedure - daily delta load using LAST_UPDATE_DATE watermark
-- Triggered by OIC scheduled integration
-- Uses MERGE for safe upsert: update matched rows, insert new rows

CREATE OR REPLACE PROCEDURE PO_INCREMENTAL_LOAD AS

    v_watermark TIMESTAMP;
    v_new_watermark TIMESTAMP;
    v_rows_read NUMBER := 0;
    v_rows_merged NUMBER := 0;
    v_error_msg VARCHAR2(4000);

BEGIN

    -- ==================== PO_HEADERS_ALL ====================
    BEGIN
        -- Read watermark from control table
        SELECT NVL(LAST_EXTRACT_DATE, TRUNC(SYSDATE) - 365)
        INTO v_watermark
        FROM PO_CACHE_LOAD_CONTROL
        WHERE TABLE_NAME = 'PO_HEADERS_ALL';

        -- Set status RUNNING
        UPDATE PO_CACHE_LOAD_CONTROL
        SET STATUS = 'RUNNING',
            LAST_RUN_START = SYSDATE,
            ERROR_MESSAGE = NULL
        WHERE TABLE_NAME = 'PO_HEADERS_ALL';

        -- Extract changed records (watermark minus 1 hour buffer for overlaps)
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
            WHERE pha.LAST_UPDATE_DATE > v_watermark - INTERVAL '1' HOUR
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
            );

        SELECT MAX(LAST_UPDATE_DATE) INTO v_new_watermark FROM ebs.PO_HEADERS_ALL
        WHERE LAST_UPDATE_DATE > v_watermark - INTERVAL '1' HOUR;

        UPDATE PO_CACHE_LOAD_CONTROL
        SET STATUS = 'SUCCESS',
            LAST_RUN_END = SYSDATE,
            LAST_EXTRACT_DATE = NVL(v_new_watermark, v_watermark),
            ROWS_MERGED = SQL%ROWCOUNT
        WHERE TABLE_NAME = 'PO_HEADERS_ALL';

    EXCEPTION WHEN OTHERS THEN
        v_error_msg := SQLERRM;
        UPDATE PO_CACHE_LOAD_CONTROL
        SET STATUS = 'FAILED',
            LAST_RUN_END = SYSDATE,
            ERROR_MESSAGE = v_error_msg
        WHERE TABLE_NAME = 'PO_HEADERS_ALL';
    END;

    -- ==================== PO_LINES_ALL ====================
    BEGIN
        SELECT NVL(LAST_EXTRACT_DATE, TRUNC(SYSDATE) - 365)
        INTO v_watermark
        FROM PO_CACHE_LOAD_CONTROL
        WHERE TABLE_NAME = 'PO_LINES_ALL';

        UPDATE PO_CACHE_LOAD_CONTROL
        SET STATUS = 'RUNNING',
            LAST_RUN_START = SYSDATE,
            ERROR_MESSAGE = NULL
        WHERE TABLE_NAME = 'PO_LINES_ALL';

        MERGE INTO PO_LINES_ALL tgt
        USING (
            SELECT
                pla.PO_LINE_ID, pla.PO_HEADER_ID, pla.LINE_NUM, pla.LINE_TYPE_ID,
                pla.ITEM_ID, pla.ITEM_DESCRIPTION, pla.UNIT_MEAS_LOOKUP_CODE,
                pla.UNIT_PRICE, pla.QUANTITY, pla.AMOUNT, pla.CREATION_DATE,
                pla.CREATED_BY, pla.LAST_UPDATE_DATE, pla.LAST_UPDATED_BY,
                pla.CLOSED_CODE, pla.CLOSED_DATE, pla.CANCEL_FLAG, pla.CANCEL_DATE,
                pla.CANCELLED_BY, pla.LINE_STATUS_ID, pla.AUCTION_HEADER_ID,
                pla.SUPPLIER_REF_NUMBER
            FROM ebs.PO_LINES_ALL pla
            WHERE pla.LAST_UPDATE_DATE > v_watermark - INTERVAL '1' HOUR
        ) src
        ON (tgt.PO_LINE_ID = src.PO_LINE_ID)
        WHEN MATCHED THEN
            UPDATE SET
                tgt.PO_HEADER_ID = src.PO_HEADER_ID,
                tgt.LINE_NUM = src.LINE_NUM,
                tgt.LINE_TYPE_ID = src.LINE_TYPE_ID,
                tgt.ITEM_ID = src.ITEM_ID,
                tgt.ITEM_DESCRIPTION = src.ITEM_DESCRIPTION,
                tgt.UNIT_MEAS_LOOKUP_CODE = src.UNIT_MEAS_LOOKUP_CODE,
                tgt.UNIT_PRICE = src.UNIT_PRICE,
                tgt.QUANTITY = src.QUANTITY,
                tgt.AMOUNT = src.AMOUNT,
                tgt.CREATED_BY = src.CREATED_BY,
                tgt.LAST_UPDATE_DATE = src.LAST_UPDATE_DATE,
                tgt.LAST_UPDATED_BY = src.LAST_UPDATED_BY,
                tgt.CLOSED_CODE = src.CLOSED_CODE,
                tgt.CLOSED_DATE = src.CLOSED_DATE,
                tgt.CANCEL_FLAG = src.CANCEL_FLAG,
                tgt.CANCEL_DATE = src.CANCEL_DATE,
                tgt.CANCELLED_BY = src.CANCELLED_BY,
                tgt.LINE_STATUS_ID = src.LINE_STATUS_ID,
                tgt.AUCTION_HEADER_ID = src.AUCTION_HEADER_ID,
                tgt.SUPPLIER_REF_NUMBER = src.SUPPLIER_REF_NUMBER
        WHEN NOT MATCHED THEN
            INSERT VALUES (
                src.PO_LINE_ID, src.PO_HEADER_ID, src.LINE_NUM, src.LINE_TYPE_ID,
                src.ITEM_ID, src.ITEM_DESCRIPTION, src.UNIT_MEAS_LOOKUP_CODE,
                src.UNIT_PRICE, src.QUANTITY, src.AMOUNT, src.CREATION_DATE,
                src.CREATED_BY, src.LAST_UPDATE_DATE, src.LAST_UPDATED_BY,
                src.CLOSED_CODE, src.CLOSED_DATE, src.CANCEL_FLAG, src.CANCEL_DATE,
                src.CANCELLED_BY, src.LINE_STATUS_ID, src.AUCTION_HEADER_ID,
                src.SUPPLIER_REF_NUMBER
            );

        SELECT MAX(LAST_UPDATE_DATE) INTO v_new_watermark FROM ebs.PO_LINES_ALL
        WHERE LAST_UPDATE_DATE > v_watermark - INTERVAL '1' HOUR;

        UPDATE PO_CACHE_LOAD_CONTROL
        SET STATUS = 'SUCCESS',
            LAST_RUN_END = SYSDATE,
            LAST_EXTRACT_DATE = NVL(v_new_watermark, v_watermark),
            ROWS_MERGED = SQL%ROWCOUNT
        WHERE TABLE_NAME = 'PO_LINES_ALL';

    EXCEPTION WHEN OTHERS THEN
        v_error_msg := SQLERRM;
        UPDATE PO_CACHE_LOAD_CONTROL
        SET STATUS = 'FAILED',
            LAST_RUN_END = SYSDATE,
            ERROR_MESSAGE = v_error_msg
        WHERE TABLE_NAME = 'PO_LINES_ALL';
    END;

    -- ==================== GL_CODE_COMBINATIONS (Full reload daily) ====================
    BEGIN
        UPDATE PO_CACHE_LOAD_CONTROL
        SET STATUS = 'RUNNING',
            LAST_RUN_START = SYSDATE,
            ERROR_MESSAGE = NULL
        WHERE TABLE_NAME = 'GL_CODE_COMBINATIONS';

        DELETE FROM GL_CODE_COMBINATIONS;

        INSERT INTO GL_CODE_COMBINATIONS
        SELECT
            gcc.CODE_COMBINATION_ID,
            gcc.CHART_OF_ACCOUNTS_ID,
            gcc.SEGMENT1, gcc.SEGMENT2, gcc.SEGMENT3, gcc.SEGMENT4, gcc.SEGMENT5,
            gcc.SEGMENT6, gcc.SEGMENT7, gcc.SEGMENT8, gcc.SEGMENT9, gcc.SEGMENT10,
            gcc.CREATION_DATE,
            gcc.CREATED_BY,
            gcc.LAST_UPDATE_DATE,
            gcc.LAST_UPDATED_BY,
            gcc.ENABLED_FLAG,
            gcc.SUMMARY_FLAG,
            gcc.DETAIL_POSTING_ALLOWED_FLAG
        FROM ebs.GL_CODE_COMBINATIONS_ALL gcc;

        UPDATE PO_CACHE_LOAD_CONTROL
        SET STATUS = 'SUCCESS',
            LAST_RUN_END = SYSDATE,
            LAST_EXTRACT_DATE = SYSDATE,
            ROWS_MERGED = SQL%ROWCOUNT
        WHERE TABLE_NAME = 'GL_CODE_COMBINATIONS';

    EXCEPTION WHEN OTHERS THEN
        v_error_msg := SQLERRM;
        UPDATE PO_CACHE_LOAD_CONTROL
        SET STATUS = 'FAILED',
            LAST_RUN_END = SYSDATE,
            ERROR_MESSAGE = v_error_msg
        WHERE TABLE_NAME = 'GL_CODE_COMBINATIONS';
    END;

    -- ==================== PO_DISTRIBUTIONS_ALL ====================
    BEGIN
        SELECT NVL(LAST_EXTRACT_DATE, TRUNC(SYSDATE) - 365)
        INTO v_watermark
        FROM PO_CACHE_LOAD_CONTROL
        WHERE TABLE_NAME = 'PO_DISTRIBUTIONS_ALL';

        UPDATE PO_CACHE_LOAD_CONTROL
        SET STATUS = 'RUNNING',
            LAST_RUN_START = SYSDATE,
            ERROR_MESSAGE = NULL
        WHERE TABLE_NAME = 'PO_DISTRIBUTIONS_ALL';

        MERGE INTO PO_DISTRIBUTIONS_ALL tgt
        USING (
            SELECT
                pda.PO_DISTRIBUTION_ID, pda.PO_HEADER_ID, pda.PO_LINE_ID,
                pda.LINE_LOCATION_ID, pda.DISTRIBUTION_NUM, pda.QUANTITY_ORDERED,
                pda.QUANTITY_DELIVERED, pda.QUANTITY_CANCELLED, pda.QUANTITY_BILLED,
                pda.AMOUNT_ORDERED, pda.AMOUNT_DELIVERED, pda.AMOUNT_BILLED,
                pda.CREATION_DATE, pda.CREATED_BY, pda.LAST_UPDATE_DATE,
                pda.LAST_UPDATED_BY, pda.CODE_COMBINATION_ID, pda.ORG_ID,
                pda.DISTRIBUTION_ACCOUNT_ID, pda.MATCH_OPTION, pda.DESTINATION_TYPE_CODE,
                pda.DESTINATION_ORGANIZATION_ID, pda.DESTINATION_SUBINVENTORY,
                pda.REASON_DISPUTED_FLAG, pda.FINALLY_CLOSED_FLAG
            FROM ebs.PO_DISTRIBUTIONS_ALL pda
            WHERE pda.LAST_UPDATE_DATE > v_watermark - INTERVAL '1' HOUR
        ) src
        ON (tgt.PO_DISTRIBUTION_ID = src.PO_DISTRIBUTION_ID)
        WHEN MATCHED THEN
            UPDATE SET
                tgt.PO_HEADER_ID = src.PO_HEADER_ID,
                tgt.PO_LINE_ID = src.PO_LINE_ID,
                tgt.LINE_LOCATION_ID = src.LINE_LOCATION_ID,
                tgt.DISTRIBUTION_NUM = src.DISTRIBUTION_NUM,
                tgt.QUANTITY_ORDERED = src.QUANTITY_ORDERED,
                tgt.QUANTITY_DELIVERED = src.QUANTITY_DELIVERED,
                tgt.QUANTITY_CANCELLED = src.QUANTITY_CANCELLED,
                tgt.QUANTITY_BILLED = src.QUANTITY_BILLED,
                tgt.AMOUNT_ORDERED = src.AMOUNT_ORDERED,
                tgt.AMOUNT_DELIVERED = src.AMOUNT_DELIVERED,
                tgt.AMOUNT_BILLED = src.AMOUNT_BILLED,
                tgt.CREATED_BY = src.CREATED_BY,
                tgt.LAST_UPDATE_DATE = src.LAST_UPDATE_DATE,
                tgt.LAST_UPDATED_BY = src.LAST_UPDATED_BY,
                tgt.CODE_COMBINATION_ID = src.CODE_COMBINATION_ID,
                tgt.ORG_ID = src.ORG_ID,
                tgt.DISTRIBUTION_ACCOUNT_ID = src.DISTRIBUTION_ACCOUNT_ID,
                tgt.MATCH_OPTION = src.MATCH_OPTION,
                tgt.DESTINATION_TYPE_CODE = src.DESTINATION_TYPE_CODE,
                tgt.DESTINATION_ORGANIZATION_ID = src.DESTINATION_ORGANIZATION_ID,
                tgt.DESTINATION_SUBINVENTORY = src.DESTINATION_SUBINVENTORY,
                tgt.REASON_DISPUTED_FLAG = src.REASON_DISPUTED_FLAG,
                tgt.FINALLY_CLOSED_FLAG = src.FINALLY_CLOSED_FLAG
        WHEN NOT MATCHED THEN
            INSERT VALUES (
                src.PO_DISTRIBUTION_ID, src.PO_HEADER_ID, src.PO_LINE_ID,
                src.LINE_LOCATION_ID, src.DISTRIBUTION_NUM, src.QUANTITY_ORDERED,
                src.QUANTITY_DELIVERED, src.QUANTITY_CANCELLED, src.QUANTITY_BILLED,
                src.AMOUNT_ORDERED, src.AMOUNT_DELIVERED, src.AMOUNT_BILLED,
                src.CREATION_DATE, src.CREATED_BY, src.LAST_UPDATE_DATE,
                src.LAST_UPDATED_BY, src.CODE_COMBINATION_ID, src.ORG_ID,
                src.DISTRIBUTION_ACCOUNT_ID, src.MATCH_OPTION, src.DESTINATION_TYPE_CODE,
                src.DESTINATION_ORGANIZATION_ID, src.DESTINATION_SUBINVENTORY,
                src.REASON_DISPUTED_FLAG, src.FINALLY_CLOSED_FLAG
            );

        SELECT MAX(LAST_UPDATE_DATE) INTO v_new_watermark FROM ebs.PO_DISTRIBUTIONS_ALL
        WHERE LAST_UPDATE_DATE > v_watermark - INTERVAL '1' HOUR;

        UPDATE PO_CACHE_LOAD_CONTROL
        SET STATUS = 'SUCCESS',
            LAST_RUN_END = SYSDATE,
            LAST_EXTRACT_DATE = NVL(v_new_watermark, v_watermark),
            ROWS_MERGED = SQL%ROWCOUNT
        WHERE TABLE_NAME = 'PO_DISTRIBUTIONS_ALL';

    EXCEPTION WHEN OTHERS THEN
        v_error_msg := SQLERRM;
        UPDATE PO_CACHE_LOAD_CONTROL
        SET STATUS = 'FAILED',
            LAST_RUN_END = SYSDATE,
            ERROR_MESSAGE = v_error_msg
        WHERE TABLE_NAME = 'PO_DISTRIBUTIONS_ALL';
    END;

    -- ==================== PO_LINE_LOCATIONS_ALL ====================
    BEGIN
        SELECT NVL(LAST_EXTRACT_DATE, TRUNC(SYSDATE) - 365)
        INTO v_watermark
        FROM PO_CACHE_LOAD_CONTROL
        WHERE TABLE_NAME = 'PO_LINE_LOCATIONS_ALL';

        UPDATE PO_CACHE_LOAD_CONTROL
        SET STATUS = 'RUNNING',
            LAST_RUN_START = SYSDATE,
            ERROR_MESSAGE = NULL
        WHERE TABLE_NAME = 'PO_LINE_LOCATIONS_ALL';

        MERGE INTO PO_LINE_LOCATIONS_ALL tgt
        USING (
            SELECT
                plla.LINE_LOCATION_ID, plla.PO_HEADER_ID, plla.PO_LINE_ID,
                plla.LOCATION_ID, plla.QUANTITY_ORDERED, plla.QUANTITY_DELIVERED,
                plla.QUANTITY_CANCELLED, plla.QUANTITY_BILLED, plla.UNIT_MEAS_LOOKUP_CODE,
                plla.UNIT_PRICE, plla.AMOUNT, plla.CREATION_DATE, plla.CREATED_BY,
                plla.LAST_UPDATE_DATE, plla.LAST_UPDATED_BY, plla.CLOSED_CODE,
                plla.CLOSED_DATE, plla.CANCEL_FLAG, plla.CANCEL_DATE, plla.CANCELLED_BY,
                plla.SHIPMENT_NUM, plla.SHIPMENT_TYPE, plla.NEED_BY_DATE,
                plla.PRICE_OVERRIDE_FLAG, plla.TAX_CODE_ID, plla.MATCH_OPTION
            FROM ebs.PO_LINE_LOCATIONS_ALL plla
            WHERE plla.LAST_UPDATE_DATE > v_watermark - INTERVAL '1' HOUR
        ) src
        ON (tgt.LINE_LOCATION_ID = src.LINE_LOCATION_ID)
        WHEN MATCHED THEN
            UPDATE SET
                tgt.PO_HEADER_ID = src.PO_HEADER_ID,
                tgt.PO_LINE_ID = src.PO_LINE_ID,
                tgt.LOCATION_ID = src.LOCATION_ID,
                tgt.QUANTITY_ORDERED = src.QUANTITY_ORDERED,
                tgt.QUANTITY_DELIVERED = src.QUANTITY_DELIVERED,
                tgt.QUANTITY_CANCELLED = src.QUANTITY_CANCELLED,
                tgt.QUANTITY_BILLED = src.QUANTITY_BILLED,
                tgt.UNIT_MEAS_LOOKUP_CODE = src.UNIT_MEAS_LOOKUP_CODE,
                tgt.UNIT_PRICE = src.UNIT_PRICE,
                tgt.AMOUNT = src.AMOUNT,
                tgt.CREATED_BY = src.CREATED_BY,
                tgt.LAST_UPDATE_DATE = src.LAST_UPDATE_DATE,
                tgt.LAST_UPDATED_BY = src.LAST_UPDATED_BY,
                tgt.CLOSED_CODE = src.CLOSED_CODE,
                tgt.CLOSED_DATE = src.CLOSED_DATE,
                tgt.CANCEL_FLAG = src.CANCEL_FLAG,
                tgt.CANCEL_DATE = src.CANCEL_DATE,
                tgt.CANCELLED_BY = src.CANCELLED_BY,
                tgt.SHIPMENT_NUM = src.SHIPMENT_NUM,
                tgt.SHIPMENT_TYPE = src.SHIPMENT_TYPE,
                tgt.NEED_BY_DATE = src.NEED_BY_DATE,
                tgt.PRICE_OVERRIDE_FLAG = src.PRICE_OVERRIDE_FLAG,
                tgt.TAX_CODE_ID = src.TAX_CODE_ID,
                tgt.MATCH_OPTION = src.MATCH_OPTION
        WHEN NOT MATCHED THEN
            INSERT VALUES (
                src.LINE_LOCATION_ID, src.PO_HEADER_ID, src.PO_LINE_ID,
                src.LOCATION_ID, src.QUANTITY_ORDERED, src.QUANTITY_DELIVERED,
                src.QUANTITY_CANCELLED, src.QUANTITY_BILLED, src.UNIT_MEAS_LOOKUP_CODE,
                src.UNIT_PRICE, src.AMOUNT, src.CREATION_DATE, src.CREATED_BY,
                src.LAST_UPDATE_DATE, src.LAST_UPDATED_BY, src.CLOSED_CODE,
                src.CLOSED_DATE, src.CANCEL_FLAG, src.CANCEL_DATE, src.CANCELLED_BY,
                src.SHIPMENT_NUM, src.SHIPMENT_TYPE, src.NEED_BY_DATE,
                src.PRICE_OVERRIDE_FLAG, src.TAX_CODE_ID, src.MATCH_OPTION
            );

        SELECT MAX(LAST_UPDATE_DATE) INTO v_new_watermark FROM ebs.PO_LINE_LOCATIONS_ALL
        WHERE LAST_UPDATE_DATE > v_watermark - INTERVAL '1' HOUR;

        UPDATE PO_CACHE_LOAD_CONTROL
        SET STATUS = 'SUCCESS',
            LAST_RUN_END = SYSDATE,
            LAST_EXTRACT_DATE = NVL(v_new_watermark, v_watermark),
            ROWS_MERGED = SQL%ROWCOUNT
        WHERE TABLE_NAME = 'PO_LINE_LOCATIONS_ALL';

    EXCEPTION WHEN OTHERS THEN
        v_error_msg := SQLERRM;
        UPDATE PO_CACHE_LOAD_CONTROL
        SET STATUS = 'FAILED',
            LAST_RUN_END = SYSDATE,
            ERROR_MESSAGE = v_error_msg
        WHERE TABLE_NAME = 'PO_LINE_LOCATIONS_ALL';
    END;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Incremental load cycle completed');

EXCEPTION WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
    RAISE;
END PO_INCREMENTAL_LOAD;
/
