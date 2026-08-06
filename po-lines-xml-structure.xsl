<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:nstrgmpr="http://xmlns.oracle.com/apps/target" xmlns:nsmpr0="http://xmlns.oracle.com/apps/source">
	<xsl:output indent="yes" method="xml"/>
	<xsl:template match="/">
		<nstrgmpr:poLine>
			<nstrgmpr:poLineId>
				<xsl:value-of select="nsmpr0:PO_LINE_ID"/>
			</nstrgmpr:poLineId>
			<nstrgmpr:lastUpdateDate>
				<xsl:value-of select="nsmpr0:LAST_UPDATE_DATE"/>
			</nstrgmpr:lastUpdateDate>
			<nstrgmpr:lastUpdatedBy>
				<xsl:value-of select="nsmpr0:LAST_UPDATED_BY"/>
			</nstrgmpr:lastUpdatedBy>
			<nstrgmpr:poHeaderId>
				<xsl:value-of select="nsmpr0:PO_HEADER_ID"/>
			</nstrgmpr:poHeaderId>
			<nstrgmpr:lineTypeId>
				<xsl:value-of select="nsmpr0:LINE_TYPE_ID"/>
			</nstrgmpr:lineTypeId>
			<nstrgmpr:lineNum>
				<xsl:value-of select="nsmpr0:LINE_NUM"/>
			</nstrgmpr:lineNum>
			<nstrgmpr:lastUpdateLogin>
				<xsl:value-of select="nsmpr0:LAST_UPDATE_LOGIN"/>
			</nstrgmpr:lastUpdateLogin>
			<nstrgmpr:creationDate>
				<xsl:value-of select="nsmpr0:CREATION_DATE"/>
			</nstrgmpr:creationDate>
			<nstrgmpr:createdBy>
				<xsl:value-of select="nsmpr0:CREATED_BY"/>
			</nstrgmpr:createdBy>
			<nstrgmpr:itemId>
				<xsl:value-of select="nsmpr0:ITEM_ID"/>
			</nstrgmpr:itemId>
			<nstrgmpr:itemRevision>
				<xsl:value-of select="nsmpr0:ITEM_REVISION"/>
			</nstrgmpr:itemRevision>
			<nstrgmpr:categoryId>
				<xsl:value-of select="nsmpr0:CATEGORY_ID"/>
			</nstrgmpr:categoryId>
			<nstrgmpr:itemDescription>
				<xsl:value-of select="nsmpr0:ITEM_DESCRIPTION"/>
			</nstrgmpr:itemDescription>
			<nstrgmpr:unitMeasLookupCode>
				<xsl:value-of select="nsmpr0:UNIT_MEAS_LOOKUP_CODE"/>
			</nstrgmpr:unitMeasLookupCode>
			<nstrgmpr:quantityCommitted>
				<xsl:value-of select="nsmpr0:QUANTITY_COMMITTED"/>
			</nstrgmpr:quantityCommitted>
			<nstrgmpr:committedAmount>
				<xsl:value-of select="nsmpr0:COMMITTED_AMOUNT"/>
			</nstrgmpr:committedAmount>
			<nstrgmpr:allowPriceOverrideFlag>
				<xsl:value-of select="nsmpr0:ALLOW_PRICE_OVERRIDE_FLAG"/>
			</nstrgmpr:allowPriceOverrideFlag>
			<nstrgmpr:notToExceedPrice>
				<xsl:value-of select="nsmpr0:NOT_TO_EXCEED_PRICE"/>
			</nstrgmpr:notToExceedPrice>
			<nstrgmpr:listPricePerUnit>
				<xsl:value-of select="nsmpr0:LIST_PRICE_PER_UNIT"/>
			</nstrgmpr:listPricePerUnit>
			<nstrgmpr:unitPrice>
				<xsl:value-of select="nsmpr0:UNIT_PRICE"/>
			</nstrgmpr:unitPrice>
			<nstrgmpr:quantity>
				<xsl:value-of select="nsmpr0:QUANTITY"/>
			</nstrgmpr:quantity>
			<nstrgmpr:unNumberId>
				<xsl:value-of select="nsmpr0:UN_NUMBER_ID"/>
			</nstrgmpr:unNumberId>
			<nstrgmpr:hazardClassId>
				<xsl:value-of select="nsmpr0:HAZARD_CLASS_ID"/>
			</nstrgmpr:hazardClassId>
			<nstrgmpr:noteToVendor>
				<xsl:value-of select="nsmpr0:NOTE_TO_VENDOR"/>
			</nstrgmpr:noteToVendor>
			<nstrgmpr:fromHeaderId>
				<xsl:value-of select="nsmpr0:FROM_HEADER_ID"/>
			</nstrgmpr:fromHeaderId>
			<nstrgmpr:fromLineId>
				<xsl:value-of select="nsmpr0:FROM_LINE_ID"/>
			</nstrgmpr:fromLineId>
			<nstrgmpr:minOrderQuantity>
				<xsl:value-of select="nsmpr0:MIN_ORDER_QUANTITY"/>
			</nstrgmpr:minOrderQuantity>
			<nstrgmpr:maxOrderQuantity>
				<xsl:value-of select="nsmpr0:MAX_ORDER_QUANTITY"/>
			</nstrgmpr:maxOrderQuantity>
			<nstrgmpr:qtyRcvTolerance>
				<xsl:value-of select="nsmpr0:QTY_RCV_TOLERANCE"/>
			</nstrgmpr:qtyRcvTolerance>
			<nstrgmpr:overToleranceErrorFlag>
				<xsl:value-of select="nsmpr0:OVER_TOLERANCE_ERROR_FLAG"/>
			</nstrgmpr:overToleranceErrorFlag>
			<nstrgmpr:marketPrice>
				<xsl:value-of select="nsmpr0:MARKET_PRICE"/>
			</nstrgmpr:marketPrice>
			<nstrgmpr:unorderedFlag>
				<xsl:value-of select="nsmpr0:UNORDERED_FLAG"/>
			</nstrgmpr:unorderedFlag>
			<nstrgmpr:closedFlag>
				<xsl:value-of select="nsmpr0:CLOSED_FLAG"/>
			</nstrgmpr:closedFlag>
			<nstrgmpr:userHoldFlag>
				<xsl:value-of select="nsmpr0:USER_HOLD_FLAG"/>
			</nstrgmpr:userHoldFlag>
			<nstrgmpr:cancelFlag>
				<xsl:value-of select="nsmpr0:CANCEL_FLAG"/>
			</nstrgmpr:cancelFlag>
			<nstrgmpr:cancelledBy>
				<xsl:value-of select="nsmpr0:CANCELLED_BY"/>
			</nstrgmpr:cancelledBy>
			<nstrgmpr:cancelDate>
				<xsl:value-of select="nsmpr0:CANCEL_DATE"/>
			</nstrgmpr:cancelDate>
			<nstrgmpr:cancelReason>
				<xsl:value-of select="nsmpr0:CANCEL_REASON"/>
			</nstrgmpr:cancelReason>
			<nstrgmpr:firmStatusLookupCode>
				<xsl:value-of select="nsmpr0:FIRM_STATUS_LOOKUP_CODE"/>
			</nstrgmpr:firmStatusLookupCode>
			<nstrgmpr:firmDate>
				<xsl:value-of select="nsmpr0:FIRM_DATE"/>
			</nstrgmpr:firmDate>
			<nstrgmpr:vendorProductNum>
				<xsl:value-of select="nsmpr0:VENDOR_PRODUCT_NUM"/>
			</nstrgmpr:vendorProductNum>
			<nstrgmpr:contractNum>
				<xsl:value-of select="nsmpr0:CONTRACT_NUM"/>
			</nstrgmpr:contractNum>
			<nstrgmpr:taxableFlag>
				<xsl:value-of select="nsmpr0:TAXABLE_FLAG"/>
			</nstrgmpr:taxableFlag>
			<nstrgmpr:taxName>
				<xsl:value-of select="nsmpr0:TAX_NAME"/>
			</nstrgmpr:taxName>
			<nstrgmpr:type1099>
				<xsl:value-of select="nsmpr0:TYPE_1099"/>
			</nstrgmpr:type1099>
			<nstrgmpr:capitalExpenseFlag>
				<xsl:value-of select="nsmpr0:CAPITAL_EXPENSE_FLAG"/>
			</nstrgmpr:capitalExpenseFlag>
			<nstrgmpr:negotiatedByPreparerFlag>
				<xsl:value-of select="nsmpr0:NEGOTIATED_BY_PREPARER_FLAG"/>
			</nstrgmpr:negotiatedByPreparerFlag>
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
			<nstrgmpr:referenceNum>
				<xsl:value-of select="nsmpr0:REFERENCE_NUM"/>
			</nstrgmpr:referenceNum>
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
			<nstrgmpr:minReleaseAmount>
				<xsl:value-of select="nsmpr0:MIN_RELEASE_AMOUNT"/>
			</nstrgmpr:minReleaseAmount>
			<nstrgmpr:priceTypeLookupCode>
				<xsl:value-of select="nsmpr0:PRICE_TYPE_LOOKUP_CODE"/>
			</nstrgmpr:priceTypeLookupCode>
			<nstrgmpr:closedCode>
				<xsl:value-of select="nsmpr0:CLOSED_CODE"/>
			</nstrgmpr:closedCode>
			<nstrgmpr:priceBreakLookupCode>
				<xsl:value-of select="nsmpr0:PRICE_BREAK_LOOKUP_CODE"/>
			</nstrgmpr:priceBreakLookupCode>
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
			<nstrgmpr:closedDate>
				<xsl:value-of select="nsmpr0:CLOSED_DATE"/>
			</nstrgmpr:closedDate>
			<nstrgmpr:closedReason>
				<xsl:value-of select="nsmpr0:CLOSED_REASON"/>
			</nstrgmpr:closedReason>
			<nstrgmpr:closedBy>
				<xsl:value-of select="nsmpr0:CLOSED_BY"/>
			</nstrgmpr:closedBy>
			<nstrgmpr:transactionReasonCode>
				<xsl:value-of select="nsmpr0:TRANSACTION_REASON_CODE"/>
			</nstrgmpr:transactionReasonCode>
			<nstrgmpr:orgId>
				<xsl:value-of select="nsmpr0:ORG_ID"/>
			</nstrgmpr:orgId>
			<nstrgmpr:qcGrade>
				<xsl:value-of select="nsmpr0:QC_GRADE"/>
			</nstrgmpr:qcGrade>
			<nstrgmpr:baseUom>
				<xsl:value-of select="nsmpr0:BASE_UOM"/>
			</nstrgmpr:baseUom>
			<nstrgmpr:baseQty>
				<xsl:value-of select="nsmpr0:BASE_QTY"/>
			</nstrgmpr:baseQty>
			<nstrgmpr:secondaryUom>
				<xsl:value-of select="nsmpr0:SECONDARY_UOM"/>
			</nstrgmpr:secondaryUom>
			<nstrgmpr:secondaryQty>
				<xsl:value-of select="nsmpr0:SECONDARY_QTY"/>
			</nstrgmpr:secondaryQty>
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
			<nstrgmpr:lineReferenceNum>
				<xsl:value-of select="nsmpr0:LINE_REFERENCE_NUM"/>
			</nstrgmpr:lineReferenceNum>
			<nstrgmpr:projectId>
				<xsl:value-of select="nsmpr0:PROJECT_ID"/>
			</nstrgmpr:projectId>
			<nstrgmpr:taskId>
				<xsl:value-of select="nsmpr0:TASK_ID"/>
			</nstrgmpr:taskId>
			<nstrgmpr:expirationDate>
				<xsl:value-of select="nsmpr0:EXPIRATION_DATE"/>
			</nstrgmpr:expirationDate>
			<nstrgmpr:taxCodeId>
				<xsl:value-of select="nsmpr0:TAX_CODE_ID"/>
			</nstrgmpr:taxCodeId>
			<nstrgmpr:okeContractHeaderId>
				<xsl:value-of select="nsmpr0:OKE_CONTRACT_HEADER_ID"/>
			</nstrgmpr:okeContractHeaderId>
			<nstrgmpr:okeContractVersionId>
				<xsl:value-of select="nsmpr0:OKE_CONTRACT_VERSION_ID"/>
			</nstrgmpr:okeContractVersionId>
			<nstrgmpr:secondaryQuantity>
				<xsl:value-of select="nsmpr0:SECONDARY_QUANTITY"/>
			</nstrgmpr:secondaryQuantity>
			<nstrgmpr:secondaryUnitOfMeasure>
				<xsl:value-of select="nsmpr0:SECONDARY_UNIT_OF_MEASURE"/>
			</nstrgmpr:secondaryUnitOfMeasure>
			<nstrgmpr:preferredGrade>
				<xsl:value-of select="nsmpr0:PREFERRED_GRADE"/>
			</nstrgmpr:preferredGrade>
			<nstrgmpr:auctionHeaderId>
				<xsl:value-of select="nsmpr0:AUCTION_HEADER_ID"/>
			</nstrgmpr:auctionHeaderId>
			<nstrgmpr:auctionDisplayNumber>
				<xsl:value-of select="nsmpr0:AUCTION_DISPLAY_NUMBER"/>
			</nstrgmpr:auctionDisplayNumber>
			<nstrgmpr:auctionLineNumber>
				<xsl:value-of select="nsmpr0:AUCTION_LINE_NUMBER"/>
			</nstrgmpr:auctionLineNumber>
			<nstrgmpr:bidNumber>
				<xsl:value-of select="nsmpr0:BID_NUMBER"/>
			</nstrgmpr:bidNumber>
			<nstrgmpr:bidLineNumber>
				<xsl:value-of select="nsmpr0:BID_LINE_NUMBER"/>
			</nstrgmpr:bidLineNumber>
			<nstrgmpr:retroactiveDate>
				<xsl:value-of select="nsmpr0:RETROACTIVE_DATE"/>
			</nstrgmpr:retroactiveDate>
			<nstrgmpr:supplierRefNumber>
				<xsl:value-of select="nsmpr0:SUPPLIER_REF_NUMBER"/>
			</nstrgmpr:supplierRefNumber>
			<nstrgmpr:contractId>
				<xsl:value-of select="nsmpr0:CONTRACT_ID"/>
			</nstrgmpr:contractId>
			<nstrgmpr:startDate>
				<xsl:value-of select="nsmpr0:START_DATE"/>
			</nstrgmpr:startDate>
			<nstrgmpr:amount>
				<xsl:value-of select="nsmpr0:AMOUNT"/>
			</nstrgmpr:amount>
			<nstrgmpr:jobId>
				<xsl:value-of select="nsmpr0:JOB_ID"/>
			</nstrgmpr:jobId>
			<nstrgmpr:contractorFullName>
				<xsl:value-of select="nsmpr0:CONTRACTOR_FULL_NAME"/>
			</nstrgmpr:contractorFullName>
			<nstrgmpr:manualPriceChangeFlag>
				<xsl:value-of select="nsmpr0:MANUAL_PRICE_CHANGE_FLAG"/>
			</nstrgmpr:manualPriceChangeFlag>
			<nstrgmpr:contractorFirstName>
				<xsl:value-of select="nsmpr0:CONTRACTOR_FIRST_NAME"/>
			</nstrgmpr:contractorFirstName>
			<nstrgmpr:contractorLastName>
				<xsl:value-of select="nsmpr0:CONTRACTOR_LAST_NAME"/>
			</nstrgmpr:contractorLastName>
			<nstrgmpr:fromLineLocationId>
				<xsl:value-of select="nsmpr0:FROM_LINE_LOCATION_ID"/>
			</nstrgmpr:fromLineLocationId>
			<nstrgmpr:orderTypeLookupCode>
				<xsl:value-of select="nsmpr0:ORDER_TYPE_LOOKUP_CODE"/>
			</nstrgmpr:orderTypeLookupCode>
			<nstrgmpr:purchaseBasis>
				<xsl:value-of select="nsmpr0:PURCHASE_BASIS"/>
			</nstrgmpr:purchaseBasis>
			<nstrgmpr:matchingBasis>
				<xsl:value-of select="nsmpr0:MATCHING_BASIS"/>
			</nstrgmpr:matchingBasis>
			<nstrgmpr:svcAmountNotifSent>
				<xsl:value-of select="nsmpr0:SVC_AMOUNT_NOTIF_SENT"/>
			</nstrgmpr:svcAmountNotifSent>
			<nstrgmpr:svcCompletionNotifSent>
				<xsl:value-of select="nsmpr0:SVC_COMPLETION_NOTIF_SENT"/>
			</nstrgmpr:svcCompletionNotifSent>
			<nstrgmpr:baseUnitPrice>
				<xsl:value-of select="nsmpr0:BASE_UNIT_PRICE"/>
			</nstrgmpr:baseUnitPrice>
			<nstrgmpr:catalogName>
				<xsl:value-of select="nsmpr0:CATALOG_NAME"/>
			</nstrgmpr:catalogName>
			<nstrgmpr:supplierPartAuxid>
				<xsl:value-of select="nsmpr0:SUPPLIER_PART_AUXID"/>
			</nstrgmpr:supplierPartAuxid>
			<nstrgmpr:ipCategoryId>
				<xsl:value-of select="nsmpr0:IP_CATEGORY_ID"/>
			</nstrgmpr:ipCategoryId>
			<nstrgmpr:lastUpdatedProgram>
				<xsl:value-of select="nsmpr0:LAST_UPDATED_PROGRAM"/>
			</nstrgmpr:lastUpdatedProgram>
			<nstrgmpr:retainageRate>
				<xsl:value-of select="nsmpr0:RETAINAGE_RATE"/>
			</nstrgmpr:retainageRate>
			<nstrgmpr:maxRetainageAmount>
				<xsl:value-of select="nsmpr0:MAX_RETAINAGE_AMOUNT"/>
			</nstrgmpr:maxRetainageAmount>
			<nstrgmpr:progressPaymentRate>
				<xsl:value-of select="nsmpr0:PROGRESS_PAYMENT_RATE"/>
			</nstrgmpr:progressPaymentRate>
			<nstrgmpr:recoupmentRate>
				<xsl:value-of select="nsmpr0:RECOUPMENT_RATE"/>
			</nstrgmpr:recoupmentRate>
			<nstrgmpr:taxAttributeUpdateCode>
				<xsl:value-of select="nsmpr0:TAX_ATTRIBUTE_UPDATE_CODE"/>
			</nstrgmpr:taxAttributeUpdateCode>
			<nstrgmpr:groupLineId>
				<xsl:value-of select="nsmpr0:GROUP_LINE_ID"/>
			</nstrgmpr:groupLineId>
			<nstrgmpr:lineNumDisplay>
				<xsl:value-of select="nsmpr0:LINE_NUM_DISPLAY"/>
			</nstrgmpr:lineNumDisplay>
			<nstrgmpr:clmInfoFlag>
				<xsl:value-of select="nsmpr0:CLM_INFO_FLAG"/>
			</nstrgmpr:clmInfoFlag>
			<nstrgmpr:clmOptionIndicator>
				<xsl:value-of select="nsmpr0:CLM_OPTION_INDICATOR"/>
			</nstrgmpr:clmOptionIndicator>
			<nstrgmpr:clmBaseLineNum>
				<xsl:value-of select="nsmpr0:CLM_BASE_LINE_NUM"/>
			</nstrgmpr:clmBaseLineNum>
			<nstrgmpr:clmOptionNum>
				<xsl:value-of select="nsmpr0:CLM_OPTION_NUM"/>
			</nstrgmpr:clmOptionNum>
			<nstrgmpr:clmOptionFromDate>
				<xsl:value-of select="nsmpr0:CLM_OPTION_FROM_DATE"/>
			</nstrgmpr:clmOptionFromDate>
			<nstrgmpr:clmOptionToDate>
				<xsl:value-of select="nsmpr0:CLM_OPTION_TO_DATE"/>
			</nstrgmpr:clmOptionToDate>
			<nstrgmpr:clmFundedFlag>
				<xsl:value-of select="nsmpr0:CLM_FUNDED_FLAG"/>
			</nstrgmpr:clmFundedFlag>
			<nstrgmpr:contractType>
				<xsl:value-of select="nsmpr0:CONTRACT_TYPE"/>
			</nstrgmpr:contractType>
			<nstrgmpr:costConstraint>
				<xsl:value-of select="nsmpr0:COST_CONSTRAINT"/>
			</nstrgmpr:costConstraint>
			<nstrgmpr:clmIdcType>
				<xsl:value-of select="nsmpr0:CLM_IDC_TYPE"/>
			</nstrgmpr:clmIdcType>
			<nstrgmpr:udaTemplateId>
				<xsl:value-of select="nsmpr0:UDA_TEMPLATE_ID"/>
			</nstrgmpr:udaTemplateId>
			<nstrgmpr:userDocumentStatus>
				<xsl:value-of select="nsmpr0:USER_DOCUMENT_STATUS"/>
			</nstrgmpr:userDocumentStatus>
			<nstrgmpr:draftId>
				<xsl:value-of select="nsmpr0:DRAFT_ID"/>
			</nstrgmpr:draftId>
			<nstrgmpr:clmExercisedFlag>
				<xsl:value-of select="nsmpr0:CLM_EXERCISED_FLAG"/>
			</nstrgmpr:clmExercisedFlag>
			<nstrgmpr:clmExercisedDate>
				<xsl:value-of select="nsmpr0:CLM_EXERCISED_DATE"/>
			</nstrgmpr:clmExercisedDate>
			<nstrgmpr:clmMinTotalAmount>
				<xsl:value-of select="nsmpr0:CLM_MIN_TOTAL_AMOUNT"/>
			</nstrgmpr:clmMinTotalAmount>
			<nstrgmpr:clmMaxTotalAmount>
				<xsl:value-of select="nsmpr0:CLM_MAX_TOTAL_AMOUNT"/>
			</nstrgmpr:clmMaxTotalAmount>
			<nstrgmpr:clmMinTotalQuantity>
				<xsl:value-of select="nsmpr0:CLM_MIN_TOTAL_QUANTITY"/>
			</nstrgmpr:clmMinTotalQuantity>
			<nstrgmpr:clmMaxTotalQuantity>
				<xsl:value-of select="nsmpr0:CLM_MAX_TOTAL_QUANTITY"/>
			</nstrgmpr:clmMaxTotalQuantity>
			<nstrgmpr:clmMinOrderAmount>
				<xsl:value-of select="nsmpr0:CLM_MIN_ORDER_AMOUNT"/>
			</nstrgmpr:clmMinOrderAmount>
			<nstrgmpr:clmMaxOrderAmount>
				<xsl:value-of select="nsmpr0:CLM_MAX_ORDER_AMOUNT"/>
			</nstrgmpr:clmMaxOrderAmount>
			<nstrgmpr:clmMinOrderQuantity>
				<xsl:value-of select="nsmpr0:CLM_MIN_ORDER_QUANTITY"/>
			</nstrgmpr:clmMinOrderQuantity>
			<nstrgmpr:clmMaxOrderQuantity>
				<xsl:value-of select="nsmpr0:CLM_MAX_ORDER_QUANTITY"/>
			</nstrgmpr:clmMaxOrderQuantity>
			<nstrgmpr:clmTotalAmountOrdered>
				<xsl:value-of select="nsmpr0:CLM_TOTAL_AMOUNT_ORDERED"/>
			</nstrgmpr:clmTotalAmountOrdered>
			<nstrgmpr:clmTotalQuantityOrdered>
				<xsl:value-of select="nsmpr0:CLM_TOTAL_QUANTITY_ORDERED"/>
			</nstrgmpr:clmTotalQuantityOrdered>
			<nstrgmpr:clmFscPsc>
				<xsl:value-of select="nsmpr0:CLM_FSC_PSC"/>
			</nstrgmpr:clmFscPsc>
			<nstrgmpr:clmMdapsMais>
				<xsl:value-of select="nsmpr0:CLM_MDAPS_MAIS"/>
			</nstrgmpr:clmMdapsMais>
			<nstrgmpr:clmNaics>
				<xsl:value-of select="nsmpr0:CLM_NAICS"/>
			</nstrgmpr:clmNaics>
			<nstrgmpr:clmOrderStartDate>
				<xsl:value-of select="nsmpr0:CLM_ORDER_START_DATE"/>
			</nstrgmpr:clmOrderStartDate>
			<nstrgmpr:clmOrderEndDate>
				<xsl:value-of select="nsmpr0:CLM_ORDER_END_DATE"/>
			</nstrgmpr:clmOrderEndDate>
			<nstrgmpr:revisionNum>
				<xsl:value-of select="nsmpr0:REVISION_NUM"/>
			</nstrgmpr:revisionNum>
			<nstrgmpr:clmApprovedUndefAmount>
				<xsl:value-of select="nsmpr0:CLM_APPROVED_UNDEF_AMOUNT"/>
			</nstrgmpr:clmApprovedUndefAmount>
			<nstrgmpr:clmDeliveryEventCode>
				<xsl:value-of select="nsmpr0:CLM_DELIVERY_EVENT_CODE"/>
			</nstrgmpr:clmDeliveryEventCode>
			<nstrgmpr:clmExhibitName>
				<xsl:value-of select="nsmpr0:CLM_EXHIBIT_NAME"/>
			</nstrgmpr:clmExhibitName>
			<nstrgmpr:clmPaymentInstrCode>
				<xsl:value-of select="nsmpr0:CLM_PAYMENT_INSTR_CODE"/>
			</nstrgmpr:clmPaymentInstrCode>
			<nstrgmpr:clmPopExceptionReason>
				<xsl:value-of select="nsmpr0:CLM_POP_EXCEPTION_REASON"/>
			</nstrgmpr:clmPopExceptionReason>
			<nstrgmpr:clmUdaPricingTotal>
				<xsl:value-of select="nsmpr0:CLM_UDA_PRICING_TOTAL"/>
			</nstrgmpr:clmUdaPricingTotal>
			<nstrgmpr:clmUndefActionCode>
				<xsl:value-of select="nsmpr0:CLM_UNDEF_ACTION_CODE"/>
			</nstrgmpr:clmUndefActionCode>
			<nstrgmpr:clmUndefFlag>
				<xsl:value-of select="nsmpr0:CLM_UNDEF_FLAG"/>
			</nstrgmpr:clmUndefFlag>
			<nstrgmpr:schedulesRequiredFlag>
				<xsl:value-of select="nsmpr0:SCHEDULES_REQUIRED_FLAG"/>
			</nstrgmpr:schedulesRequiredFlag>
			<nstrgmpr:cancelReason1>
				<xsl:value-of select="nsmpr0:CANCEL_REASON#1"/>
			</nstrgmpr:cancelReason1>
			<nstrgmpr:closedReason1>
				<xsl:value-of select="nsmpr0:CLOSED_REASON#1"/>
			</nstrgmpr:closedReason1>
			<nstrgmpr:igtLineStatus>
				<xsl:value-of select="nsmpr0:IGT_LINE_STATUS"/>
			</nstrgmpr:igtLineStatus>
		</nstrgmpr:poLine>
	</xsl:template>
</xsl:stylesheet>
