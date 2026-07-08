<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:nstrgmpr="http://vendor.structure"
                xmlns:nsmpr0="http://source.data">

  <xsl:variable name="GetData" select="/nsmpr0:GetDataOutputCollection"/>

  <xsl:template match="/">
    <nstrgmpr:vendor>
      <nstrgmpr:vendorId>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:VENDOR_ID"/>
      </nstrgmpr:vendorId>
      <nstrgmpr:lastUpdateDate>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:LAST_UPDATE_DATE"/>
      </nstrgmpr:lastUpdateDate>
      <nstrgmpr:lastUpdatedBy>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:LAST_UPDATED_BY"/>
      </nstrgmpr:lastUpdatedBy>
      <nstrgmpr:vendorName>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:VENDOR_NAME"/>
      </nstrgmpr:vendorName>
      <nstrgmpr:vendorNameAlt>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:VENDOR_NAME_ALT"/>
      </nstrgmpr:vendorNameAlt>
      <nstrgmpr:segment1>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:SEGMENT1"/>
      </nstrgmpr:segment1>
      <nstrgmpr:summaryFlag>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:SUMMARY_FLAG"/>
      </nstrgmpr:summaryFlag>
      <nstrgmpr:enabledFlag>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:ENABLED_FLAG"/>
      </nstrgmpr:enabledFlag>
      <nstrgmpr:segment2>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:SEGMENT2"/>
      </nstrgmpr:segment2>
      <nstrgmpr:segment3>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:SEGMENT3"/>
      </nstrgmpr:segment3>
      <nstrgmpr:segment4>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:SEGMENT4"/>
      </nstrgmpr:segment4>
      <nstrgmpr:segment5>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:SEGMENT5"/>
      </nstrgmpr:segment5>
      <nstrgmpr:lastUpdateLogin>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:LAST_UPDATE_LOGIN"/>
      </nstrgmpr:lastUpdateLogin>
      <nstrgmpr:creationDate>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:CREATION_DATE"/>
      </nstrgmpr:creationDate>
      <nstrgmpr:createdBy>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:CREATED_BY"/>
      </nstrgmpr:createdBy>
      <nstrgmpr:employeeId>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:EMPLOYEE_ID"/>
      </nstrgmpr:employeeId>
      <nstrgmpr:vendorTypeLookupCode>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:VENDOR_TYPE_LOOKUP_CODE"/>
      </nstrgmpr:vendorTypeLookupCode>
      <nstrgmpr:customerNum>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:CUSTOMER_NUM"/>
      </nstrgmpr:customerNum>
      <nstrgmpr:oneTimeFlag>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:ONE_TIME_FLAG"/>
      </nstrgmpr:oneTimeFlag>
      <nstrgmpr:parentVendorId>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:PARENT_VENDOR_ID"/>
      </nstrgmpr:parentVendorId>
      <nstrgmpr:minOrderAmount>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:MIN_ORDER_AMOUNT"/>
      </nstrgmpr:minOrderAmount>
      <nstrgmpr:shipToLocationId>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:SHIP_TO_LOCATION_ID"/>
      </nstrgmpr:shipToLocationId>
      <nstrgmpr:billToLocationId>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:BILL_TO_LOCATION_ID"/>
      </nstrgmpr:billToLocationId>
      <nstrgmpr:shipViaLookupCode>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:SHIP_VIA_LOOKUP_CODE"/>
      </nstrgmpr:shipViaLookupCode>
      <nstrgmpr:freightTermsLookupCode>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:FREIGHT_TERMS_LOOKUP_CODE"/>
      </nstrgmpr:freightTermsLookupCode>
      <nstrgmpr:fobLookupCode>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:FOB_LOOKUP_CODE"/>
      </nstrgmpr:fobLookupCode>
      <nstrgmpr:termsId>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:TERMS_ID"/>
      </nstrgmpr:termsId>
      <nstrgmpr:setOfBooksId>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:SET_OF_BOOKS_ID"/>
      </nstrgmpr:setOfBooksId>
      <nstrgmpr:creditStatusLookupCode>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:CREDIT_STATUS_LOOKUP_CODE"/>
      </nstrgmpr:creditStatusLookupCode>
      <nstrgmpr:creditLimit>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:CREDIT_LIMIT"/>
      </nstrgmpr:creditLimit>
      <nstrgmpr:alwaysTakeDiscFlag>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:ALWAYS_TAKE_DISC_FLAG"/>
      </nstrgmpr:alwaysTakeDiscFlag>
      <nstrgmpr:payDateBasisLookupCode>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:PAY_DATE_BASIS_LOOKUP_CODE"/>
      </nstrgmpr:payDateBasisLookupCode>
      <nstrgmpr:payGroupLookupCode>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:PAY_GROUP_LOOKUP_CODE"/>
      </nstrgmpr:payGroupLookupCode>
      <nstrgmpr:paymentPriority>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:PAYMENT_PRIORITY"/>
      </nstrgmpr:paymentPriority>
      <nstrgmpr:invoiceCurrencyCode>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:INVOICE_CURRENCY_CODE"/>
      </nstrgmpr:invoiceCurrencyCode>
      <nstrgmpr:paymentCurrencyCode>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:PAYMENT_CURRENCY_CODE"/>
      </nstrgmpr:paymentCurrencyCode>
      <nstrgmpr:invoiceAmountLimit>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:INVOICE_AMOUNT_LIMIT"/>
      </nstrgmpr:invoiceAmountLimit>
      <nstrgmpr:exchangeDateLookupCode>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:EXCHANGE_DATE_LOOKUP_CODE"/>
      </nstrgmpr:exchangeDateLookupCode>
      <nstrgmpr:holdAllPaymentsFlag>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:HOLD_ALL_PAYMENTS_FLAG"/>
      </nstrgmpr:holdAllPaymentsFlag>
      <nstrgmpr:holdFuturePaymentsFlag>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:HOLD_FUTURE_PAYMENTS_FLAG"/>
      </nstrgmpr:holdFuturePaymentsFlag>
      <nstrgmpr:holdReason>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:HOLD_REASON"/>
      </nstrgmpr:holdReason>
      <nstrgmpr:distributionSetId>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:DISTRIBUTION_SET_ID"/>
      </nstrgmpr:distributionSetId>
      <nstrgmpr:acctsPayCodeCombinationId>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:ACCTS_PAY_CODE_COMBINATION_ID"/>
      </nstrgmpr:acctsPayCodeCombinationId>
      <nstrgmpr:discLostCodeCombinationId>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:DISC_LOST_CODE_COMBINATION_ID"/>
      </nstrgmpr:discLostCodeCombinationId>
      <nstrgmpr:discTakenCodeCombinationId>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:DISC_TAKEN_CODE_COMBINATION_ID"/>
      </nstrgmpr:discTakenCodeCombinationId>
      <nstrgmpr:expenseCodeCombinationId>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:EXPENSE_CODE_COMBINATION_ID"/>
      </nstrgmpr:expenseCodeCombinationId>
      <nstrgmpr:prepayCodeCombinationId>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:PREPAY_CODE_COMBINATION_ID"/>
      </nstrgmpr:prepayCodeCombinationId>
      <nstrgmpr:num1099>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:NUM_1099"/>
      </nstrgmpr:num1099>
      <nstrgmpr:type1099>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:TYPE_1099"/>
      </nstrgmpr:type1099>
      <nstrgmpr:withholdingStatusLookupCode>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:WITHHOLDING_STATUS_LOOKUP_CODE"/>
      </nstrgmpr:withholdingStatusLookupCode>
      <nstrgmpr:withholdingStartDate>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:WITHHOLDING_START_DATE"/>
      </nstrgmpr:withholdingStartDate>
      <nstrgmpr:organizationTypeLookupCode>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:ORGANIZATION_TYPE_LOOKUP_CODE"/>
      </nstrgmpr:organizationTypeLookupCode>
      <nstrgmpr:vatCode>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:VAT_CODE"/>
      </nstrgmpr:vatCode>
      <nstrgmpr:startDateActive>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:START_DATE_ACTIVE"/>
      </nstrgmpr:startDateActive>
      <nstrgmpr:endDateActive>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:END_DATE_ACTIVE"/>
      </nstrgmpr:endDateActive>
      <nstrgmpr:minorityGroupLookupCode>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:MINORITY_GROUP_LOOKUP_CODE"/>
      </nstrgmpr:minorityGroupLookupCode>
      <nstrgmpr:paymentMethodLookupCode>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:PAYMENT_METHOD_LOOKUP_CODE"/>
      </nstrgmpr:paymentMethodLookupCode>
      <nstrgmpr:bankAccountName>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:BANK_ACCOUNT_NAME"/>
      </nstrgmpr:bankAccountName>
      <nstrgmpr:bankAccountNum>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:BANK_ACCOUNT_NUM"/>
      </nstrgmpr:bankAccountNum>
      <nstrgmpr:bankNum>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:BANK_NUM"/>
      </nstrgmpr:bankNum>
      <nstrgmpr:bankAccountType>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:BANK_ACCOUNT_TYPE"/>
      </nstrgmpr:bankAccountType>
      <nstrgmpr:womenOwnedFlag>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:WOMEN_OWNED_FLAG"/>
      </nstrgmpr:womenOwnedFlag>
      <nstrgmpr:smallBusinessFlag>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:SMALL_BUSINESS_FLAG"/>
      </nstrgmpr:smallBusinessFlag>
      <nstrgmpr:standardIndustryClass>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:STANDARD_INDUSTRY_CLASS"/>
      </nstrgmpr:standardIndustryClass>
      <nstrgmpr:holdFlag>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:HOLD_FLAG"/>
      </nstrgmpr:holdFlag>
      <nstrgmpr:purchasingHoldReason>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:PURCHASING_HOLD_REASON"/>
      </nstrgmpr:purchasingHoldReason>
      <nstrgmpr:holdBy>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:HOLD_BY"/>
      </nstrgmpr:holdBy>
      <nstrgmpr:holdDate>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:HOLD_DATE"/>
      </nstrgmpr:holdDate>
      <nstrgmpr:termsDateBasis>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:TERMS_DATE_BASIS"/>
      </nstrgmpr:termsDateBasis>
      <nstrgmpr:priceTolerance>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:PRICE_TOLERANCE"/>
      </nstrgmpr:priceTolerance>
      <nstrgmpr:inspectionRequiredFlag>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:INSPECTION_REQUIRED_FLAG"/>
      </nstrgmpr:inspectionRequiredFlag>
      <nstrgmpr:receiptRequiredFlag>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:RECEIPT_REQUIRED_FLAG"/>
      </nstrgmpr:receiptRequiredFlag>
      <nstrgmpr:qtyRcvTolerance>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:QTY_RCV_TOLERANCE"/>
      </nstrgmpr:qtyRcvTolerance>
      <nstrgmpr:qtyRcvExceptionCode>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:QTY_RCV_EXCEPTION_CODE"/>
      </nstrgmpr:qtyRcvExceptionCode>
      <nstrgmpr:enforceShipToLocationCode>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:ENFORCE_SHIP_TO_LOCATION_CODE"/>
      </nstrgmpr:enforceShipToLocationCode>
      <nstrgmpr:daysEarlyReceiptAllowed>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:DAYS_EARLY_RECEIPT_ALLOWED"/>
      </nstrgmpr:daysEarlyReceiptAllowed>
      <nstrgmpr:daysLateReceiptAllowed>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:DAYS_LATE_RECEIPT_ALLOWED"/>
      </nstrgmpr:daysLateReceiptAllowed>
      <nstrgmpr:receiptDaysExceptionCode>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:RECEIPT_DAYS_EXCEPTION_CODE"/>
      </nstrgmpr:receiptDaysExceptionCode>
      <nstrgmpr:receivingRoutingId>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:RECEIVING_ROUTING_ID"/>
      </nstrgmpr:receivingRoutingId>
      <nstrgmpr:allowSubstituteReceiptsFlag>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:ALLOW_SUBSTITUTE_RECEIPTS_FLAG"/>
      </nstrgmpr:allowSubstituteReceiptsFlag>
      <nstrgmpr:allowUnorderedReceiptsFlag>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:ALLOW_UNORDERED_RECEIPTS_FLAG"/>
      </nstrgmpr:allowUnorderedReceiptsFlag>
      <nstrgmpr:holdUnmatchedInvoicesFlag>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:HOLD_UNMATCHED_INVOICES_FLAG"/>
      </nstrgmpr:holdUnmatchedInvoicesFlag>
      <nstrgmpr:exclusivePaymentFlag>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:EXCLUSIVE_PAYMENT_FLAG"/>
      </nstrgmpr:exclusivePaymentFlag>
      <nstrgmpr:apTaxRoundingRule>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:AP_TAX_ROUNDING_RULE"/>
      </nstrgmpr:apTaxRoundingRule>
      <nstrgmpr:autoTaxCalcFlag>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:AUTO_TAX_CALC_FLAG"/>
      </nstrgmpr:autoTaxCalcFlag>
      <nstrgmpr:autoTaxCalcOverride>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:AUTO_TAX_CALC_OVERRIDE"/>
      </nstrgmpr:autoTaxCalcOverride>
      <nstrgmpr:amountIncludesTaxFlag>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:AMOUNT_INCLUDES_TAX_FLAG"/>
      </nstrgmpr:amountIncludesTaxFlag>
      <nstrgmpr:taxVerificationDate>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:TAX_VERIFICATION_DATE"/>
      </nstrgmpr:taxVerificationDate>
      <nstrgmpr:nameControl>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:NAME_CONTROL"/>
      </nstrgmpr:nameControl>
      <nstrgmpr:stateReportableFlag>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:STATE_REPORTABLE_FLAG"/>
      </nstrgmpr:stateReportableFlag>
      <nstrgmpr:federalReportableFlag>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:FEDERAL_REPORTABLE_FLAG"/>
      </nstrgmpr:federalReportableFlag>
      <nstrgmpr:attributeCategory>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE_CATEGORY"/>
      </nstrgmpr:attributeCategory>
      <nstrgmpr:attribute1>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE1"/>
      </nstrgmpr:attribute1>
      <nstrgmpr:attribute2>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE2"/>
      </nstrgmpr:attribute2>
      <nstrgmpr:attribute3>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE3"/>
      </nstrgmpr:attribute3>
      <nstrgmpr:attribute4>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE4"/>
      </nstrgmpr:attribute4>
      <nstrgmpr:attribute5>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE5"/>
      </nstrgmpr:attribute5>
      <nstrgmpr:attribute6>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE6"/>
      </nstrgmpr:attribute6>
      <nstrgmpr:attribute7>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE7"/>
      </nstrgmpr:attribute7>
      <nstrgmpr:attribute8>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE8"/>
      </nstrgmpr:attribute8>
      <nstrgmpr:attribute9>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE9"/>
      </nstrgmpr:attribute9>
      <nstrgmpr:attribute10>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE10"/>
      </nstrgmpr:attribute10>
      <nstrgmpr:attribute11>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE11"/>
      </nstrgmpr:attribute11>
      <nstrgmpr:attribute12>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE12"/>
      </nstrgmpr:attribute12>
      <nstrgmpr:attribute13>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE13"/>
      </nstrgmpr:attribute13>
      <nstrgmpr:attribute14>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE14"/>
      </nstrgmpr:attribute14>
      <nstrgmpr:attribute15>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:ATTRIBUTE15"/>
      </nstrgmpr:attribute15>
      <nstrgmpr:requestId>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:REQUEST_ID"/>
      </nstrgmpr:requestId>
      <nstrgmpr:programApplicationId>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:PROGRAM_APPLICATION_ID"/>
      </nstrgmpr:programApplicationId>
      <nstrgmpr:programId>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:PROGRAM_ID"/>
      </nstrgmpr:programId>
      <nstrgmpr:programUpdateDate>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:PROGRAM_UPDATE_DATE"/>
      </nstrgmpr:programUpdateDate>
      <nstrgmpr:offsetVatCode>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:OFFSET_VAT_CODE"/>
      </nstrgmpr:offsetVatCode>
      <nstrgmpr:vatRegistrationNum>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:VAT_REGISTRATION_NUM"/>
      </nstrgmpr:vatRegistrationNum>
      <nstrgmpr:autoCalculateInterestFlag>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:AUTO_CALCULATE_INTEREST_FLAG"/>
      </nstrgmpr:autoCalculateInterestFlag>
      <nstrgmpr:validationNumber>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:VALIDATION_NUMBER"/>
      </nstrgmpr:validationNumber>
      <nstrgmpr:excludeFreightFromDiscount>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:EXCLUDE_FREIGHT_FROM_DISCOUNT"/>
      </nstrgmpr:excludeFreightFromDiscount>
      <nstrgmpr:taxReportingName>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:TAX_REPORTING_NAME"/>
      </nstrgmpr:taxReportingName>
      <nstrgmpr:checkDigits>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:CHECK_DIGITS"/>
      </nstrgmpr:checkDigits>
      <nstrgmpr:bankNumber>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:BANK_NUMBER"/>
      </nstrgmpr:bankNumber>
      <nstrgmpr:allowAwtFlag>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:ALLOW_AWT_FLAG"/>
      </nstrgmpr:allowAwtFlag>
      <nstrgmpr:awtGroupId>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:AWT_GROUP_ID"/>
      </nstrgmpr:awtGroupId>
      <nstrgmpr:globalAttribute1>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE1"/>
      </nstrgmpr:globalAttribute1>
      <nstrgmpr:globalAttribute2>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE2"/>
      </nstrgmpr:globalAttribute2>
      <nstrgmpr:globalAttribute3>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE3"/>
      </nstrgmpr:globalAttribute3>
      <nstrgmpr:globalAttribute4>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE4"/>
      </nstrgmpr:globalAttribute4>
      <nstrgmpr:globalAttribute5>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE5"/>
      </nstrgmpr:globalAttribute5>
      <nstrgmpr:globalAttribute6>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE6"/>
      </nstrgmpr:globalAttribute6>
      <nstrgmpr:globalAttribute7>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE7"/>
      </nstrgmpr:globalAttribute7>
      <nstrgmpr:globalAttribute8>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE8"/>
      </nstrgmpr:globalAttribute8>
      <nstrgmpr:globalAttribute9>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE9"/>
      </nstrgmpr:globalAttribute9>
      <nstrgmpr:globalAttribute10>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE10"/>
      </nstrgmpr:globalAttribute10>
      <nstrgmpr:globalAttribute11>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE11"/>
      </nstrgmpr:globalAttribute11>
      <nstrgmpr:globalAttribute12>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE12"/>
      </nstrgmpr:globalAttribute12>
      <nstrgmpr:globalAttribute13>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE13"/>
      </nstrgmpr:globalAttribute13>
      <nstrgmpr:globalAttribute14>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE14"/>
      </nstrgmpr:globalAttribute14>
      <nstrgmpr:globalAttribute15>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE15"/>
      </nstrgmpr:globalAttribute15>
      <nstrgmpr:globalAttribute16>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE16"/>
      </nstrgmpr:globalAttribute16>
      <nstrgmpr:globalAttribute17>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE17"/>
      </nstrgmpr:globalAttribute17>
      <nstrgmpr:globalAttribute18>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE18"/>
      </nstrgmpr:globalAttribute18>
      <nstrgmpr:globalAttribute19>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE19"/>
      </nstrgmpr:globalAttribute19>
      <nstrgmpr:globalAttribute20>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE20"/>
      </nstrgmpr:globalAttribute20>
      <nstrgmpr:globalAttributeCategory>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:GLOBAL_ATTRIBUTE_CATEGORY"/>
      </nstrgmpr:globalAttributeCategory>
      <nstrgmpr:ediTransactionHandling>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:EDI_TRANSACTION_HANDLING"/>
      </nstrgmpr:ediTransactionHandling>
      <nstrgmpr:ediPaymentMethod>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:EDI_PAYMENT_METHOD"/>
      </nstrgmpr:ediPaymentMethod>
      <nstrgmpr:ediPaymentFormat>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:EDI_PAYMENT_FORMAT"/>
      </nstrgmpr:ediPaymentFormat>
      <nstrgmpr:ediRemittanceMethod>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:EDI_REMITTANCE_METHOD"/>
      </nstrgmpr:ediRemittanceMethod>
      <nstrgmpr:ediRemittanceInstruction>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:EDI_REMITTANCE_INSTRUCTION"/>
      </nstrgmpr:ediRemittanceInstruction>
      <nstrgmpr:bankChargeBearer>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:BANK_CHARGE_BEARER"/>
      </nstrgmpr:bankChargeBearer>
      <nstrgmpr:bankBranchType>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:BANK_BRANCH_TYPE"/>
      </nstrgmpr:bankBranchType>
      <nstrgmpr:matchOption>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:MATCH_OPTION"/>
      </nstrgmpr:matchOption>
      <nstrgmpr:futureDatedPaymentCcid>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:FUTURE_DATED_PAYMENT_CCID"/>
      </nstrgmpr:futureDatedPaymentCcid>
      <nstrgmpr:createDebitMemoFlag>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:CREATE_DEBIT_MEMO_FLAG"/>
      </nstrgmpr:createDebitMemoFlag>
      <nstrgmpr:offsetTaxFlag>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:OFFSET_TAX_FLAG"/>
      </nstrgmpr:offsetTaxFlag>
      <nstrgmpr:partyId>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:PARTY_ID"/>
      </nstrgmpr:partyId>
      <nstrgmpr:parentPartyId>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:PARENT_PARTY_ID"/>
      </nstrgmpr:parentPartyId>
      <nstrgmpr:niNumber>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:NI_NUMBER"/>
      </nstrgmpr:niNumber>
      <nstrgmpr:tcaSyncNum1099>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:TCA_SYNC_NUM_1099"/>
      </nstrgmpr:tcaSyncNum1099>
      <nstrgmpr:tcaSyncVendorName>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:TCA_SYNC_VENDOR_NAME"/>
      </nstrgmpr:tcaSyncVendorName>
      <nstrgmpr:tcaSyncVatRegNum>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:TCA_SYNC_VAT_REG_NUM"/>
      </nstrgmpr:tcaSyncVatRegNum>
      <nstrgmpr:uniqueTaxReferenceNum>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:UNIQUE_TAX_REFERENCE_NUM"/>
      </nstrgmpr:uniqueTaxReferenceNum>
      <nstrgmpr:partnershipUtr>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:PARTNERSHIP_UTR"/>
      </nstrgmpr:partnershipUtr>
      <nstrgmpr:partnershipName>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:PARTNERSHIP_NAME"/>
      </nstrgmpr:partnershipName>
      <nstrgmpr:cisEnabledFlag>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:CIS_ENABLED_FLAG"/>
      </nstrgmpr:cisEnabledFlag>
      <nstrgmpr:firstName>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:FIRST_NAME"/>
      </nstrgmpr:firstName>
      <nstrgmpr:secondName>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:SECOND_NAME"/>
      </nstrgmpr:secondName>
      <nstrgmpr:lastName>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:LAST_NAME"/>
      </nstrgmpr:lastName>
      <nstrgmpr:salutation>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:SALUTATION"/>
      </nstrgmpr:salutation>
      <nstrgmpr:tradingName>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:TRADING_NAME"/>
      </nstrgmpr:tradingName>
      <nstrgmpr:workReference>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:WORK_REFERENCE"/>
      </nstrgmpr:workReference>
      <nstrgmpr:companyRegistrationNumber>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:COMPANY_REGISTRATION_NUMBER"/>
      </nstrgmpr:companyRegistrationNumber>
      <nstrgmpr:nationalInsuranceNumber>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:NATIONAL_INSURANCE_NUMBER"/>
      </nstrgmpr:nationalInsuranceNumber>
      <nstrgmpr:verificationNumber>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:VERIFICATION_NUMBER"/>
      </nstrgmpr:verificationNumber>
      <nstrgmpr:verificationRequestId>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:VERIFICATION_REQUEST_ID"/>
      </nstrgmpr:verificationRequestId>
      <nstrgmpr:matchStatusFlag>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:MATCH_STATUS_FLAG"/>
      </nstrgmpr:matchStatusFlag>
      <nstrgmpr:cisVerificationDate>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:CIS_VERIFICATION_DATE"/>
      </nstrgmpr:cisVerificationDate>
      <nstrgmpr:individual1099>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:INDIVIDUAL_1099"/>
      </nstrgmpr:individual1099>
      <nstrgmpr:payAwtGroupId>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:PAY_AWT_GROUP_ID"/>
      </nstrgmpr:payAwtGroupId>
      <nstrgmpr:cisParentVendorId>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:CIS_PARENT_VENDOR_ID"/>
      </nstrgmpr:cisParentVendorId>
      <nstrgmpr:busClassLastCertifiedDate>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:BUS_CLASS_LAST_CERTIFIED_DATE"/>
      </nstrgmpr:busClassLastCertifiedDate>
      <nstrgmpr:busClassLastCertifiedBy>
        <xsl:value-of select="$GetData/nsmpr0:GetDataOutputCollection/nsmpr0:GetDataOutput/nsmpr0:BUS_CLASS_LAST_CERTIFIED_BY"/>
      </nstrgmpr:busClassLastCertifiedBy>
    </nstrgmpr:vendor>
  </xsl:template>

</xsl:stylesheet>
