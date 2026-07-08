<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:nstrgmpr="http://vendor.site.structure"
                xmlns:nsmpr0="http://source.data">

  <xsl:template match="/">
    <nstrgmpr:vendorSite>
      <nstrgmpr:vendorSiteId>
        <xsl:value-of select="nsmpr0:VENDOR_SITE_ID"/>
      </nstrgmpr:vendorSiteId>
      <nstrgmpr:lastUpdateDate>
        <xsl:value-of select="nsmpr0:LAST_UPDATE_DATE"/>
      </nstrgmpr:lastUpdateDate>
      <nstrgmpr:lastUpdatedBy>
        <xsl:value-of select="nsmpr0:LAST_UPDATED_BY"/>
      </nstrgmpr:lastUpdatedBy>
      <nstrgmpr:vendorId>
        <xsl:value-of select="nsmpr0:VENDOR_ID"/>
      </nstrgmpr:vendorId>
      <nstrgmpr:vendorSiteCode>
        <xsl:value-of select="nsmpr0:VENDOR_SITE_CODE"/>
      </nstrgmpr:vendorSiteCode>
      <nstrgmpr:vendorSiteCodeAlt>
        <xsl:value-of select="nsmpr0:VENDOR_SITE_CODE_ALT"/>
      </nstrgmpr:vendorSiteCodeAlt>
      <nstrgmpr:lastUpdateLogin>
        <xsl:value-of select="nsmpr0:LAST_UPDATE_LOGIN"/>
      </nstrgmpr:lastUpdateLogin>
      <nstrgmpr:creationDate>
        <xsl:value-of select="nsmpr0:CREATION_DATE"/>
      </nstrgmpr:creationDate>
      <nstrgmpr:createdBy>
        <xsl:value-of select="nsmpr0:CREATED_BY"/>
      </nstrgmpr:createdBy>
      <nstrgmpr:purchasingSiteFlag>
        <xsl:value-of select="nsmpr0:PURCHASING_SITE_FLAG"/>
      </nstrgmpr:purchasingSiteFlag>
      <nstrgmpr:rfqOnlySiteFlag>
        <xsl:value-of select="nsmpr0:RFQ_ONLY_SITE_FLAG"/>
      </nstrgmpr:rfqOnlySiteFlag>
      <nstrgmpr:paySiteFlag>
        <xsl:value-of select="nsmpr0:PAY_SITE_FLAG"/>
      </nstrgmpr:paySiteFlag>
      <nstrgmpr:attentionArFlag>
        <xsl:value-of select="nsmpr0:ATTENTION_AR_FLAG"/>
      </nstrgmpr:attentionArFlag>
      <nstrgmpr:addressLine1>
        <xsl:value-of select="nsmpr0:ADDRESS_LINE1"/>
      </nstrgmpr:addressLine1>
      <nstrgmpr:addressLinesAlt>
        <xsl:value-of select="nsmpr0:ADDRESS_LINES_ALT"/>
      </nstrgmpr:addressLinesAlt>
      <nstrgmpr:addressLine2>
        <xsl:value-of select="nsmpr0:ADDRESS_LINE2"/>
      </nstrgmpr:addressLine2>
      <nstrgmpr:addressLine3>
        <xsl:value-of select="nsmpr0:ADDRESS_LINE3"/>
      </nstrgmpr:addressLine3>
      <nstrgmpr:city>
        <xsl:value-of select="nsmpr0:CITY"/>
      </nstrgmpr:city>
      <nstrgmpr:state>
        <xsl:value-of select="nsmpr0:STATE"/>
      </nstrgmpr:state>
      <nstrgmpr:zip>
        <xsl:value-of select="nsmpr0:ZIP"/>
      </nstrgmpr:zip>
      <nstrgmpr:province>
        <xsl:value-of select="nsmpr0:PROVINCE"/>
      </nstrgmpr:province>
      <nstrgmpr:country>
        <xsl:value-of select="nsmpr0:COUNTRY"/>
      </nstrgmpr:country>
      <nstrgmpr:areaCode>
        <xsl:value-of select="nsmpr0:AREA_CODE"/>
      </nstrgmpr:areaCode>
      <nstrgmpr:phone>
        <xsl:value-of select="nsmpr0:PHONE"/>
      </nstrgmpr:phone>
      <nstrgmpr:customerNum>
        <xsl:value-of select="nsmpr0:CUSTOMER_NUM"/>
      </nstrgmpr:customerNum>
      <nstrgmpr:shipToLocationId>
        <xsl:value-of select="nsmpr0:SHIP_TO_LOCATION_ID"/>
      </nstrgmpr:shipToLocationId>
      <nstrgmpr:billToLocationId>
        <xsl:value-of select="nsmpr0:BILL_TO_LOCATION_ID"/>
      </nstrgmpr:billToLocationId>
      <nstrgmpr:shipViaLookupCode>
        <xsl:value-of select="nsmpr0:SHIP_VIA_LOOKUP_CODE"/>
      </nstrgmpr:shipViaLookupCode>
      <nstrgmpr:freightTermsLookupCode>
        <xsl:value-of select="nsmpr0:FREIGHT_TERMS_LOOKUP_CODE"/>
      </nstrgmpr:freightTermsLookupCode>
      <nstrgmpr:fobLookupCode>
        <xsl:value-of select="nsmpr0:FOB_LOOKUP_CODE"/>
      </nstrgmpr:fobLookupCode>
      <nstrgmpr:inactiveDate>
        <xsl:value-of select="nsmpr0:INACTIVE_DATE"/>
      </nstrgmpr:inactiveDate>
      <nstrgmpr:fax>
        <xsl:value-of select="nsmpr0:FAX"/>
      </nstrgmpr:fax>
      <nstrgmpr:faxAreaCode>
        <xsl:value-of select="nsmpr0:FAX_AREA_CODE"/>
      </nstrgmpr:faxAreaCode>
      <nstrgmpr:telex>
        <xsl:value-of select="nsmpr0:TELEX"/>
      </nstrgmpr:telex>
      <nstrgmpr:paymentMethodLookupCode>
        <xsl:value-of select="nsmpr0:PAYMENT_METHOD_LOOKUP_CODE"/>
      </nstrgmpr:paymentMethodLookupCode>
      <nstrgmpr:bankAccountName>
        <xsl:value-of select="nsmpr0:BANK_ACCOUNT_NAME"/>
      </nstrgmpr:bankAccountName>
      <nstrgmpr:bankAccountNum>
        <xsl:value-of select="nsmpr0:BANK_ACCOUNT_NUM"/>
      </nstrgmpr:bankAccountNum>
      <nstrgmpr:bankNum>
        <xsl:value-of select="nsmpr0:BANK_NUM"/>
      </nstrgmpr:bankNum>
      <nstrgmpr:bankAccountType>
        <xsl:value-of select="nsmpr0:BANK_ACCOUNT_TYPE"/>
      </nstrgmpr:bankAccountType>
      <nstrgmpr:termsDateBasis>
        <xsl:value-of select="nsmpr0:TERMS_DATE_BASIS"/>
      </nstrgmpr:termsDateBasis>
      <nstrgmpr:currentCatalogNum>
        <xsl:value-of select="nsmpr0:CURRENT_CATALOG_NUM"/>
      </nstrgmpr:currentCatalogNum>
      <nstrgmpr:vatCode>
        <xsl:value-of select="nsmpr0:VAT_CODE"/>
      </nstrgmpr:vatCode>
      <nstrgmpr:distributionSetId>
        <xsl:value-of select="nsmpr0:DISTRIBUTION_SET_ID"/>
      </nstrgmpr:distributionSetId>
      <nstrgmpr:acctsPayCodeCombinationId>
        <xsl:value-of select="nsmpr0:ACCTS_PAY_CODE_COMBINATION_ID"/>
      </nstrgmpr:acctsPayCodeCombinationId>
      <nstrgmpr:prepayCodeCombinationId>
        <xsl:value-of select="nsmpr0:PREPAY_CODE_COMBINATION_ID"/>
      </nstrgmpr:prepayCodeCombinationId>
      <nstrgmpr:payGroupLookupCode>
        <xsl:value-of select="nsmpr0:PAY_GROUP_LOOKUP_CODE"/>
      </nstrgmpr:payGroupLookupCode>
      <nstrgmpr:paymentPriority>
        <xsl:value-of select="nsmpr0:PAYMENT_PRIORITY"/>
      </nstrgmpr:paymentPriority>
      <nstrgmpr:termsId>
        <xsl:value-of select="nsmpr0:TERMS_ID"/>
      </nstrgmpr:termsId>
      <nstrgmpr:invoiceAmountLimit>
        <xsl:value-of select="nsmpr0:INVOICE_AMOUNT_LIMIT"/>
      </nstrgmpr:invoiceAmountLimit>
      <nstrgmpr:payDateBasisLookupCode>
        <xsl:value-of select="nsmpr0:PAY_DATE_BASIS_LOOKUP_CODE"/>
      </nstrgmpr:payDateBasisLookupCode>
      <nstrgmpr:alwaysTakeDiscFlag>
        <xsl:value-of select="nsmpr0:ALWAYS_TAKE_DISC_FLAG"/>
      </nstrgmpr:alwaysTakeDiscFlag>
      <nstrgmpr:invoiceCurrencyCode>
        <xsl:value-of select="nsmpr0:INVOICE_CURRENCY_CODE"/>
      </nstrgmpr:invoiceCurrencyCode>
      <nstrgmpr:paymentCurrencyCode>
        <xsl:value-of select="nsmpr0:PAYMENT_CURRENCY_CODE"/>
      </nstrgmpr:paymentCurrencyCode>
      <nstrgmpr:holdAllPaymentsFlag>
        <xsl:value-of select="nsmpr0:HOLD_ALL_PAYMENTS_FLAG"/>
      </nstrgmpr:holdAllPaymentsFlag>
      <nstrgmpr:holdFuturePaymentsFlag>
        <xsl:value-of select="nsmpr0:HOLD_FUTURE_PAYMENTS_FLAG"/>
      </nstrgmpr:holdFuturePaymentsFlag>
      <nstrgmpr:holdReason>
        <xsl:value-of select="nsmpr0:HOLD_REASON"/>
      </nstrgmpr:holdReason>
      <nstrgmpr:holdUnmatchedInvoicesFlag>
        <xsl:value-of select="nsmpr0:HOLD_UNMATCHED_INVOICES_FLAG"/>
      </nstrgmpr:holdUnmatchedInvoicesFlag>
      <nstrgmpr:apTaxRoundingRule>
        <xsl:value-of select="nsmpr0:AP_TAX_ROUNDING_RULE"/>
      </nstrgmpr:apTaxRoundingRule>
      <nstrgmpr:autoTaxCalcFlag>
        <xsl:value-of select="nsmpr0:AUTO_TAX_CALC_FLAG"/>
      </nstrgmpr:autoTaxCalcFlag>
      <nstrgmpr:autoTaxCalcOverride>
        <xsl:value-of select="nsmpr0:AUTO_TAX_CALC_OVERRIDE"/>
      </nstrgmpr:autoTaxCalcOverride>
      <nstrgmpr:amountIncludesTaxFlag>
        <xsl:value-of select="nsmpr0:AMOUNT_INCLUDES_TAX_FLAG"/>
      </nstrgmpr:amountIncludesTaxFlag>
      <nstrgmpr:exclusivePaymentFlag>
        <xsl:value-of select="nsmpr0:EXCLUSIVE_PAYMENT_FLAG"/>
      </nstrgmpr:exclusivePaymentFlag>
      <nstrgmpr:taxReportingSiteFlag>
        <xsl:value-of select="nsmpr0:TAX_REPORTING_SITE_FLAG"/>
      </nstrgmpr:taxReportingSiteFlag>
      <nstrgmpr:attributeCategory>
        <xsl:value-of select="nsmpr0:ATTRIBUTE_CATEGORY"/>
      </nstrgmpr:attributeCategory>
      <nstrgmpr:attribute1>
        <xsl:value-of select="nsmpr0:ATTRIBUTE1"/>
      </nstrgmpr:attribute1>
      <nstrgmpr:attribute2>
        <xsl:value-of select="nsmpr0:ATTRIBUTE2"/>
      </nstrgmpr:attribute2>
      <nstrgmpr:attribute3>
        <xsl:value-of select="nsmpr0:ATTRIBUTE3"/>
      </nstrgmpr:attribute3>
      <nstrgmpr:attribute4>
        <xsl:value-of select="nsmpr0:ATTRIBUTE4"/>
      </nstrgmpr:attribute4>
      <nstrgmpr:attribute5>
        <xsl:value-of select="nsmpr0:ATTRIBUTE5"/>
      </nstrgmpr:attribute5>
      <nstrgmpr:attribute6>
        <xsl:value-of select="nsmpr0:ATTRIBUTE6"/>
      </nstrgmpr:attribute6>
      <nstrgmpr:attribute7>
        <xsl:value-of select="nsmpr0:ATTRIBUTE7"/>
      </nstrgmpr:attribute7>
      <nstrgmpr:attribute8>
        <xsl:value-of select="nsmpr0:ATTRIBUTE8"/>
      </nstrgmpr:attribute8>
      <nstrgmpr:attribute9>
        <xsl:value-of select="nsmpr0:ATTRIBUTE9"/>
      </nstrgmpr:attribute9>
      <nstrgmpr:attribute10>
        <xsl:value-of select="nsmpr0:ATTRIBUTE10"/>
      </nstrgmpr:attribute10>
      <nstrgmpr:attribute11>
        <xsl:value-of select="nsmpr0:ATTRIBUTE11"/>
      </nstrgmpr:attribute11>
      <nstrgmpr:attribute12>
        <xsl:value-of select="nsmpr0:ATTRIBUTE12"/>
      </nstrgmpr:attribute12>
      <nstrgmpr:attribute13>
        <xsl:value-of select="nsmpr0:ATTRIBUTE13"/>
      </nstrgmpr:attribute13>
      <nstrgmpr:attribute14>
        <xsl:value-of select="nsmpr0:ATTRIBUTE14"/>
      </nstrgmpr:attribute14>
      <nstrgmpr:attribute15>
        <xsl:value-of select="nsmpr0:ATTRIBUTE15"/>
      </nstrgmpr:attribute15>
      <nstrgmpr:requestId>
        <xsl:value-of select="nsmpr0:REQUEST_ID"/>
      </nstrgmpr:requestId>
      <nstrgmpr:programApplicationId>
        <xsl:value-of select="nsmpr0:PROGRAM_APPLICATION_ID"/>
      </nstrgmpr:programApplicationId>
      <nstrgmpr:programId>
        <xsl:value-of select="nsmpr0:PROGRAM_ID"/>
      </nstrgmpr:programId>
      <nstrgmpr:programUpdateDate>
        <xsl:value-of select="nsmpr0:PROGRAM_UPDATE_DATE"/>
      </nstrgmpr:programUpdateDate>
      <nstrgmpr:validationNumber>
        <xsl:value-of select="nsmpr0:VALIDATION_NUMBER"/>
      </nstrgmpr:validationNumber>
      <nstrgmpr:excludeFreightFromDiscount>
        <xsl:value-of select="nsmpr0:EXCLUDE_FREIGHT_FROM_DISCOUNT"/>
      </nstrgmpr:excludeFreightFromDiscount>
      <nstrgmpr:vatRegistrationNum>
        <xsl:value-of select="nsmpr0:VAT_REGISTRATION_NUM"/>
      </nstrgmpr:vatRegistrationNum>
      <nstrgmpr:offsetVatCode>
        <xsl:value-of select="nsmpr0:OFFSET_VAT_CODE"/>
      </nstrgmpr:offsetVatCode>
      <nstrgmpr:orgId>
        <xsl:value-of select="nsmpr0:ORG_ID"/>
      </nstrgmpr:orgId>
      <nstrgmpr:checkDigits>
        <xsl:value-of select="nsmpr0:CHECK_DIGITS"/>
      </nstrgmpr:checkDigits>
      <nstrgmpr:bankNumber>
        <xsl:value-of select="nsmpr0:BANK_NUMBER"/>
      </nstrgmpr:bankNumber>
      <nstrgmpr:addressLine4>
        <xsl:value-of select="nsmpr0:ADDRESS_LINE4"/>
      </nstrgmpr:addressLine4>
      <nstrgmpr:county>
        <xsl:value-of select="nsmpr0:COUNTY"/>
      </nstrgmpr:county>
      <nstrgmpr:addressStyle>
        <xsl:value-of select="nsmpr0:ADDRESS_STYLE"/>
      </nstrgmpr:addressStyle>
      <nstrgmpr:language>
        <xsl:value-of select="nsmpr0:LANGUAGE"/>
      </nstrgmpr:language>
      <nstrgmpr:allowAwtFlag>
        <xsl:value-of select="nsmpr0:ALLOW_AWT_FLAG"/>
      </nstrgmpr:allowAwtFlag>
      <nstrgmpr:awtGroupId>
        <xsl:value-of select="nsmpr0:AWT_GROUP_ID"/>
      </nstrgmpr:awtGroupId>
      <nstrgmpr:globalAttribute1>
        <xsl:value-of select="nsmpr0:GLOBAL_ATTRIBUTE1"/>
      </nstrgmpr:globalAttribute1>
      <nstrgmpr:globalAttribute2>
        <xsl:value-of select="nsmpr0:GLOBAL_ATTRIBUTE2"/>
      </nstrgmpr:globalAttribute2>
      <nstrgmpr:globalAttribute3>
        <xsl:value-of select="nsmpr0:GLOBAL_ATTRIBUTE3"/>
      </nstrgmpr:globalAttribute3>
      <nstrgmpr:globalAttribute4>
        <xsl:value-of select="nsmpr0:GLOBAL_ATTRIBUTE4"/>
      </nstrgmpr:globalAttribute4>
      <nstrgmpr:globalAttribute5>
        <xsl:value-of select="nsmpr0:GLOBAL_ATTRIBUTE5"/>
      </nstrgmpr:globalAttribute5>
      <nstrgmpr:globalAttribute6>
        <xsl:value-of select="nsmpr0:GLOBAL_ATTRIBUTE6"/>
      </nstrgmpr:globalAttribute6>
      <nstrgmpr:globalAttribute7>
        <xsl:value-of select="nsmpr0:GLOBAL_ATTRIBUTE7"/>
      </nstrgmpr:globalAttribute7>
      <nstrgmpr:globalAttribute8>
        <xsl:value-of select="nsmpr0:GLOBAL_ATTRIBUTE8"/>
      </nstrgmpr:globalAttribute8>
      <nstrgmpr:globalAttribute9>
        <xsl:value-of select="nsmpr0:GLOBAL_ATTRIBUTE9"/>
      </nstrgmpr:globalAttribute9>
      <nstrgmpr:globalAttribute10>
        <xsl:value-of select="nsmpr0:GLOBAL_ATTRIBUTE10"/>
      </nstrgmpr:globalAttribute10>
      <nstrgmpr:globalAttribute11>
        <xsl:value-of select="nsmpr0:GLOBAL_ATTRIBUTE11"/>
      </nstrgmpr:globalAttribute11>
      <nstrgmpr:globalAttribute12>
        <xsl:value-of select="nsmpr0:GLOBAL_ATTRIBUTE12"/>
      </nstrgmpr:globalAttribute12>
      <nstrgmpr:globalAttribute13>
        <xsl:value-of select="nsmpr0:GLOBAL_ATTRIBUTE13"/>
      </nstrgmpr:globalAttribute13>
      <nstrgmpr:globalAttribute14>
        <xsl:value-of select="nsmpr0:GLOBAL_ATTRIBUTE14"/>
      </nstrgmpr:globalAttribute14>
      <nstrgmpr:globalAttribute15>
        <xsl:value-of select="nsmpr0:GLOBAL_ATTRIBUTE15"/>
      </nstrgmpr:globalAttribute15>
      <nstrgmpr:globalAttribute16>
        <xsl:value-of select="nsmpr0:GLOBAL_ATTRIBUTE16"/>
      </nstrgmpr:globalAttribute16>
      <nstrgmpr:globalAttribute17>
        <xsl:value-of select="nsmpr0:GLOBAL_ATTRIBUTE17"/>
      </nstrgmpr:globalAttribute17>
      <nstrgmpr:globalAttribute18>
        <xsl:value-of select="nsmpr0:GLOBAL_ATTRIBUTE18"/>
      </nstrgmpr:globalAttribute18>
      <nstrgmpr:globalAttribute19>
        <xsl:value-of select="nsmpr0:GLOBAL_ATTRIBUTE19"/>
      </nstrgmpr:globalAttribute19>
      <nstrgmpr:globalAttribute20>
        <xsl:value-of select="nsmpr0:GLOBAL_ATTRIBUTE20"/>
      </nstrgmpr:globalAttribute20>
      <nstrgmpr:globalAttributeCategory>
        <xsl:value-of select="nsmpr0:GLOBAL_ATTRIBUTE_CATEGORY"/>
      </nstrgmpr:globalAttributeCategory>
      <nstrgmpr:ediTransactionHandling>
        <xsl:value-of select="nsmpr0:EDI_TRANSACTION_HANDLING"/>
      </nstrgmpr:ediTransactionHandling>
      <nstrgmpr:ediIdNumber>
        <xsl:value-of select="nsmpr0:EDI_ID_NUMBER"/>
      </nstrgmpr:ediIdNumber>
      <nstrgmpr:ediPaymentMethod>
        <xsl:value-of select="nsmpr0:EDI_PAYMENT_METHOD"/>
      </nstrgmpr:ediPaymentMethod>
      <nstrgmpr:ediPaymentFormat>
        <xsl:value-of select="nsmpr0:EDI_PAYMENT_FORMAT"/>
      </nstrgmpr:ediPaymentFormat>
      <nstrgmpr:ediRemittanceMethod>
        <xsl:value-of select="nsmpr0:EDI_REMITTANCE_METHOD"/>
      </nstrgmpr:ediRemittanceMethod>
      <nstrgmpr:bankChargeBearer>
        <xsl:value-of select="nsmpr0:BANK_CHARGE_BEARER"/>
      </nstrgmpr:bankChargeBearer>
      <nstrgmpr:ediRemittanceInstruction>
        <xsl:value-of select="nsmpr0:EDI_REMITTANCE_INSTRUCTION"/>
      </nstrgmpr:ediRemittanceInstruction>
      <nstrgmpr:bankBranchType>
        <xsl:value-of select="nsmpr0:BANK_BRANCH_TYPE"/>
      </nstrgmpr:bankBranchType>
      <nstrgmpr:payOnCode>
        <xsl:value-of select="nsmpr0:PAY_ON_CODE"/>
      </nstrgmpr:payOnCode>
      <nstrgmpr:defaultPaySiteId>
        <xsl:value-of select="nsmpr0:DEFAULT_PAY_SITE_ID"/>
      </nstrgmpr:defaultPaySiteId>
      <nstrgmpr:payOnReceiptSummaryCode>
        <xsl:value-of select="nsmpr0:PAY_ON_RECEIPT_SUMMARY_CODE"/>
      </nstrgmpr:payOnReceiptSummaryCode>
      <nstrgmpr:tpHeaderId>
        <xsl:value-of select="nsmpr0:TP_HEADER_ID"/>
      </nstrgmpr:tpHeaderId>
      <nstrgmpr:eceTpLocationCode>
        <xsl:value-of select="nsmpr0:ECE_TP_LOCATION_CODE"/>
      </nstrgmpr:eceTpLocationCode>
      <nstrgmpr:pcardSiteFlag>
        <xsl:value-of select="nsmpr0:PCARD_SITE_FLAG"/>
      </nstrgmpr:pcardSiteFlag>
      <nstrgmpr:matchOption>
        <xsl:value-of select="nsmpr0:MATCH_OPTION"/>
      </nstrgmpr:matchOption>
      <nstrgmpr:countryOfOriginCode>
        <xsl:value-of select="nsmpr0:COUNTRY_OF_ORIGIN_CODE"/>
      </nstrgmpr:countryOfOriginCode>
      <nstrgmpr:futureDatedPaymentCcid>
        <xsl:value-of select="nsmpr0:FUTURE_DATED_PAYMENT_CCID"/>
      </nstrgmpr:futureDatedPaymentCcid>
      <nstrgmpr:createDebitMemoFlag>
        <xsl:value-of select="nsmpr0:CREATE_DEBIT_MEMO_FLAG"/>
      </nstrgmpr:createDebitMemoFlag>
      <nstrgmpr:offsetTaxFlag>
        <xsl:value-of select="nsmpr0:OFFSET_TAX_FLAG"/>
      </nstrgmpr:offsetTaxFlag>
      <nstrgmpr:supplierNotifMethod>
        <xsl:value-of select="nsmpr0:SUPPLIER_NOTIF_METHOD"/>
      </nstrgmpr:supplierNotifMethod>
      <nstrgmpr:emailAddress>
        <xsl:value-of select="nsmpr0:EMAIL_ADDRESS"/>
      </nstrgmpr:emailAddress>
      <nstrgmpr:remittanceEmail>
        <xsl:value-of select="nsmpr0:REMITTANCE_EMAIL"/>
      </nstrgmpr:remittanceEmail>
      <nstrgmpr:primaryPaySiteFlag>
        <xsl:value-of select="nsmpr0:PRIMARY_PAY_SITE_FLAG"/>
      </nstrgmpr:primaryPaySiteFlag>
      <nstrgmpr:shippingControl>
        <xsl:value-of select="nsmpr0:SHIPPING_CONTROL"/>
      </nstrgmpr:shippingControl>
      <nstrgmpr:sellingCompanyIdentifier>
        <xsl:value-of select="nsmpr0:SELLING_COMPANY_IDENTIFIER"/>
      </nstrgmpr:sellingCompanyIdentifier>
      <nstrgmpr:gaplessInvNumFlag>
        <xsl:value-of select="nsmpr0:GAPLESS_INV_NUM_FLAG"/>
      </nstrgmpr:gaplessInvNumFlag>
      <nstrgmpr:dunsNumber>
        <xsl:value-of select="nsmpr0:DUNS_NUMBER"/>
      </nstrgmpr:dunsNumber>
      <nstrgmpr:toleranceId>
        <xsl:value-of select="nsmpr0:TOLERANCE_ID"/>
      </nstrgmpr:toleranceId>
      <nstrgmpr:locationId>
        <xsl:value-of select="nsmpr0:LOCATION_ID"/>
      </nstrgmpr:locationId>
      <nstrgmpr:partySiteId>
        <xsl:value-of select="nsmpr0:PARTY_SITE_ID"/>
      </nstrgmpr:partySiteId>
      <nstrgmpr:servicestoleranceId>
        <xsl:value-of select="nsmpr0:SERVICES_TOLERANCE_ID"/>
      </nstrgmpr:servicestoleranceId>
      <nstrgmpr:retainageRate>
        <xsl:value-of select="nsmpr0:RETAINAGE_RATE"/>
      </nstrgmpr:retainageRate>
      <nstrgmpr:tcaSyncState>
        <xsl:value-of select="nsmpr0:TCA_SYNC_STATE"/>
      </nstrgmpr:tcaSyncState>
      <nstrgmpr:tcaSyncProvince>
        <xsl:value-of select="nsmpr0:TCA_SYNC_PROVINCE"/>
      </nstrgmpr:tcaSyncProvince>
      <nstrgmpr:tcaSyncCounty>
        <xsl:value-of select="nsmpr0:TCA_SYNC_COUNTY"/>
      </nstrgmpr:tcaSyncCounty>
      <nstrgmpr:tcaSyncCity>
        <xsl:value-of select="nsmpr0:TCA_SYNC_CITY"/>
      </nstrgmpr:tcaSyncCity>
      <nstrgmpr:tcaSyncZip>
        <xsl:value-of select="nsmpr0:TCA_SYNC_ZIP"/>
      </nstrgmpr:tcaSyncZip>
      <nstrgmpr:tcaSyncCountry>
        <xsl:value-of select="nsmpr0:TCA_SYNC_COUNTRY"/>
      </nstrgmpr:tcaSyncCountry>
      <nstrgmpr:payAwtGroupId>
        <xsl:value-of select="nsmpr0:PAY_AWT_GROUP_ID"/>
      </nstrgmpr:payAwtGroupId>
      <nstrgmpr:cageCode>
        <xsl:value-of select="nsmpr0:CAGE_CODE"/>
      </nstrgmpr:cageCode>
      <nstrgmpr:legalBusinessName>
        <xsl:value-of select="nsmpr0:LEGAL_BUSINESS_NAME"/>
      </nstrgmpr:legalBusinessName>
      <nstrgmpr:doingBusAsName>
        <xsl:value-of select="nsmpr0:DOING_BUS_AS_NAME"/>
      </nstrgmpr:doingBusAsName>
      <nstrgmpr:divisionName>
        <xsl:value-of select="nsmpr0:DIVISION_NAME"/>
      </nstrgmpr:divisionName>
      <nstrgmpr:smallBusinessCode>
        <xsl:value-of select="nsmpr0:SMALL_BUSINESS_CODE"/>
      </nstrgmpr:smallBusinessCode>
      <nstrgmpr:ccrComments>
        <xsl:value-of select="nsmpr0:CCR_COMMENTS"/>
      </nstrgmpr:ccrComments>
      <nstrgmpr:debarmentStartDate>
        <xsl:value-of select="nsmpr0:DEBARMENT_START_DATE"/>
      </nstrgmpr:debarmentStartDate>
      <nstrgmpr:debarmentEndDate>
        <xsl:value-of select="nsmpr0:DEBARMENT_END_DATE"/>
      </nstrgmpr:debarmentEndDate>
      <nstrgmpr:ackLeadTime>
        <xsl:value-of select="nsmpr0:ACK_LEAD_TIME"/>
      </nstrgmpr:ackLeadTime>
    </nstrgmpr:vendorSite>
  </xsl:template>

</xsl:stylesheet>
