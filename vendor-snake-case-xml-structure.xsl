<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:nstrgmpr="http://vendor.structure"
                xmlns:nsmpr0="http://source.data">

  <xsl:variable name="f0_GetDataOutput" select="/nsmpr0:GetDataOutputCollection"/>

  <xsl:template match="/">
    <nstrgmpr:vendor>
      <nstrgmpr:vendor_id>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:VENDOR_ID"/>
      </nstrgmpr:vendor_id>
      <nstrgmpr:last_update_date>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:LAST_UPDATE_DATE"/>
      </nstrgmpr:last_update_date>
      <nstrgmpr:last_updated_by>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:LAST_UPDATED_BY"/>
      </nstrgmpr:last_updated_by>
      <nstrgmpr:vendor_name>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:VENDOR_NAME"/>
      </nstrgmpr:vendor_name>
      <nstrgmpr:vendor_name_alt>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:VENDOR_NAME_ALT"/>
      </nstrgmpr:vendor_name_alt>
      <nstrgmpr:segment1>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:SEGMENT1"/>
      </nstrgmpr:segment1>
      <nstrgmpr:summary_flag>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:SUMMARY_FLAG"/>
      </nstrgmpr:summary_flag>
      <nstrgmpr:enabled_flag>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:ENABLED_FLAG"/>
      </nstrgmpr:enabled_flag>
      <nstrgmpr:segment2>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:SEGMENT2"/>
      </nstrgmpr:segment2>
      <nstrgmpr:segment3>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:SEGMENT3"/>
      </nstrgmpr:segment3>
      <nstrgmpr:segment4>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:SEGMENT4"/>
      </nstrgmpr:segment4>
      <nstrgmpr:segment5>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:SEGMENT5"/>
      </nstrgmpr:segment5>
      <nstrgmpr:last_update_login>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:LAST_UPDATE_LOGIN"/>
      </nstrgmpr:last_update_login>
      <nstrgmpr:creation_date>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:CREATION_DATE"/>
      </nstrgmpr:creation_date>
      <nstrgmpr:created_by>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:CREATED_BY"/>
      </nstrgmpr:created_by>
      <nstrgmpr:employee_id>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:EMPLOYEE_ID"/>
      </nstrgmpr:employee_id>
      <nstrgmpr:vendor_type_lookup_code>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:VENDOR_TYPE_LOOKUP_CODE"/>
      </nstrgmpr:vendor_type_lookup_code>
      <nstrgmpr:customer_num>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:CUSTOMER_NUM"/>
      </nstrgmpr:customer_num>
      <nstrgmpr:one_time_flag>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:ONE_TIME_FLAG"/>
      </nstrgmpr:one_time_flag>
      <nstrgmpr:parent_vendor_id>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:PARENT_VENDOR_ID"/>
      </nstrgmpr:parent_vendor_id>
      <nstrgmpr:min_order_amount>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:MIN_ORDER_AMOUNT"/>
      </nstrgmpr:min_order_amount>
      <nstrgmpr:ship_to_location_id>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:SHIP_TO_LOCATION_ID"/>
      </nstrgmpr:ship_to_location_id>
      <nstrgmpr:bill_to_location_id>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:BILL_TO_LOCATION_ID"/>
      </nstrgmpr:bill_to_location_id>
      <nstrgmpr:ship_via_lookup_code>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:SHIP_VIA_LOOKUP_CODE"/>
      </nstrgmpr:ship_via_lookup_code>
      <nstrgmpr:freight_terms_lookup_code>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:FREIGHT_TERMS_LOOKUP_CODE"/>
      </nstrgmpr:freight_terms_lookup_code>
      <nstrgmpr:fob_lookup_code>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:FOB_LOOKUP_CODE"/>
      </nstrgmpr:fob_lookup_code>
      <nstrgmpr:terms_id>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:TERMS_ID"/>
      </nstrgmpr:terms_id>
      <nstrgmpr:set_of_books_id>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:SET_OF_BOOKS_ID"/>
      </nstrgmpr:set_of_books_id>
      <nstrgmpr:credit_status_lookup_code>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:CREDIT_STATUS_LOOKUP_CODE"/>
      </nstrgmpr:credit_status_lookup_code>
      <nstrgmpr:credit_limit>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:CREDIT_LIMIT"/>
      </nstrgmpr:credit_limit>
      <nstrgmpr:always_take_disc_flag>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:ALWAYS_TAKE_DISC_FLAG"/>
      </nstrgmpr:always_take_disc_flag>
      <nstrgmpr:pay_date_basis_lookup_code>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:PAY_DATE_BASIS_LOOKUP_CODE"/>
      </nstrgmpr:pay_date_basis_lookup_code>
      <nstrgmpr:pay_group_lookup_code>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:PAY_GROUP_LOOKUP_CODE"/>
      </nstrgmpr:pay_group_lookup_code>
      <nstrgmpr:payment_priority>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:PAYMENT_PRIORITY"/>
      </nstrgmpr:payment_priority>
      <nstrgmpr:invoice_currency_code>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:INVOICE_CURRENCY_CODE"/>
      </nstrgmpr:invoice_currency_code>
      <nstrgmpr:payment_currency_code>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:PAYMENT_CURRENCY_CODE"/>
      </nstrgmpr:payment_currency_code>
      <nstrgmpr:invoice_amount_limit>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:INVOICE_AMOUNT_LIMIT"/>
      </nstrgmpr:invoice_amount_limit>
      <nstrgmpr:exchange_date_lookup_code>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:EXCHANGE_DATE_LOOKUP_CODE"/>
      </nstrgmpr:exchange_date_lookup_code>
      <nstrgmpr:hold_all_payments_flag>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:HOLD_ALL_PAYMENTS_FLAG"/>
      </nstrgmpr:hold_all_payments_flag>
      <nstrgmpr:hold_future_payments_flag>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:HOLD_FUTURE_PAYMENTS_FLAG"/>
      </nstrgmpr:hold_future_payments_flag>
      <nstrgmpr:hold_reason>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:HOLD_REASON"/>
      </nstrgmpr:hold_reason>
      <nstrgmpr:distribution_set_id>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:DISTRIBUTION_SET_ID"/>
      </nstrgmpr:distribution_set_id>
      <nstrgmpr:accts_pay_code_combination_id>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:ACCTS_PAY_CODE_COMBINATION_ID"/>
      </nstrgmpr:accts_pay_code_combination_id>
      <nstrgmpr:disc_lost_code_combination_id>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:DISC_LOST_CODE_COMBINATION_ID"/>
      </nstrgmpr:disc_lost_code_combination_id>
      <nstrgmpr:disc_taken_code_combination_id>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:DISC_TAKEN_CODE_COMBINATION_ID"/>
      </nstrgmpr:disc_taken_code_combination_id>
      <nstrgmpr:expense_code_combination_id>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:EXPENSE_CODE_COMBINATION_ID"/>
      </nstrgmpr:expense_code_combination_id>
      <nstrgmpr:prepay_code_combination_id>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:PREPAY_CODE_COMBINATION_ID"/>
      </nstrgmpr:prepay_code_combination_id>
      <nstrgmpr:num_1099>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:NUM_1099"/>
      </nstrgmpr:num_1099>
      <nstrgmpr:type_1099>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:TYPE_1099"/>
      </nstrgmpr:type_1099>
      <nstrgmpr:withholding_status_lookup_code>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:WITHHOLDING_STATUS_LOOKUP_CODE"/>
      </nstrgmpr:withholding_status_lookup_code>
      <nstrgmpr:withholding_start_date>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:WITHHOLDING_START_DATE"/>
      </nstrgmpr:withholding_start_date>
      <nstrgmpr:organization_type_lookup_code>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:ORGANIZATION_TYPE_LOOKUP_CODE"/>
      </nstrgmpr:organization_type_lookup_code>
      <nstrgmpr:vat_code>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:VAT_CODE"/>
      </nstrgmpr:vat_code>
      <nstrgmpr:start_date_active>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:START_DATE_ACTIVE"/>
      </nstrgmpr:start_date_active>
      <nstrgmpr:end_date_active>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:END_DATE_ACTIVE"/>
      </nstrgmpr:end_date_active>
      <nstrgmpr:minority_group_lookup_code>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:MINORITY_GROUP_LOOKUP_CODE"/>
      </nstrgmpr:minority_group_lookup_code>
      <nstrgmpr:payment_method_lookup_code>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:PAYMENT_METHOD_LOOKUP_CODE"/>
      </nstrgmpr:payment_method_lookup_code>
      <nstrgmpr:bank_account_name>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:BANK_ACCOUNT_NAME"/>
      </nstrgmpr:bank_account_name>
      <nstrgmpr:bank_account_num>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:BANK_ACCOUNT_NUM"/>
      </nstrgmpr:bank_account_num>
      <nstrgmpr:bank_num>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:BANK_NUM"/>
      </nstrgmpr:bank_num>
      <nstrgmpr:bank_account_type>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:BANK_ACCOUNT_TYPE"/>
      </nstrgmpr:bank_account_type>
      <nstrgmpr:women_owned_flag>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:WOMEN_OWNED_FLAG"/>
      </nstrgmpr:women_owned_flag>
      <nstrgmpr:small_business_flag>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:SMALL_BUSINESS_FLAG"/>
      </nstrgmpr:small_business_flag>
      <nstrgmpr:standard_industry_class>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:STANDARD_INDUSTRY_CLASS"/>
      </nstrgmpr:standard_industry_class>
      <nstrgmpr:hold_flag>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:HOLD_FLAG"/>
      </nstrgmpr:hold_flag>
      <nstrgmpr:purchasing_hold_reason>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:PURCHASING_HOLD_REASON"/>
      </nstrgmpr:purchasing_hold_reason>
      <nstrgmpr:hold_by>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:HOLD_BY"/>
      </nstrgmpr:hold_by>
      <nstrgmpr:hold_date>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:HOLD_DATE"/>
      </nstrgmpr:hold_date>
      <nstrgmpr:terms_date_basis>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:TERMS_DATE_BASIS"/>
      </nstrgmpr:terms_date_basis>
      <nstrgmpr:price_tolerance>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:PRICE_TOLERANCE"/>
      </nstrgmpr:price_tolerance>
      <nstrgmpr:inspection_required_flag>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:INSPECTION_REQUIRED_FLAG"/>
      </nstrgmpr:inspection_required_flag>
      <nstrgmpr:receipt_required_flag>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:RECEIPT_REQUIRED_FLAG"/>
      </nstrgmpr:receipt_required_flag>
      <nstrgmpr:qty_rcv_tolerance>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:QTY_RCV_TOLERANCE"/>
      </nstrgmpr:qty_rcv_tolerance>
      <nstrgmpr:qty_rcv_exception_code>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:QTY_RCV_EXCEPTION_CODE"/>
      </nstrgmpr:qty_rcv_exception_code>
      <nstrgmpr:enforce_ship_to_location_code>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:ENFORCE_SHIP_TO_LOCATION_CODE"/>
      </nstrgmpr:enforce_ship_to_location_code>
      <nstrgmpr:days_early_receipt_allowed>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:DAYS_EARLY_RECEIPT_ALLOWED"/>
      </nstrgmpr:days_early_receipt_allowed>
      <nstrgmpr:days_late_receipt_allowed>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:DAYS_LATE_RECEIPT_ALLOWED"/>
      </nstrgmpr:days_late_receipt_allowed>
      <nstrgmpr:receipt_days_exception_code>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:RECEIPT_DAYS_EXCEPTION_CODE"/>
      </nstrgmpr:receipt_days_exception_code>
      <nstrgmpr:receiving_routing_id>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:RECEIVING_ROUTING_ID"/>
      </nstrgmpr:receiving_routing_id>
      <nstrgmpr:allow_substitute_receipts_flag>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:ALLOW_SUBSTITUTE_RECEIPTS_FLAG"/>
      </nstrgmpr:allow_substitute_receipts_flag>
      <nstrgmpr:allow_unordered_receipts_flag>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:ALLOW_UNORDERED_RECEIPTS_FLAG"/>
      </nstrgmpr:allow_unordered_receipts_flag>
      <nstrgmpr:hold_unmatched_invoices_flag>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:HOLD_UNMATCHED_INVOICES_FLAG"/>
      </nstrgmpr:hold_unmatched_invoices_flag>
      <nstrgmpr:exclusive_payment_flag>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:EXCLUSIVE_PAYMENT_FLAG"/>
      </nstrgmpr:exclusive_payment_flag>
      <nstrgmpr:ap_tax_rounding_rule>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:AP_TAX_ROUNDING_RULE"/>
      </nstrgmpr:ap_tax_rounding_rule>
      <nstrgmpr:auto_tax_calc_flag>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:AUTO_TAX_CALC_FLAG"/>
      </nstrgmpr:auto_tax_calc_flag>
      <nstrgmpr:auto_tax_calc_override>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:AUTO_TAX_CALC_OVERRIDE"/>
      </nstrgmpr:auto_tax_calc_override>
      <nstrgmpr:amount_includes_tax_flag>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:AMOUNT_INCLUDES_TAX_FLAG"/>
      </nstrgmpr:amount_includes_tax_flag>
      <nstrgmpr:tax_verification_date>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:TAX_VERIFICATION_DATE"/>
      </nstrgmpr:tax_verification_date>
      <nstrgmpr:name_control>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:NAME_CONTROL"/>
      </nstrgmpr:name_control>
      <nstrgmpr:state_reportable_flag>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:STATE_REPORTABLE_FLAG"/>
      </nstrgmpr:state_reportable_flag>
      <nstrgmpr:federal_reportable_flag>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:FEDERAL_REPORTABLE_FLAG"/>
      </nstrgmpr:federal_reportable_flag>
      <nstrgmpr:attribute_category>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE_CATEGORY"/>
      </nstrgmpr:attribute_category>
      <nstrgmpr:attribute1>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE1"/>
      </nstrgmpr:attribute1>
      <nstrgmpr:attribute2>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE2"/>
      </nstrgmpr:attribute2>
      <nstrgmpr:attribute3>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE3"/>
      </nstrgmpr:attribute3>
      <nstrgmpr:attribute4>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE4"/>
      </nstrgmpr:attribute4>
      <nstrgmpr:attribute5>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE5"/>
      </nstrgmpr:attribute5>
      <nstrgmpr:attribute6>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE6"/>
      </nstrgmpr:attribute6>
      <nstrgmpr:attribute7>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE7"/>
      </nstrgmpr:attribute7>
      <nstrgmpr:attribute8>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE8"/>
      </nstrgmpr:attribute8>
      <nstrgmpr:attribute9>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE9"/>
      </nstrgmpr:attribute9>
      <nstrgmpr:attribute10>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE10"/>
      </nstrgmpr:attribute10>
      <nstrgmpr:attribute11>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE11"/>
      </nstrgmpr:attribute11>
      <nstrgmpr:attribute12>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE12"/>
      </nstrgmpr:attribute12>
      <nstrgmpr:attribute13>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE13"/>
      </nstrgmpr:attribute13>
      <nstrgmpr:attribute14>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE14"/>
      </nstrgmpr:attribute14>
      <nstrgmpr:attribute15>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE15"/>
      </nstrgmpr:attribute15>
      <nstrgmpr:request_id>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:REQUEST_ID"/>
      </nstrgmpr:request_id>
      <nstrgmpr:program_application_id>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:PROGRAM_APPLICATION_ID"/>
      </nstrgmpr:program_application_id>
      <nstrgmpr:program_id>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:PROGRAM_ID"/>
      </nstrgmpr:program_id>
      <nstrgmpr:program_update_date>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:PROGRAM_UPDATE_DATE"/>
      </nstrgmpr:program_update_date>
      <nstrgmpr:offset_vat_code>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:OFFSET_VAT_CODE"/>
      </nstrgmpr:offset_vat_code>
      <nstrgmpr:vat_registration_num>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:VAT_REGISTRATION_NUM"/>
      </nstrgmpr:vat_registration_num>
      <nstrgmpr:auto_calculate_interest_flag>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:AUTO_CALCULATE_INTEREST_FLAG"/>
      </nstrgmpr:auto_calculate_interest_flag>
      <nstrgmpr:validation_number>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:VALIDATION_NUMBER"/>
      </nstrgmpr:validation_number>
      <nstrgmpr:exclude_freight_from_discount>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:EXCLUDE_FREIGHT_FROM_DISCOUNT"/>
      </nstrgmpr:exclude_freight_from_discount>
      <nstrgmpr:tax_reporting_name>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:TAX_REPORTING_NAME"/>
      </nstrgmpr:tax_reporting_name>
      <nstrgmpr:check_digits>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:CHECK_DIGITS"/>
      </nstrgmpr:check_digits>
      <nstrgmpr:bank_number>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:BANK_NUMBER"/>
      </nstrgmpr:bank_number>
      <nstrgmpr:allow_awt_flag>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:ALLOW_AWT_FLAG"/>
      </nstrgmpr:allow_awt_flag>
      <nstrgmpr:awt_group_id>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:AWT_GROUP_ID"/>
      </nstrgmpr:awt_group_id>
      <nstrgmpr:global_attribute1>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE1"/>
      </nstrgmpr:global_attribute1>
      <nstrgmpr:global_attribute2>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE2"/>
      </nstrgmpr:global_attribute2>
      <nstrgmpr:global_attribute3>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE3"/>
      </nstrgmpr:global_attribute3>
      <nstrgmpr:global_attribute4>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE4"/>
      </nstrgmpr:global_attribute4>
      <nstrgmpr:global_attribute5>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE5"/>
      </nstrgmpr:global_attribute5>
      <nstrgmpr:global_attribute6>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE6"/>
      </nstrgmpr:global_attribute6>
      <nstrgmpr:global_attribute7>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE7"/>
      </nstrgmpr:global_attribute7>
      <nstrgmpr:global_attribute8>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE8"/>
      </nstrgmpr:global_attribute8>
      <nstrgmpr:global_attribute9>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE9"/>
      </nstrgmpr:global_attribute9>
      <nstrgmpr:global_attribute10>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE10"/>
      </nstrgmpr:global_attribute10>
      <nstrgmpr:global_attribute11>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE11"/>
      </nstrgmpr:global_attribute11>
      <nstrgmpr:global_attribute12>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE12"/>
      </nstrgmpr:global_attribute12>
      <nstrgmpr:global_attribute13>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE13"/>
      </nstrgmpr:global_attribute13>
      <nstrgmpr:global_attribute14>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE14"/>
      </nstrgmpr:global_attribute14>
      <nstrgmpr:global_attribute15>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE15"/>
      </nstrgmpr:global_attribute15>
      <nstrgmpr:global_attribute16>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE16"/>
      </nstrgmpr:global_attribute16>
      <nstrgmpr:global_attribute17>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE17"/>
      </nstrgmpr:global_attribute17>
      <nstrgmpr:global_attribute18>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE18"/>
      </nstrgmpr:global_attribute18>
      <nstrgmpr:global_attribute19>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE19"/>
      </nstrgmpr:global_attribute19>
      <nstrgmpr:global_attribute20>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE20"/>
      </nstrgmpr:global_attribute20>
      <nstrgmpr:global_attribute_category>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE_CATEGORY"/>
      </nstrgmpr:global_attribute_category>
      <nstrgmpr:edi_transaction_handling>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:EDI_TRANSACTION_HANDLING"/>
      </nstrgmpr:edi_transaction_handling>
      <nstrgmpr:edi_payment_method>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:EDI_PAYMENT_METHOD"/>
      </nstrgmpr:edi_payment_method>
      <nstrgmpr:edi_payment_format>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:EDI_PAYMENT_FORMAT"/>
      </nstrgmpr:edi_payment_format>
      <nstrgmpr:edi_remittance_method>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:EDI_REMITTANCE_METHOD"/>
      </nstrgmpr:edi_remittance_method>
      <nstrgmpr:edi_remittance_instruction>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:EDI_REMITTANCE_INSTRUCTION"/>
      </nstrgmpr:edi_remittance_instruction>
      <nstrgmpr:bank_charge_bearer>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:BANK_CHARGE_BEARER"/>
      </nstrgmpr:bank_charge_bearer>
      <nstrgmpr:bank_branch_type>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:BANK_BRANCH_TYPE"/>
      </nstrgmpr:bank_branch_type>
      <nstrgmpr:match_option>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:MATCH_OPTION"/>
      </nstrgmpr:match_option>
      <nstrgmpr:future_dated_payment_ccid>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:FUTURE_DATED_PAYMENT_CCID"/>
      </nstrgmpr:future_dated_payment_ccid>
      <nstrgmpr:create_debit_memo_flag>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:CREATE_DEBIT_MEMO_FLAG"/>
      </nstrgmpr:create_debit_memo_flag>
      <nstrgmpr:offset_tax_flag>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:OFFSET_TAX_FLAG"/>
      </nstrgmpr:offset_tax_flag>
      <nstrgmpr:party_id>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:PARTY_ID"/>
      </nstrgmpr:party_id>
      <nstrgmpr:parent_party_id>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:PARENT_PARTY_ID"/>
      </nstrgmpr:parent_party_id>
      <nstrgmpr:ni_number>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:NI_NUMBER"/>
      </nstrgmpr:ni_number>
      <nstrgmpr:tca_sync_num_1099>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:TCA_SYNC_NUM_1099"/>
      </nstrgmpr:tca_sync_num_1099>
      <nstrgmpr:tca_sync_vendor_name>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:TCA_SYNC_VENDOR_NAME"/>
      </nstrgmpr:tca_sync_vendor_name>
      <nstrgmpr:tca_sync_vat_reg_num>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:TCA_SYNC_VAT_REG_NUM"/>
      </nstrgmpr:tca_sync_vat_reg_num>
      <nstrgmpr:unique_tax_reference_num>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:UNIQUE_TAX_REFERENCE_NUM"/>
      </nstrgmpr:unique_tax_reference_num>
      <nstrgmpr:partnership_utr>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:PARTNERSHIP_UTR"/>
      </nstrgmpr:partnership_utr>
      <nstrgmpr:partnership_name>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:PARTNERSHIP_NAME"/>
      </nstrgmpr:partnership_name>
      <nstrgmpr:cis_enabled_flag>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:CIS_ENABLED_FLAG"/>
      </nstrgmpr:cis_enabled_flag>
      <nstrgmpr:first_name>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:FIRST_NAME"/>
      </nstrgmpr:first_name>
      <nstrgmpr:second_name>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:SECOND_NAME"/>
      </nstrgmpr:second_name>
      <nstrgmpr:last_name>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:LAST_NAME"/>
      </nstrgmpr:last_name>
      <nstrgmpr:salutation>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:SALUTATION"/>
      </nstrgmpr:salutation>
      <nstrgmpr:trading_name>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:TRADING_NAME"/>
      </nstrgmpr:trading_name>
      <nstrgmpr:work_reference>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:WORK_REFERENCE"/>
      </nstrgmpr:work_reference>
      <nstrgmpr:company_registration_number>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:COMPANY_REGISTRATION_NUMBER"/>
      </nstrgmpr:company_registration_number>
      <nstrgmpr:national_insurance_number>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:NATIONAL_INSURANCE_NUMBER"/>
      </nstrgmpr:national_insurance_number>
      <nstrgmpr:verification_number>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:VERIFICATION_NUMBER"/>
      </nstrgmpr:verification_number>
      <nstrgmpr:verification_request_id>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:VERIFICATION_REQUEST_ID"/>
      </nstrgmpr:verification_request_id>
      <nstrgmpr:match_status_flag>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:MATCH_STATUS_FLAG"/>
      </nstrgmpr:match_status_flag>
      <nstrgmpr:cis_verification_date>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:CIS_VERIFICATION_DATE"/>
      </nstrgmpr:cis_verification_date>
      <nstrgmpr:individual_1099>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:INDIVIDUAL_1099"/>
      </nstrgmpr:individual_1099>
      <nstrgmpr:pay_awt_group_id>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:PAY_AWT_GROUP_ID"/>
      </nstrgmpr:pay_awt_group_id>
      <nstrgmpr:cis_parent_vendor_id>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:CIS_PARENT_VENDOR_ID"/>
      </nstrgmpr:cis_parent_vendor_id>
      <nstrgmpr:bus_class_last_certified_date>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:BUS_CLASS_LAST_CERTIFIED_DATE"/>
      </nstrgmpr:bus_class_last_certified_date>
      <nstrgmpr:bus_class_last_certified_by>
        <xsl:value-of select="$f0_GetDataOutput/nsmpr0:GetDataOutput/nsmpr0:BUS_CLASS_LAST_CERTIFIED_BY"/>
      </nstrgmpr:bus_class_last_certified_by>
    </nstrgmpr:vendor>
  </xsl:template>

</xsl:stylesheet>
