<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:nstrgmpr="http://vendor.structure"
                xmlns:nsmpr0="http://source.data">

  <xsl:template match="/">
    <nstrgmpr:vendor>
      <nstrgmpr:vendorId>
        <xsl:value-of select="nsmpr0:vendorId"/>
      </nstrgmpr:vendorId>
      <nstrgmpr:lastUpdateDate>
        <xsl:value-of select="nsmpr0:lastUpdateDate"/>
      </nstrgmpr:lastUpdateDate>
      <nstrgmpr:lastUpdatedBy>
        <xsl:value-of select="nsmpr0:lastUpdatedBy"/>
      </nstrgmpr:lastUpdatedBy>
      <nstrgmpr:vendorName>
        <xsl:value-of select="nsmpr0:vendorName"/>
      </nstrgmpr:vendorName>
      <nstrgmpr:vendorNameAlt>
        <xsl:value-of select="nsmpr0:vendorNameAlt"/>
      </nstrgmpr:vendorNameAlt>
      <nstrgmpr:segment1>
        <xsl:value-of select="nsmpr0:segment1"/>
      </nstrgmpr:segment1>
      <nstrgmpr:summaryFlag>
        <xsl:value-of select="nsmpr0:summaryFlag"/>
      </nstrgmpr:summaryFlag>
      <nstrgmpr:enabledFlag>
        <xsl:value-of select="nsmpr0:enabledFlag"/>
      </nstrgmpr:enabledFlag>
      <nstrgmpr:segment2>
        <xsl:value-of select="nsmpr0:segment2"/>
      </nstrgmpr:segment2>
      <nstrgmpr:segment3>
        <xsl:value-of select="nsmpr0:segment3"/>
      </nstrgmpr:segment3>
      <nstrgmpr:segment4>
        <xsl:value-of select="nsmpr0:segment4"/>
      </nstrgmpr:segment4>
      <nstrgmpr:segment5>
        <xsl:value-of select="nsmpr0:segment5"/>
      </nstrgmpr:segment5>
      <nstrgmpr:lastUpdateLogin>
        <xsl:value-of select="nsmpr0:lastUpdateLogin"/>
      </nstrgmpr:lastUpdateLogin>
      <nstrgmpr:creationDate>
        <xsl:value-of select="nsmpr0:creationDate"/>
      </nstrgmpr:creationDate>
      <nstrgmpr:createdBy>
        <xsl:value-of select="nsmpr0:createdBy"/>
      </nstrgmpr:createdBy>
      <nstrgmpr:employeeId>
        <xsl:value-of select="nsmpr0:employeeId"/>
      </nstrgmpr:employeeId>
      <nstrgmpr:vendorTypeLookupCode>
        <xsl:value-of select="nsmpr0:vendorTypeLookupCode"/>
      </nstrgmpr:vendorTypeLookupCode>
      <nstrgmpr:customerNum>
        <xsl:value-of select="nsmpr0:customerNum"/>
      </nstrgmpr:customerNum>
      <nstrgmpr:oneTimeFlag>
        <xsl:value-of select="nsmpr0:oneTimeFlag"/>
      </nstrgmpr:oneTimeFlag>
      <nstrgmpr:parentVendorId>
        <xsl:value-of select="nsmpr0:parentVendorId"/>
      </nstrgmpr:parentVendorId>
      <nstrgmpr:minOrderAmount>
        <xsl:value-of select="nsmpr0:minOrderAmount"/>
      </nstrgmpr:minOrderAmount>
      <nstrgmpr:shipToLocationId>
        <xsl:value-of select="nsmpr0:shipToLocationId"/>
      </nstrgmpr:shipToLocationId>
      <nstrgmpr:billToLocationId>
        <xsl:value-of select="nsmpr0:billToLocationId"/>
      </nstrgmpr:billToLocationId>
      <nstrgmpr:shipViaLookupCode>
        <xsl:value-of select="nsmpr0:shipViaLookupCode"/>
      </nstrgmpr:shipViaLookupCode>
      <nstrgmpr:freightTermsLookupCode>
        <xsl:value-of select="nsmpr0:freightTermsLookupCode"/>
      </nstrgmpr:freightTermsLookupCode>
      <nstrgmpr:fobLookupCode>
        <xsl:value-of select="nsmpr0:fobLookupCode"/>
      </nstrgmpr:fobLookupCode>
      <nstrgmpr:termsId>
        <xsl:value-of select="nsmpr0:termsId"/>
      </nstrgmpr:termsId>
      <nstrgmpr:setOfBooksId>
        <xsl:value-of select="nsmpr0:setOfBooksId"/>
      </nstrgmpr:setOfBooksId>
      <nstrgmpr:creditStatusLookupCode>
        <xsl:value-of select="nsmpr0:creditStatusLookupCode"/>
      </nstrgmpr:creditStatusLookupCode>
      <nstrgmpr:creditLimit>
        <xsl:value-of select="nsmpr0:creditLimit"/>
      </nstrgmpr:creditLimit>
      <nstrgmpr:alwaysTakeDiscFlag>
        <xsl:value-of select="nsmpr0:alwaysTakeDiscFlag"/>
      </nstrgmpr:alwaysTakeDiscFlag>
      <nstrgmpr:payDateBasisLookupCode>
        <xsl:value-of select="nsmpr0:payDateBasisLookupCode"/>
      </nstrgmpr:payDateBasisLookupCode>
      <nstrgmpr:payGroupLookupCode>
        <xsl:value-of select="nsmpr0:payGroupLookupCode"/>
      </nstrgmpr:payGroupLookupCode>
      <nstrgmpr:paymentPriority>
        <xsl:value-of select="nsmpr0:paymentPriority"/>
      </nstrgmpr:paymentPriority>
      <nstrgmpr:invoiceCurrencyCode>
        <xsl:value-of select="nsmpr0:invoiceCurrencyCode"/>
      </nstrgmpr:invoiceCurrencyCode>
      <nstrgmpr:paymentCurrencyCode>
        <xsl:value-of select="nsmpr0:paymentCurrencyCode"/>
      </nstrgmpr:paymentCurrencyCode>
      <nstrgmpr:invoiceAmountLimit>
        <xsl:value-of select="nsmpr0:invoiceAmountLimit"/>
      </nstrgmpr:invoiceAmountLimit>
      <nstrgmpr:exchangeDateLookupCode>
        <xsl:value-of select="nsmpr0:exchangeDateLookupCode"/>
      </nstrgmpr:exchangeDateLookupCode>
      <nstrgmpr:holdAllPaymentsFlag>
        <xsl:value-of select="nsmpr0:holdAllPaymentsFlag"/>
      </nstrgmpr:holdAllPaymentsFlag>
      <nstrgmpr:holdFuturePaymentsFlag>
        <xsl:value-of select="nsmpr0:holdFuturePaymentsFlag"/>
      </nstrgmpr:holdFuturePaymentsFlag>
      <nstrgmpr:holdReason>
        <xsl:value-of select="nsmpr0:holdReason"/>
      </nstrgmpr:holdReason>
      <nstrgmpr:distributionSetId>
        <xsl:value-of select="nsmpr0:distributionSetId"/>
      </nstrgmpr:distributionSetId>
      <nstrgmpr:acctsPayCodeCombinationId>
        <xsl:value-of select="nsmpr0:acctsPayCodeCombinationId"/>
      </nstrgmpr:acctsPayCodeCombinationId>
      <nstrgmpr:discLostCodeCombinationId>
        <xsl:value-of select="nsmpr0:discLostCodeCombinationId"/>
      </nstrgmpr:discLostCodeCombinationId>
      <nstrgmpr:discTakenCodeCombinationId>
        <xsl:value-of select="nsmpr0:discTakenCodeCombinationId"/>
      </nstrgmpr:discTakenCodeCombinationId>
      <nstrgmpr:expenseCodeCombinationId>
        <xsl:value-of select="nsmpr0:expenseCodeCombinationId"/>
      </nstrgmpr:expenseCodeCombinationId>
      <nstrgmpr:prepayCodeCombinationId>
        <xsl:value-of select="nsmpr0:prepayCodeCombinationId"/>
      </nstrgmpr:prepayCodeCombinationId>
      <nstrgmpr:num1099>
        <xsl:value-of select="nsmpr0:num1099"/>
      </nstrgmpr:num1099>
      <nstrgmpr:type1099>
        <xsl:value-of select="nsmpr0:type1099"/>
      </nstrgmpr:type1099>
      <nstrgmpr:withholdingStatusLookupCode>
        <xsl:value-of select="nsmpr0:withholdingStatusLookupCode"/>
      </nstrgmpr:withholdingStatusLookupCode>
      <nstrgmpr:withholdingStartDate>
        <xsl:value-of select="nsmpr0:withholdingStartDate"/>
      </nstrgmpr:withholdingStartDate>
      <nstrgmpr:organizationTypeLookupCode>
        <xsl:value-of select="nsmpr0:organizationTypeLookupCode"/>
      </nstrgmpr:organizationTypeLookupCode>
      <nstrgmpr:vatCode>
        <xsl:value-of select="nsmpr0:vatCode"/>
      </nstrgmpr:vatCode>
      <nstrgmpr:startDateActive>
        <xsl:value-of select="nsmpr0:startDateActive"/>
      </nstrgmpr:startDateActive>
      <nstrgmpr:endDateActive>
        <xsl:value-of select="nsmpr0:endDateActive"/>
      </nstrgmpr:endDateActive>
      <nstrgmpr:minorityGroupLookupCode>
        <xsl:value-of select="nsmpr0:minorityGroupLookupCode"/>
      </nstrgmpr:minorityGroupLookupCode>
      <nstrgmpr:paymentMethodLookupCode>
        <xsl:value-of select="nsmpr0:paymentMethodLookupCode"/>
      </nstrgmpr:paymentMethodLookupCode>
      <nstrgmpr:bankAccountName>
        <xsl:value-of select="nsmpr0:bankAccountName"/>
      </nstrgmpr:bankAccountName>
      <nstrgmpr:bankAccountNum>
        <xsl:value-of select="nsmpr0:bankAccountNum"/>
      </nstrgmpr:bankAccountNum>
      <nstrgmpr:bankNum>
        <xsl:value-of select="nsmpr0:bankNum"/>
      </nstrgmpr:bankNum>
      <nstrgmpr:bankAccountType>
        <xsl:value-of select="nsmpr0:bankAccountType"/>
      </nstrgmpr:bankAccountType>
      <nstrgmpr:womenOwnedFlag>
        <xsl:value-of select="nsmpr0:womenOwnedFlag"/>
      </nstrgmpr:womenOwnedFlag>
      <nstrgmpr:smallBusinessFlag>
        <xsl:value-of select="nsmpr0:smallBusinessFlag"/>
      </nstrgmpr:smallBusinessFlag>
      <nstrgmpr:standardIndustryClass>
        <xsl:value-of select="nsmpr0:standardIndustryClass"/>
      </nstrgmpr:standardIndustryClass>
      <nstrgmpr:holdFlag>
        <xsl:value-of select="nsmpr0:holdFlag"/>
      </nstrgmpr:holdFlag>
      <nstrgmpr:purchasingHoldReason>
        <xsl:value-of select="nsmpr0:purchasingHoldReason"/>
      </nstrgmpr:purchasingHoldReason>
      <nstrgmpr:holdBy>
        <xsl:value-of select="nsmpr0:holdBy"/>
      </nstrgmpr:holdBy>
      <nstrgmpr:holdDate>
        <xsl:value-of select="nsmpr0:holdDate"/>
      </nstrgmpr:holdDate>
      <nstrgmpr:termsDateBasis>
        <xsl:value-of select="nsmpr0:termsDateBasis"/>
      </nstrgmpr:termsDateBasis>
      <nstrgmpr:priceTolerance>
        <xsl:value-of select="nsmpr0:priceTolerance"/>
      </nstrgmpr:priceTolerance>
      <nstrgmpr:inspectionRequiredFlag>
        <xsl:value-of select="nsmpr0:inspectionRequiredFlag"/>
      </nstrgmpr:inspectionRequiredFlag>
      <nstrgmpr:receiptRequiredFlag>
        <xsl:value-of select="nsmpr0:receiptRequiredFlag"/>
      </nstrgmpr:receiptRequiredFlag>
      <nstrgmpr:qtyRcvTolerance>
        <xsl:value-of select="nsmpr0:qtyRcvTolerance"/>
      </nstrgmpr:qtyRcvTolerance>
      <nstrgmpr:qtyRcvExceptionCode>
        <xsl:value-of select="nsmpr0:qtyRcvExceptionCode"/>
      </nstrgmpr:qtyRcvExceptionCode>
      <nstrgmpr:enforceShipToLocationCode>
        <xsl:value-of select="nsmpr0:enforceShipToLocationCode"/>
      </nstrgmpr:enforceShipToLocationCode>
      <nstrgmpr:daysEarlyReceiptAllowed>
        <xsl:value-of select="nsmpr0:daysEarlyReceiptAllowed"/>
      </nstrgmpr:daysEarlyReceiptAllowed>
      <nstrgmpr:daysLateReceiptAllowed>
        <xsl:value-of select="nsmpr0:daysLateReceiptAllowed"/>
      </nstrgmpr:daysLateReceiptAllowed>
      <nstrgmpr:receiptDaysExceptionCode>
        <xsl:value-of select="nsmpr0:receiptDaysExceptionCode"/>
      </nstrgmpr:receiptDaysExceptionCode>
      <nstrgmpr:receivingRoutingId>
        <xsl:value-of select="nsmpr0:receivingRoutingId"/>
      </nstrgmpr:receivingRoutingId>
      <nstrgmpr:allowSubstituteReceiptsFlag>
        <xsl:value-of select="nsmpr0:allowSubstituteReceiptsFlag"/>
      </nstrgmpr:allowSubstituteReceiptsFlag>
      <nstrgmpr:allowUnorderedReceiptsFlag>
        <xsl:value-of select="nsmpr0:allowUnorderedReceiptsFlag"/>
      </nstrgmpr:allowUnorderedReceiptsFlag>
      <nstrgmpr:holdUnmatchedInvoicesFlag>
        <xsl:value-of select="nsmpr0:holdUnmatchedInvoicesFlag"/>
      </nstrgmpr:holdUnmatchedInvoicesFlag>
      <nstrgmpr:exclusivePaymentFlag>
        <xsl:value-of select="nsmpr0:exclusivePaymentFlag"/>
      </nstrgmpr:exclusivePaymentFlag>
      <nstrgmpr:apTaxRoundingRule>
        <xsl:value-of select="nsmpr0:apTaxRoundingRule"/>
      </nstrgmpr:apTaxRoundingRule>
      <nstrgmpr:autoTaxCalcFlag>
        <xsl:value-of select="nsmpr0:autoTaxCalcFlag"/>
      </nstrgmpr:autoTaxCalcFlag>
      <nstrgmpr:autoTaxCalcOverride>
        <xsl:value-of select="nsmpr0:autoTaxCalcOverride"/>
      </nstrgmpr:autoTaxCalcOverride>
      <nstrgmpr:amountIncludesTaxFlag>
        <xsl:value-of select="nsmpr0:amountIncludesTaxFlag"/>
      </nstrgmpr:amountIncludesTaxFlag>
      <nstrgmpr:taxVerificationDate>
        <xsl:value-of select="nsmpr0:taxVerificationDate"/>
      </nstrgmpr:taxVerificationDate>
      <nstrgmpr:nameControl>
        <xsl:value-of select="nsmpr0:nameControl"/>
      </nstrgmpr:nameControl>
      <nstrgmpr:stateReportableFlag>
        <xsl:value-of select="nsmpr0:stateReportableFlag"/>
      </nstrgmpr:stateReportableFlag>
      <nstrgmpr:federalReportableFlag>
        <xsl:value-of select="nsmpr0:federalReportableFlag"/>
      </nstrgmpr:federalReportableFlag>
      <nstrgmpr:attributeCategory>
        <xsl:value-of select="nsmpr0:attributeCategory"/>
      </nstrgmpr:attributeCategory>
      <nstrgmpr:attribute1>
        <xsl:value-of select="nsmpr0:attribute1"/>
      </nstrgmpr:attribute1>
      <nstrgmpr:attribute2>
        <xsl:value-of select="nsmpr0:attribute2"/>
      </nstrgmpr:attribute2>
      <nstrgmpr:attribute3>
        <xsl:value-of select="nsmpr0:attribute3"/>
      </nstrgmpr:attribute3>
      <nstrgmpr:attribute4>
        <xsl:value-of select="nsmpr0:attribute4"/>
      </nstrgmpr:attribute4>
      <nstrgmpr:attribute5>
        <xsl:value-of select="nsmpr0:attribute5"/>
      </nstrgmpr:attribute5>
      <nstrgmpr:attribute6>
        <xsl:value-of select="nsmpr0:attribute6"/>
      </nstrgmpr:attribute6>
      <nstrgmpr:attribute7>
        <xsl:value-of select="nsmpr0:attribute7"/>
      </nstrgmpr:attribute7>
      <nstrgmpr:attribute8>
        <xsl:value-of select="nsmpr0:attribute8"/>
      </nstrgmpr:attribute8>
      <nstrgmpr:attribute9>
        <xsl:value-of select="nsmpr0:attribute9"/>
      </nstrgmpr:attribute9>
      <nstrgmpr:attribute10>
        <xsl:value-of select="nsmpr0:attribute10"/>
      </nstrgmpr:attribute10>
      <nstrgmpr:attribute11>
        <xsl:value-of select="nsmpr0:attribute11"/>
      </nstrgmpr:attribute11>
      <nstrgmpr:attribute12>
        <xsl:value-of select="nsmpr0:attribute12"/>
      </nstrgmpr:attribute12>
      <nstrgmpr:attribute13>
        <xsl:value-of select="nsmpr0:attribute13"/>
      </nstrgmpr:attribute13>
      <nstrgmpr:attribute14>
        <xsl:value-of select="nsmpr0:attribute14"/>
      </nstrgmpr:attribute14>
      <nstrgmpr:attribute15>
        <xsl:value-of select="nsmpr0:attribute15"/>
      </nstrgmpr:attribute15>
      <nstrgmpr:requestId>
        <xsl:value-of select="nsmpr0:requestId"/>
      </nstrgmpr:requestId>
      <nstrgmpr:programApplicationId>
        <xsl:value-of select="nsmpr0:programApplicationId"/>
      </nstrgmpr:programApplicationId>
      <nstrgmpr:programId>
        <xsl:value-of select="nsmpr0:programId"/>
      </nstrgmpr:programId>
      <nstrgmpr:programUpdateDate>
        <xsl:value-of select="nsmpr0:programUpdateDate"/>
      </nstrgmpr:programUpdateDate>
      <nstrgmpr:offsetVatCode>
        <xsl:value-of select="nsmpr0:offsetVatCode"/>
      </nstrgmpr:offsetVatCode>
      <nstrgmpr:vatRegistrationNum>
        <xsl:value-of select="nsmpr0:vatRegistrationNum"/>
      </nstrgmpr:vatRegistrationNum>
      <nstrgmpr:autoCalculateInterestFlag>
        <xsl:value-of select="nsmpr0:autoCalculateInterestFlag"/>
      </nstrgmpr:autoCalculateInterestFlag>
      <nstrgmpr:validationNumber>
        <xsl:value-of select="nsmpr0:validationNumber"/>
      </nstrgmpr:validationNumber>
      <nstrgmpr:excludeFreightFromDiscount>
        <xsl:value-of select="nsmpr0:excludeFreightFromDiscount"/>
      </nstrgmpr:excludeFreightFromDiscount>
      <nstrgmpr:taxReportingName>
        <xsl:value-of select="nsmpr0:taxReportingName"/>
      </nstrgmpr:taxReportingName>
      <nstrgmpr:checkDigits>
        <xsl:value-of select="nsmpr0:checkDigits"/>
      </nstrgmpr:checkDigits>
      <nstrgmpr:bankNumber>
        <xsl:value-of select="nsmpr0:bankNumber"/>
      </nstrgmpr:bankNumber>
      <nstrgmpr:allowAwtFlag>
        <xsl:value-of select="nsmpr0:allowAwtFlag"/>
      </nstrgmpr:allowAwtFlag>
      <nstrgmpr:awtGroupId>
        <xsl:value-of select="nsmpr0:awtGroupId"/>
      </nstrgmpr:awtGroupId>
      <nstrgmpr:globalAttribute1>
        <xsl:value-of select="nsmpr0:globalAttribute1"/>
      </nstrgmpr:globalAttribute1>
      <nstrgmpr:globalAttribute2>
        <xsl:value-of select="nsmpr0:globalAttribute2"/>
      </nstrgmpr:globalAttribute2>
      <nstrgmpr:globalAttribute3>
        <xsl:value-of select="nsmpr0:globalAttribute3"/>
      </nstrgmpr:globalAttribute3>
      <nstrgmpr:globalAttribute4>
        <xsl:value-of select="nsmpr0:globalAttribute4"/>
      </nstrgmpr:globalAttribute4>
      <nstrgmpr:globalAttribute5>
        <xsl:value-of select="nsmpr0:globalAttribute5"/>
      </nstrgmpr:globalAttribute5>
      <nstrgmpr:globalAttribute6>
        <xsl:value-of select="nsmpr0:globalAttribute6"/>
      </nstrgmpr:globalAttribute6>
      <nstrgmpr:globalAttribute7>
        <xsl:value-of select="nsmpr0:globalAttribute7"/>
      </nstrgmpr:globalAttribute7>
      <nstrgmpr:globalAttribute8>
        <xsl:value-of select="nsmpr0:globalAttribute8"/>
      </nstrgmpr:globalAttribute8>
      <nstrgmpr:globalAttribute9>
        <xsl:value-of select="nsmpr0:globalAttribute9"/>
      </nstrgmpr:globalAttribute9>
      <nstrgmpr:globalAttribute10>
        <xsl:value-of select="nsmpr0:globalAttribute10"/>
      </nstrgmpr:globalAttribute10>
      <nstrgmpr:globalAttribute11>
        <xsl:value-of select="nsmpr0:globalAttribute11"/>
      </nstrgmpr:globalAttribute11>
      <nstrgmpr:globalAttribute12>
        <xsl:value-of select="nsmpr0:globalAttribute12"/>
      </nstrgmpr:globalAttribute12>
      <nstrgmpr:globalAttribute13>
        <xsl:value-of select="nsmpr0:globalAttribute13"/>
      </nstrgmpr:globalAttribute13>
      <nstrgmpr:globalAttribute14>
        <xsl:value-of select="nsmpr0:globalAttribute14"/>
      </nstrgmpr:globalAttribute14>
      <nstrgmpr:globalAttribute15>
        <xsl:value-of select="nsmpr0:globalAttribute15"/>
      </nstrgmpr:globalAttribute15>
      <nstrgmpr:globalAttribute16>
        <xsl:value-of select="nsmpr0:globalAttribute16"/>
      </nstrgmpr:globalAttribute16>
      <nstrgmpr:globalAttribute17>
        <xsl:value-of select="nsmpr0:globalAttribute17"/>
      </nstrgmpr:globalAttribute17>
      <nstrgmpr:globalAttribute18>
        <xsl:value-of select="nsmpr0:globalAttribute18"/>
      </nstrgmpr:globalAttribute18>
      <nstrgmpr:globalAttribute19>
        <xsl:value-of select="nsmpr0:globalAttribute19"/>
      </nstrgmpr:globalAttribute19>
      <nstrgmpr:globalAttribute20>
        <xsl:value-of select="nsmpr0:globalAttribute20"/>
      </nstrgmpr:globalAttribute20>
      <nstrgmpr:globalAttributeCategory>
        <xsl:value-of select="nsmpr0:globalAttributeCategory"/>
      </nstrgmpr:globalAttributeCategory>
      <nstrgmpr:ediTransactionHandling>
        <xsl:value-of select="nsmpr0:ediTransactionHandling"/>
      </nstrgmpr:ediTransactionHandling>
      <nstrgmpr:ediPaymentMethod>
        <xsl:value-of select="nsmpr0:ediPaymentMethod"/>
      </nstrgmpr:ediPaymentMethod>
      <nstrgmpr:ediPaymentFormat>
        <xsl:value-of select="nsmpr0:ediPaymentFormat"/>
      </nstrgmpr:ediPaymentFormat>
      <nstrgmpr:ediRemittanceMethod>
        <xsl:value-of select="nsmpr0:ediRemittanceMethod"/>
      </nstrgmpr:ediRemittanceMethod>
      <nstrgmpr:ediRemittanceInstruction>
        <xsl:value-of select="nsmpr0:ediRemittanceInstruction"/>
      </nstrgmpr:ediRemittanceInstruction>
      <nstrgmpr:bankChargeBearer>
        <xsl:value-of select="nsmpr0:bankChargeBearer"/>
      </nstrgmpr:bankChargeBearer>
      <nstrgmpr:bankBranchType>
        <xsl:value-of select="nsmpr0:bankBranchType"/>
      </nstrgmpr:bankBranchType>
      <nstrgmpr:matchOption>
        <xsl:value-of select="nsmpr0:matchOption"/>
      </nstrgmpr:matchOption>
      <nstrgmpr:futureDatedPaymentCcid>
        <xsl:value-of select="nsmpr0:futureDatedPaymentCcid"/>
      </nstrgmpr:futureDatedPaymentCcid>
      <nstrgmpr:createDebitMemoFlag>
        <xsl:value-of select="nsmpr0:createDebitMemoFlag"/>
      </nstrgmpr:createDebitMemoFlag>
      <nstrgmpr:offsetTaxFlag>
        <xsl:value-of select="nsmpr0:offsetTaxFlag"/>
      </nstrgmpr:offsetTaxFlag>
      <nstrgmpr:partyId>
        <xsl:value-of select="nsmpr0:partyId"/>
      </nstrgmpr:partyId>
      <nstrgmpr:parentPartyId>
        <xsl:value-of select="nsmpr0:parentPartyId"/>
      </nstrgmpr:parentPartyId>
      <nstrgmpr:niNumber>
        <xsl:value-of select="nsmpr0:niNumber"/>
      </nstrgmpr:niNumber>
      <nstrgmpr:tcaSyncNum1099>
        <xsl:value-of select="nsmpr0:tcaSyncNum1099"/>
      </nstrgmpr:tcaSyncNum1099>
      <nstrgmpr:tcaSyncVendorName>
        <xsl:value-of select="nsmpr0:tcaSyncVendorName"/>
      </nstrgmpr:tcaSyncVendorName>
      <nstrgmpr:tcaSyncVatRegNum>
        <xsl:value-of select="nsmpr0:tcaSyncVatRegNum"/>
      </nstrgmpr:tcaSyncVatRegNum>
      <nstrgmpr:uniqueTaxReferenceNum>
        <xsl:value-of select="nsmpr0:uniqueTaxReferenceNum"/>
      </nstrgmpr:uniqueTaxReferenceNum>
      <nstrgmpr:partnershipUtr>
        <xsl:value-of select="nsmpr0:partnershipUtr"/>
      </nstrgmpr:partnershipUtr>
      <nstrgmpr:partnershipName>
        <xsl:value-of select="nsmpr0:partnershipName"/>
      </nstrgmpr:partnershipName>
      <nstrgmpr:cisEnabledFlag>
        <xsl:value-of select="nsmpr0:cisEnabledFlag"/>
      </nstrgmpr:cisEnabledFlag>
      <nstrgmpr:firstName>
        <xsl:value-of select="nsmpr0:firstName"/>
      </nstrgmpr:firstName>
      <nstrgmpr:secondName>
        <xsl:value-of select="nsmpr0:secondName"/>
      </nstrgmpr:secondName>
      <nstrgmpr:lastName>
        <xsl:value-of select="nsmpr0:lastName"/>
      </nstrgmpr:lastName>
      <nstrgmpr:salutation>
        <xsl:value-of select="nsmpr0:salutation"/>
      </nstrgmpr:salutation>
      <nstrgmpr:tradingName>
        <xsl:value-of select="nsmpr0:tradingName"/>
      </nstrgmpr:tradingName>
      <nstrgmpr:workReference>
        <xsl:value-of select="nsmpr0:workReference"/>
      </nstrgmpr:workReference>
      <nstrgmpr:companyRegistrationNumber>
        <xsl:value-of select="nsmpr0:companyRegistrationNumber"/>
      </nstrgmpr:companyRegistrationNumber>
      <nstrgmpr:nationalInsuranceNumber>
        <xsl:value-of select="nsmpr0:nationalInsuranceNumber"/>
      </nstrgmpr:nationalInsuranceNumber>
      <nstrgmpr:verificationNumber>
        <xsl:value-of select="nsmpr0:verificationNumber"/>
      </nstrgmpr:verificationNumber>
      <nstrgmpr:verificationRequestId>
        <xsl:value-of select="nsmpr0:verificationRequestId"/>
      </nstrgmpr:verificationRequestId>
      <nstrgmpr:matchStatusFlag>
        <xsl:value-of select="nsmpr0:matchStatusFlag"/>
      </nstrgmpr:matchStatusFlag>
      <nstrgmpr:cisVerificationDate>
        <xsl:value-of select="nsmpr0:cisVerificationDate"/>
      </nstrgmpr:cisVerificationDate>
      <nstrgmpr:individual1099>
        <xsl:value-of select="nsmpr0:individual1099"/>
      </nstrgmpr:individual1099>
      <nstrgmpr:payAwtGroupId>
        <xsl:value-of select="nsmpr0:payAwtGroupId"/>
      </nstrgmpr:payAwtGroupId>
      <nstrgmpr:cisParentVendorId>
        <xsl:value-of select="nsmpr0:cisParentVendorId"/>
      </nstrgmpr:cisParentVendorId>
      <nstrgmpr:busClassLastCertifiedDate>
        <xsl:value-of select="nsmpr0:busClassLastCertifiedDate"/>
      </nstrgmpr:busClassLastCertifiedDate>
      <nstrgmpr:busClassLastCertifiedBy>
        <xsl:value-of select="nsmpr0:busClassLastCertifiedBy"/>
      </nstrgmpr:busClassLastCertifiedBy>
    </nstrgmpr:vendor>
  </xsl:template>

</xsl:stylesheet>
