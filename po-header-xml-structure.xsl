<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:nstrgmpr="http://xmlns.oracle.com/apps/target" xmlns:nsmpr0="http://xmlns.oracle.com/apps/source">
	<xsl:output indent="yes" method="xml"/>
	<xsl:template match="/">
		<nstrgmpr:poHeader>
			<nstrgmpr:poHeaderId>
				<xsl:value-of select="nsmpr0:PO_HEADER_ID"/>
			</nstrgmpr:poHeaderId>
			<nstrgmpr:agentId>
				<xsl:value-of select="nsmpr0:AGENT_ID"/>
			</nstrgmpr:agentId>
			<nstrgmpr:typeLookupCode>
				<xsl:value-of select="nsmpr0:TYPE_LOOKUP_CODE"/>
			</nstrgmpr:typeLookupCode>
			<nstrgmpr:lastUpdateDate>
				<xsl:value-of select="nsmpr0:LAST_UPDATE_DATE"/>
			</nstrgmpr:lastUpdateDate>
			<nstrgmpr:lastUpdatedBy>
				<xsl:value-of select="nsmpr0:LAST_UPDATED_BY"/>
			</nstrgmpr:lastUpdatedBy>
			<nstrgmpr:segment1>
				<xsl:value-of select="nsmpr0:SEGMENT1"/>
			</nstrgmpr:segment1>
			<nstrgmpr:summaryFlag>
				<xsl:value-of select="nsmpr0:SUMMARY_FLAG"/>
			</nstrgmpr:summaryFlag>
			<nstrgmpr:enabledFlag>
				<xsl:value-of select="nsmpr0:ENABLED_FLAG"/>
			</nstrgmpr:enabledFlag>
			<nstrgmpr:segment2>
				<xsl:value-of select="nsmpr0:SEGMENT2"/>
			</nstrgmpr:segment2>
			<nstrgmpr:segment3>
				<xsl:value-of select="nsmpr0:SEGMENT3"/>
			</nstrgmpr:segment3>
			<nstrgmpr:segment4>
				<xsl:value-of select="nsmpr0:SEGMENT4"/>
			</nstrgmpr:segment4>
			<nstrgmpr:segment5>
				<xsl:value-of select="nsmpr0:SEGMENT5"/>
			</nstrgmpr:segment5>
			<nstrgmpr:startDateActive>
				<xsl:value-of select="nsmpr0:START_DATE_ACTIVE"/>
			</nstrgmpr:startDateActive>
			<nstrgmpr:endDateActive>
				<xsl:value-of select="nsmpr0:END_DATE_ACTIVE"/>
			</nstrgmpr:endDateActive>
			<nstrgmpr:lastUpdateLogin>
				<xsl:value-of select="nsmpr0:LAST_UPDATE_LOGIN"/>
			</nstrgmpr:lastUpdateLogin>
			<nstrgmpr:creationDate>
				<xsl:value-of select="nsmpr0:CREATION_DATE"/>
			</nstrgmpr:creationDate>
			<nstrgmpr:createdBy>
				<xsl:value-of select="nsmpr0:CREATED_BY"/>
			</nstrgmpr:createdBy>
			<nstrgmpr:vendorId>
				<xsl:value-of select="nsmpr0:VENDOR_ID"/>
			</nstrgmpr:vendorId>
			<nstrgmpr:vendorSiteId>
				<xsl:value-of select="nsmpr0:VENDOR_SITE_ID"/>
			</nstrgmpr:vendorSiteId>
			<nstrgmpr:vendorContactId>
				<xsl:value-of select="nsmpr0:VENDOR_CONTACT_ID"/>
			</nstrgmpr:vendorContactId>
			<nstrgmpr:shipToLocationId>
				<xsl:value-of select="nsmpr0:SHIP_TO_LOCATION_ID"/>
			</nstrgmpr:shipToLocationId>
			<nstrgmpr:billToLocationId>
				<xsl:value-of select="nsmpr0:BILL_TO_LOCATION_ID"/>
			</nstrgmpr:billToLocationId>
			<nstrgmpr:termsId>
				<xsl:value-of select="nsmpr0:TERMS_ID"/>
			</nstrgmpr:termsId>
			<nstrgmpr:shipViaLookupCode>
				<xsl:value-of select="nsmpr0:SHIP_VIA_LOOKUP_CODE"/>
			</nstrgmpr:shipViaLookupCode>
			<nstrgmpr:fobLookupCode>
				<xsl:value-of select="nsmpr0:FOB_LOOKUP_CODE"/>
			</nstrgmpr:fobLookupCode>
			<nstrgmpr:freightTermsLookupCode>
				<xsl:value-of select="nsmpr0:FREIGHT_TERMS_LOOKUP_CODE"/>
			</nstrgmpr:freightTermsLookupCode>
			<nstrgmpr:statusLookupCode>
				<xsl:value-of select="nsmpr0:STATUS_LOOKUP_CODE"/>
			</nstrgmpr:statusLookupCode>
			<nstrgmpr:currencyCode>
				<xsl:value-of select="nsmpr0:CURRENCY_CODE"/>
			</nstrgmpr:currencyCode>
			<nstrgmpr:rateType>
				<xsl:value-of select="nsmpr0:RATE_TYPE"/>
			</nstrgmpr:rateType>
			<nstrgmpr:rateDate>
				<xsl:value-of select="nsmpr0:RATE_DATE"/>
			</nstrgmpr:rateDate>
			<nstrgmpr:rate>
				<xsl:value-of select="nsmpr0:RATE"/>
			</nstrgmpr:rate>
			<nstrgmpr:fromHeaderId>
				<xsl:value-of select="nsmpr0:FROM_HEADER_ID"/>
			</nstrgmpr:fromHeaderId>
			<nstrgmpr:fromTypeLookupCode>
				<xsl:value-of select="nsmpr0:FROM_TYPE_LOOKUP_CODE"/>
			</nstrgmpr:fromTypeLookupCode>
			<nstrgmpr:startDate>
				<xsl:value-of select="nsmpr0:START_DATE"/>
			</nstrgmpr:startDate>
			<nstrgmpr:endDate>
				<xsl:value-of select="nsmpr0:END_DATE"/>
			</nstrgmpr:endDate>
			<nstrgmpr:blanketTotalAmount>
				<xsl:value-of select="nsmpr0:BLANKET_TOTAL_AMOUNT"/>
			</nstrgmpr:blanketTotalAmount>
			<nstrgmpr:authorizationStatus>
				<xsl:value-of select="nsmpr0:AUTHORIZATION_STATUS"/>
			</nstrgmpr:authorizationStatus>
			<nstrgmpr:revisionNum>
				<xsl:value-of select="nsmpr0:REVISION_NUM"/>
			</nstrgmpr:revisionNum>
			<nstrgmpr:revisedDate>
				<xsl:value-of select="nsmpr0:REVISED_DATE"/>
			</nstrgmpr:revisedDate>
			<nstrgmpr:approvedFlag>
				<xsl:value-of select="nsmpr0:APPROVED_FLAG"/>
			</nstrgmpr:approvedFlag>
			<nstrgmpr:approvedDate>
				<xsl:value-of select="nsmpr0:APPROVED_DATE"/>
			</nstrgmpr:approvedDate>
			<nstrgmpr:amountLimit>
				<xsl:value-of select="nsmpr0:AMOUNT_LIMIT"/>
			</nstrgmpr:amountLimit>
			<nstrgmpr:minReleaseAmount>
				<xsl:value-of select="nsmpr0:MIN_RELEASE_AMOUNT"/>
			</nstrgmpr:minReleaseAmount>
			<nstrgmpr:noteToAuthorizer>
				<xsl:value-of select="nsmpr0:NOTE_TO_AUTHORIZER"/>
			</nstrgmpr:noteToAuthorizer>
			<nstrgmpr:noteToVendor>
				<xsl:value-of select="nsmpr0:NOTE_TO_VENDOR"/>
			</nstrgmpr:noteToVendor>
			<nstrgmpr:noteToReceiver>
				<xsl:value-of select="nsmpr0:NOTE_TO_RECEIVER"/>
			</nstrgmpr:noteToReceiver>
			<nstrgmpr:printCount>
				<xsl:value-of select="nsmpr0:PRINT_COUNT"/>
			</nstrgmpr:printCount>
			<nstrgmpr:printedDate>
				<xsl:value-of select="nsmpr0:PRINTED_DATE"/>
			</nstrgmpr:printedDate>
			<nstrgmpr:vendorOrderNum>
				<xsl:value-of select="nsmpr0:VENDOR_ORDER_NUM"/>
			</nstrgmpr:vendorOrderNum>
			<nstrgmpr:confirmingOrderFlag>
				<xsl:value-of select="nsmpr0:CONFIRMING_ORDER_FLAG"/>
			</nstrgmpr:confirmingOrderFlag>
			<nstrgmpr:comments>
				<xsl:value-of select="nsmpr0:COMMENTS"/>
			</nstrgmpr:comments>
			<nstrgmpr:replyDate>
				<xsl:value-of select="nsmpr0:REPLY_DATE"/>
			</nstrgmpr:replyDate>
			<nstrgmpr:replyMethodLookupCode>
				<xsl:value-of select="nsmpr0:REPLY_METHOD_LOOKUP_CODE"/>
			</nstrgmpr:replyMethodLookupCode>
			<nstrgmpr:rfqCloseDate>
				<xsl:value-of select="nsmpr0:RFQ_CLOSE_DATE"/>
			</nstrgmpr:rfqCloseDate>
			<nstrgmpr:quoteTypeLookupCode>
				<xsl:value-of select="nsmpr0:QUOTE_TYPE_LOOKUP_CODE"/>
			</nstrgmpr:quoteTypeLookupCode>
			<nstrgmpr:quotationClassCode>
				<xsl:value-of select="nsmpr0:QUOTATION_CLASS_CODE"/>
			</nstrgmpr:quotationClassCode>
			<nstrgmpr:quoteWarningDelayUnit>
				<xsl:value-of select="nsmpr0:QUOTE_WARNING_DELAY_UNIT"/>
			</nstrgmpr:quoteWarningDelayUnit>
			<nstrgmpr:quoteWarningDelay>
				<xsl:value-of select="nsmpr0:QUOTE_WARNING_DELAY"/>
			</nstrgmpr:quoteWarningDelay>
			<nstrgmpr:quoteVendorQuoteNumber>
				<xsl:value-of select="nsmpr0:QUOTE_VENDOR_QUOTE_NUMBER"/>
			</nstrgmpr:quoteVendorQuoteNumber>
			<nstrgmpr:acceptanceRequiredFlag>
				<xsl:value-of select="nsmpr0:ACCEPTANCE_REQUIRED_FLAG"/>
			</nstrgmpr:acceptanceRequiredFlag>
			<nstrgmpr:acceptanceDueDate>
				<xsl:value-of select="nsmpr0:ACCEPTANCE_DUE_DATE"/>
			</nstrgmpr:acceptanceDueDate>
			<nstrgmpr:closedDate>
				<xsl:value-of select="nsmpr0:CLOSED_DATE"/>
			</nstrgmpr:closedDate>
			<nstrgmpr:userHoldFlag>
				<xsl:value-of select="nsmpr0:USER_HOLD_FLAG"/>
			</nstrgmpr:userHoldFlag>
			<nstrgmpr:approvalRequiredFlag>
				<xsl:value-of select="nsmpr0:APPROVAL_REQUIRED_FLAG"/>
			</nstrgmpr:approvalRequiredFlag>
			<nstrgmpr:cancelFlag>
				<xsl:value-of select="nsmpr0:CANCEL_FLAG"/>
			</nstrgmpr:cancelFlag>
			<nstrgmpr:firmStatusLookupCode>
				<xsl:value-of select="nsmpr0:FIRM_STATUS_LOOKUP_CODE"/>
			</nstrgmpr:firmStatusLookupCode>
			<nstrgmpr:firmDate>
				<xsl:value-of select="nsmpr0:FIRM_DATE"/>
			</nstrgmpr:firmDate>
			<nstrgmpr:frozenFlag>
				<xsl:value-of select="nsmpr0:FROZEN_FLAG"/>
			</nstrgmpr:frozenFlag>
			<nstrgmpr:supplyAgreementFlag>
				<xsl:value-of select="nsmpr0:SUPPLY_AGREEMENT_FLAG"/>
			</nstrgmpr:supplyAgreementFlag>
			<nstrgmpr:ediProcessedFlag>
				<xsl:value-of select="nsmpr0:EDI_PROCESSED_FLAG"/>
			</nstrgmpr:ediProcessedFlag>
			<nstrgmpr:ediProcessedStatus>
				<xsl:value-of select="nsmpr0:EDI_PROCESSED_STATUS"/>
			</nstrgmpr:ediProcessedStatus>
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
			<nstrgmpr:closedCode>
				<xsl:value-of select="nsmpr0:CLOSED_CODE"/>
			</nstrgmpr:closedCode>
			<nstrgmpr:ussglTransactionCode>
				<xsl:value-of select="nsmpr0:USSGL_TRANSACTION_CODE"/>
			</nstrgmpr:ussglTransactionCode>
			<nstrgmpr:governmentContext>
				<xsl:value-of select="nsmpr0:GOVERNMENT_CONTEXT"/>
			</nstrgmpr:governmentContext>
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
			<nstrgmpr:orgId>
				<xsl:value-of select="nsmpr0:ORG_ID"/>
			</nstrgmpr:orgId>
			<nstrgmpr:globalAttributeCategory>
				<xsl:value-of select="nsmpr0:GLOBAL_ATTRIBUTE_CATEGORY"/>
			</nstrgmpr:globalAttributeCategory>
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
			<nstrgmpr:interfaceSourceCode>
				<xsl:value-of select="nsmpr0:INTERFACE_SOURCE_CODE"/>
			</nstrgmpr:interfaceSourceCode>
			<nstrgmpr:referenceNum>
				<xsl:value-of select="nsmpr0:REFERENCE_NUM"/>
			</nstrgmpr:referenceNum>
			<nstrgmpr:wfItemType>
				<xsl:value-of select="nsmpr0:WF_ITEM_TYPE"/>
			</nstrgmpr:wfItemType>
			<nstrgmpr:wfItemKey>
				<xsl:value-of select="nsmpr0:WF_ITEM_KEY"/>
			</nstrgmpr:wfItemKey>
			<nstrgmpr:mrcRateType>
				<xsl:value-of select="nsmpr0:MRC_RATE_TYPE"/>
			</nstrgmpr:mrcRateType>
			<nstrgmpr:mrcRateDate>
				<xsl:value-of select="nsmpr0:MRC_RATE_DATE"/>
			</nstrgmpr:mrcRateDate>
			<nstrgmpr:mrcRate>
				<xsl:value-of select="nsmpr0:MRC_RATE"/>
			</nstrgmpr:mrcRate>
			<nstrgmpr:pcardId>
				<xsl:value-of select="nsmpr0:PCARD_ID"/>
			</nstrgmpr:pcardId>
			<nstrgmpr:priceUpdateTolerance>
				<xsl:value-of select="nsmpr0:PRICE_UPDATE_TOLERANCE"/>
			</nstrgmpr:priceUpdateTolerance>
			<nstrgmpr:payOnCode>
				<xsl:value-of select="nsmpr0:PAY_ON_CODE"/>
			</nstrgmpr:payOnCode>
			<nstrgmpr:xmlFlag>
				<xsl:value-of select="nsmpr0:XML_FLAG"/>
			</nstrgmpr:xmlFlag>
			<nstrgmpr:xmlSendDate>
				<xsl:value-of select="nsmpr0:XML_SEND_DATE"/>
			</nstrgmpr:xmlSendDate>
			<nstrgmpr:xmlChangeSendDate>
				<xsl:value-of select="nsmpr0:XML_CHANGE_SEND_DATE"/>
			</nstrgmpr:xmlChangeSendDate>
			<nstrgmpr:globalAgreementFlag>
				<xsl:value-of select="nsmpr0:GLOBAL_AGREEMENT_FLAG"/>
			</nstrgmpr:globalAgreementFlag>
			<nstrgmpr:consignedConsumptionFlag>
				<xsl:value-of select="nsmpr0:CONSIGNED_CONSUMPTION_FLAG"/>
			</nstrgmpr:consignedConsumptionFlag>
			<nstrgmpr:cbcAccountingDate>
				<xsl:value-of select="nsmpr0:CBC_ACCOUNTING_DATE"/>
			</nstrgmpr:cbcAccountingDate>
			<nstrgmpr:consumeReqDemandFlag>
				<xsl:value-of select="nsmpr0:CONSUME_REQ_DEMAND_FLAG"/>
			</nstrgmpr:consumeReqDemandFlag>
			<nstrgmpr:changeRequestedBy>
				<xsl:value-of select="nsmpr0:CHANGE_REQUESTED_BY"/>
			</nstrgmpr:changeRequestedBy>
			<nstrgmpr:shippingControl>
				<xsl:value-of select="nsmpr0:SHIPPING_CONTROL"/>
			</nstrgmpr:shippingControl>
			<nstrgmpr:confermsExistFlag>
				<xsl:value-of select="nsmpr0:CONTERMS_EXIST_FLAG"/>
			</nstrgmpr:confermsExistFlag>
			<nstrgmpr:confermsArticlesUpdDate>
				<xsl:value-of select="nsmpr0:CONTERMS_ARTICLES_UPD_DATE"/>
			</nstrgmpr:confermsArticlesUpdDate>
			<nstrgmpr:confermsDelivUpdDate>
				<xsl:value-of select="nsmpr0:CONTERMS_DELIV_UPD_DATE"/>
			</nstrgmpr:confermsDelivUpdDate>
			<nstrgmpr:encumbranceRequired>
				<xsl:value-of select="nsmpr0:ENCUMBRANCE_REQUIRED"/>
			</nstrgmpr:encumbranceRequired>
			<nstrgmpr:pendingSignatureFlag>
				<xsl:value-of select="nsmpr0:PENDING_SIGNATURE_FLAG"/>
			</nstrgmpr:pendingSignatureFlag>
			<nstrgmpr:changeSummary>
				<xsl:value-of select="nsmpr0:CHANGE_SUMMARY"/>
			</nstrgmpr:changeSummary>
			<nstrgmpr:encumbranceRequiredFlag>
				<xsl:value-of select="nsmpr0:ENCUMBRANCE_REQUIRED_FLAG"/>
			</nstrgmpr:encumbranceRequiredFlag>
			<nstrgmpr:documentCreationMethod>
				<xsl:value-of select="nsmpr0:DOCUMENT_CREATION_METHOD"/>
			</nstrgmpr:documentCreationMethod>
			<nstrgmpr:submitDate>
				<xsl:value-of select="nsmpr0:SUBMIT_DATE"/>
			</nstrgmpr:submitDate>
			<nstrgmpr:enableAllSites>
				<xsl:value-of select="nsmpr0:ENABLE_ALL_SITES"/>
			</nstrgmpr:enableAllSites>
			<nstrgmpr:createdLanguage>
				<xsl:value-of select="nsmpr0:CREATED_LANGUAGE"/>
			</nstrgmpr:createdLanguage>
			<nstrgmpr:cpaReference>
				<xsl:value-of select="nsmpr0:CPA_REFERENCE"/>
			</nstrgmpr:cpaReference>
			<nstrgmpr:lastUpdatedProgram>
				<xsl:value-of select="nsmpr0:LAST_UPDATED_PROGRAM"/>
			</nstrgmpr:lastUpdatedProgram>
			<nstrgmpr:otmStatusCode>
				<xsl:value-of select="nsmpr0:OTM_STATUS_CODE"/>
			</nstrgmpr:otmStatusCode>
			<nstrgmpr:otmRecoveryFlag>
				<xsl:value-of select="nsmpr0:OTM_RECOVERY_FLAG"/>
			</nstrgmpr:otmRecoveryFlag>
			<nstrgmpr:supplierNotifMethod>
				<xsl:value-of select="nsmpr0:SUPPLIER_NOTIF_METHOD"/>
			</nstrgmpr:supplierNotifMethod>
			<nstrgmpr:fax>
				<xsl:value-of select="nsmpr0:FAX"/>
			</nstrgmpr:fax>
			<nstrgmpr:emailAddress>
				<xsl:value-of select="nsmpr0:EMAIL_ADDRESS"/>
			</nstrgmpr:emailAddress>
			<nstrgmpr:retroPriceCommUpdatesFlag>
				<xsl:value-of select="nsmpr0:RETRO_PRICE_COMM_UPDATES_FLAG"/>
			</nstrgmpr:retroPriceCommUpdatesFlag>
			<nstrgmpr:retroPriceApplyUpdatesFlag>
				<xsl:value-of select="nsmpr0:RETRO_PRICE_APPLY_UPDATES_FLAG"/>
			</nstrgmpr:retroPriceApplyUpdatesFlag>
			<nstrgmpr:updateSourcingRulesFlag>
				<xsl:value-of select="nsmpr0:UPDATE_SOURCING_RULES_FLAG"/>
			</nstrgmpr:updateSourcingRulesFlag>
			<nstrgmpr:autoSourcingFlag>
				<xsl:value-of select="nsmpr0:AUTO_SOURCING_FLAG"/>
			</nstrgmpr:autoSourcingFlag>
			<nstrgmpr:lockOwnerRole>
				<xsl:value-of select="nsmpr0:LOCK_OWNER_ROLE"/>
			</nstrgmpr:lockOwnerRole>
			<nstrgmpr:lockOwnerUserId>
				<xsl:value-of select="nsmpr0:LOCK_OWNER_USER_ID"/>
			</nstrgmpr:lockOwnerUserId>
			<nstrgmpr:supplierAuthEnabledFlag>
				<xsl:value-of select="nsmpr0:SUPPLIER_AUTH_ENABLED_FLAG"/>
			</nstrgmpr:supplierAuthEnabledFlag>
			<nstrgmpr:catAdminAuthEnabledFlag>
				<xsl:value-of select="nsmpr0:CAT_ADMIN_AUTH_ENABLED_FLAG"/>
			</nstrgmpr:catAdminAuthEnabledFlag>
			<nstrgmpr:styleId>
				<xsl:value-of select="nsmpr0:STYLE_ID"/>
			</nstrgmpr:styleId>
			<nstrgmpr:taxAttributeUpdateCode>
				<xsl:value-of select="nsmpr0:TAX_ATTRIBUTE_UPDATE_CODE"/>
			</nstrgmpr:taxAttributeUpdateCode>
			<nstrgmpr:payWhenPaid>
				<xsl:value-of select="nsmpr0:PAY_WHEN_PAID"/>
			</nstrgmpr:payWhenPaid>
			<nstrgmpr:commRevNum>
				<xsl:value-of select="nsmpr0:COMM_REV_NUM"/>
			</nstrgmpr:commRevNum>
			<nstrgmpr:clmDocumentNumber>
				<xsl:value-of select="nsmpr0:CLM_DOCUMENT_NUMBER"/>
			</nstrgmpr:clmDocumentNumber>
			<nstrgmpr:ameApprovalId>
				<xsl:value-of select="nsmpr0:AME_APPROVAL_ID"/>
			</nstrgmpr:ameApprovalId>
			<nstrgmpr:ameTransactionType>
				<xsl:value-of select="nsmpr0:AME_TRANSACTION_TYPE"/>
			</nstrgmpr:ameTransactionType>
			<nstrgmpr:udaTemplateId>
				<xsl:value-of select="nsmpr0:UDA_TEMPLATE_ID"/>
			</nstrgmpr:udaTemplateId>
			<nstrgmpr:udaTemplateDate>
				<xsl:value-of select="nsmpr0:UDA_TEMPLATE_DATE"/>
			</nstrgmpr:udaTemplateDate>
			<nstrgmpr:userDocumentStatus>
				<xsl:value-of select="nsmpr0:USER_DOCUMENT_STATUS"/>
			</nstrgmpr:userDocumentStatus>
			<nstrgmpr:draftId>
				<xsl:value-of select="nsmpr0:DRAFT_ID"/>
			</nstrgmpr:draftId>
			<nstrgmpr:clmEffectiveDate>
				<xsl:value-of select="nsmpr0:CLM_EFFECTIVE_DATE"/>
			</nstrgmpr:clmEffectiveDate>
			<nstrgmpr:clmVendorOfferNumber>
				<xsl:value-of select="nsmpr0:CLM_VENDOR_OFFER_NUMBER"/>
			</nstrgmpr:clmVendorOfferNumber>
			<nstrgmpr:clmAwardAdministrator>
				<xsl:value-of select="nsmpr0:CLM_AWARD_ADMINISTRATOR"/>
			</nstrgmpr:clmAwardAdministrator>
			<nstrgmpr:clmNoSignedCopiesToReturn>
				<xsl:value-of select="nsmpr0:CLM_NO_SIGNED_COPIES_TO_RETURN"/>
			</nstrgmpr:clmNoSignedCopiesToReturn>
			<nstrgmpr:clmMinGuaranteeAwardAmt>
				<xsl:value-of select="nsmpr0:CLM_MIN_GUARANTEE_AWARD_AMT"/>
			</nstrgmpr:clmMinGuaranteeAwardAmt>
			<nstrgmpr:clmMinGuarAwardAmtPercent>
				<xsl:value-of select="nsmpr0:CLM_MIN_GUAR_AWARD_AMT_PERCENT"/>
			</nstrgmpr:clmMinGuarAwardAmtPercent>
			<nstrgmpr:clmMinOrderAmount>
				<xsl:value-of select="nsmpr0:CLM_MIN_ORDER_AMOUNT"/>
			</nstrgmpr:clmMinOrderAmount>
			<nstrgmpr:clmMaxOrderAmount>
				<xsl:value-of select="nsmpr0:CLM_MAX_ORDER_AMOUNT"/>
			</nstrgmpr:clmMaxOrderAmount>
			<nstrgmpr:clmAmtSyncedToAgreement>
				<xsl:value-of select="nsmpr0:CLM_AMT_SYNCED_TO_AGREEMENT"/>
			</nstrgmpr:clmAmtSyncedToAgreement>
			<nstrgmpr:clmAmountReleased>
				<xsl:value-of select="nsmpr0:CLM_AMOUNT_RELEASED"/>
			</nstrgmpr:clmAmountReleased>
			<nstrgmpr:clmExternalIdv>
				<xsl:value-of select="nsmpr0:CLM_EXTERNAL_IDV"/>
			</nstrgmpr:clmExternalIdv>
			<nstrgmpr:clmSupplierName>
				<xsl:value-of select="nsmpr0:CLM_SUPPLIER_NAME"/>
			</nstrgmpr:clmSupplierName>
			<nstrgmpr:clmSupplierSiteName>
				<xsl:value-of select="nsmpr0:CLM_SUPPLIER_SITE_NAME"/>
			</nstrgmpr:clmSupplierSiteName>
			<nstrgmpr:clmSourceDocumentId>
				<xsl:value-of select="nsmpr0:CLM_SOURCE_DOCUMENT_ID"/>
			</nstrgmpr:clmSourceDocumentId>
			<nstrgmpr:clmIssuingOffice>
				<xsl:value-of select="nsmpr0:CLM_ISSUING_OFFICE"/>
			</nstrgmpr:clmIssuingOffice>
			<nstrgmpr:clmCotrOffice>
				<xsl:value-of select="nsmpr0:CLM_COTR_OFFICE"/>
			</nstrgmpr:clmCotrOffice>
			<nstrgmpr:clmCotrContact>
				<xsl:value-of select="nsmpr0:CLM_COTR_CONTACT"/>
			</nstrgmpr:clmCotrContact>
			<nstrgmpr:clmPriorityCode>
				<xsl:value-of select="nsmpr0:CLM_PRIORITY_CODE"/>
			</nstrgmpr:clmPriorityCode>
			<nstrgmpr:clmModIssuingOffice>
				<xsl:value-of select="nsmpr0:CLM_MOD_ISSUING_OFFICE"/>
			</nstrgmpr:clmModIssuingOffice>
			<nstrgmpr:clmStandardForm>
				<xsl:value-of select="nsmpr0:CLM_STANDARD_FORM"/>
			</nstrgmpr:clmStandardForm>
			<nstrgmpr:clmDocumentFormat>
				<xsl:value-of select="nsmpr0:CLM_DOCUMENT_FORMAT"/>
			</nstrgmpr:clmDocumentFormat>
			<nstrgmpr:clmAwardType>
				<xsl:value-of select="nsmpr0:CLM_AWARD_TYPE"/>
			</nstrgmpr:clmAwardType>
			<nstrgmpr:clmContractOfficer>
				<xsl:value-of select="nsmpr0:CLM_CONTRACT_OFFICER"/>
			</nstrgmpr:clmContractOfficer>
			<nstrgmpr:clmCloseoutStatus>
				<xsl:value-of select="nsmpr0:CLM_CLOSEOUT_STATUS"/>
			</nstrgmpr:clmCloseoutStatus>
			<nstrgmpr:umbrellaProgramId>
				<xsl:value-of select="nsmpr0:UMBRELLA_PROGRAM_ID"/>
			</nstrgmpr:umbrellaProgramId>
			<nstrgmpr:fonRefId>
				<xsl:value-of select="nsmpr0:FON_REF_ID"/>
			</nstrgmpr:fonRefId>
			<nstrgmpr:clmDefaultDistFlag>
				<xsl:value-of select="nsmpr0:CLM_DEFAULT_DIST_FLAG"/>
			</nstrgmpr:clmDefaultDistFlag>
			<nstrgmpr:clmEdagenDate>
				<xsl:value-of select="nsmpr0:CLM_EDAGEN_DATE"/>
			</nstrgmpr:clmEdagenDate>
			<nstrgmpr:clmContractFinanceCode>
				<xsl:value-of select="nsmpr0:CLM_CONTRACT_FINANCE_CODE"/>
			</nstrgmpr:clmContractFinanceCode>
			<nstrgmpr:clmPaymentInstrCode>
				<xsl:value-of select="nsmpr0:CLM_PAYMENT_INSTR_CODE"/>
			</nstrgmpr:clmPaymentInstrCode>
			<nstrgmpr:clmSpecialContractType>
				<xsl:value-of select="nsmpr0:CLM_SPECIAL_CONTRACT_TYPE"/>
			</nstrgmpr:clmSpecialContractType>
			<nstrgmpr:igtDocumentNumber>
				<xsl:value-of select="nsmpr0:IGT_DOCUMENT_NUMBER"/>
			</nstrgmpr:igtDocumentNumber>
			<nstrgmpr:igtGtncNumber>
				<xsl:value-of select="nsmpr0:IGT_GTNC_NUMBER"/>
			</nstrgmpr:igtGtncNumber>
			<nstrgmpr:igtStatus>
				<xsl:value-of select="nsmpr0:IGT_STATUS"/>
			</nstrgmpr:igtStatus>
			<nstrgmpr:agreementType>
				<xsl:value-of select="nsmpr0:AGREEMENT_TYPE"/>
			</nstrgmpr:agreementType>
			<nstrgmpr:assistedAcquisitionInd>
				<xsl:value-of select="nsmpr0:ASSISTED_ACQUISITION_IND"/>
			</nstrgmpr:assistedAcquisitionInd>
			<nstrgmpr:advancePaymentInd>
				<xsl:value-of select="nsmpr0:ADVANCE_PAYMENT_IND"/>
			</nstrgmpr:advancePaymentInd>
			<nstrgmpr:enforceTotalAmtInd>
				<xsl:value-of select="nsmpr0:ENFORCE_TOTAL_AMT_IND"/>
			</nstrgmpr:enforceTotalAmtInd>
			<nstrgmpr:terminationDays>
				<xsl:value-of select="nsmpr0:TERMINATION_DAYS"/>
			</nstrgmpr:terminationDays>
			<nstrgmpr:totalRemainingAmt>
				<xsl:value-of select="nsmpr0:TOTAL_REMAINING_AMT"/>
			</nstrgmpr:totalRemainingAmt>
			<nstrgmpr:igtBusinessTxnId>
				<xsl:value-of select="nsmpr0:IGT_BUSINESS_TXN_ID"/>
			</nstrgmpr:igtBusinessTxnId>
			<nstrgmpr:orderOriginatingInd>
				<xsl:value-of select="nsmpr0:ORDER_ORIGINATING_IND"/>
			</nstrgmpr:orderOriginatingInd>
			<nstrgmpr:igtBizApp>
				<xsl:value-of select="nsmpr0:IGT_BIZ_APP"/>
			</nstrgmpr:igtBizApp>
		</nstrgmpr:poHeader>
	</xsl:template>
</xsl:stylesheet>
