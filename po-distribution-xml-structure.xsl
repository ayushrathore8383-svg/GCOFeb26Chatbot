<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:nstrgmpr="http://xmlns.oracle.com/apps/target" xmlns:nsmpr0="http://xmlns.oracle.com/apps/source">
	<xsl:output indent="yes" method="xml"/>
	<xsl:template match="/">
		<nstrgmpr:poDistribution>
			<nstrgmpr:poDistributionId>
				<xsl:value-of select="nsmpr0:PO_DISTRIBUTION_ID"/>
			</nstrgmpr:poDistributionId>
			<nstrgmpr:lastUpdateDate>
				<xsl:value-of select="nsmpr0:LAST_UPDATE_DATE"/>
			</nstrgmpr:lastUpdateDate>
			<nstrgmpr:lastUpdatedBy>
				<xsl:value-of select="nsmpr0:LAST_UPDATED_BY"/>
			</nstrgmpr:lastUpdatedBy>
			<nstrgmpr:poHeaderId>
				<xsl:value-of select="nsmpr0:PO_HEADER_ID"/>
			</nstrgmpr:poHeaderId>
			<nstrgmpr:poLineId>
				<xsl:value-of select="nsmpr0:PO_LINE_ID"/>
			</nstrgmpr:poLineId>
			<nstrgmpr:lineLocationId>
				<xsl:value-of select="nsmpr0:LINE_LOCATION_ID"/>
			</nstrgmpr:lineLocationId>
			<nstrgmpr:setOfBooksId>
				<xsl:value-of select="nsmpr0:SET_OF_BOOKS_ID"/>
			</nstrgmpr:setOfBooksId>
			<nstrgmpr:codeCombinationId>
				<xsl:value-of select="nsmpr0:CODE_COMBINATION_ID"/>
			</nstrgmpr:codeCombinationId>
			<nstrgmpr:quantityOrdered>
				<xsl:value-of select="nsmpr0:QUANTITY_ORDERED"/>
			</nstrgmpr:quantityOrdered>
			<nstrgmpr:lastUpdateLogin>
				<xsl:value-of select="nsmpr0:LAST_UPDATE_LOGIN"/>
			</nstrgmpr:lastUpdateLogin>
			<nstrgmpr:creationDate>
				<xsl:value-of select="nsmpr0:CREATION_DATE"/>
			</nstrgmpr:creationDate>
			<nstrgmpr:createdBy>
				<xsl:value-of select="nsmpr0:CREATED_BY"/>
			</nstrgmpr:createdBy>
			<nstrgmpr:poReleaseId>
				<xsl:value-of select="nsmpr0:PO_RELEASE_ID"/>
			</nstrgmpr:poReleaseId>
			<nstrgmpr:quantityDelivered>
				<xsl:value-of select="nsmpr0:QUANTITY_DELIVERED"/>
			</nstrgmpr:quantityDelivered>
			<nstrgmpr:quantityBilled>
				<xsl:value-of select="nsmpr0:QUANTITY_BILLED"/>
			</nstrgmpr:quantityBilled>
			<nstrgmpr:quantityCancelled>
				<xsl:value-of select="nsmpr0:QUANTITY_CANCELLED"/>
			</nstrgmpr:quantityCancelled>
			<nstrgmpr:reqHeaderReferenceNum>
				<xsl:value-of select="nsmpr0:REQ_HEADER_REFERENCE_NUM"/>
			</nstrgmpr:reqHeaderReferenceNum>
			<nstrgmpr:reqLineReferenceNum>
				<xsl:value-of select="nsmpr0:REQ_LINE_REFERENCE_NUM"/>
			</nstrgmpr:reqLineReferenceNum>
			<nstrgmpr:reqDistributionId>
				<xsl:value-of select="nsmpr0:REQ_DISTRIBUTION_ID"/>
			</nstrgmpr:reqDistributionId>
			<nstrgmpr:deliverToLocationId>
				<xsl:value-of select="nsmpr0:DELIVER_TO_LOCATION_ID"/>
			</nstrgmpr:deliverToLocationId>
			<nstrgmpr:deliverToPersonId>
				<xsl:value-of select="nsmpr0:DELIVER_TO_PERSON_ID"/>
			</nstrgmpr:deliverToPersonId>
			<nstrgmpr:rateDate>
				<xsl:value-of select="nsmpr0:RATE_DATE"/>
			</nstrgmpr:rateDate>
			<nstrgmpr:rate>
				<xsl:value-of select="nsmpr0:RATE"/>
			</nstrgmpr:rate>
			<nstrgmpr:amountBilled>
				<xsl:value-of select="nsmpr0:AMOUNT_BILLED"/>
			</nstrgmpr:amountBilled>
			<nstrgmpr:accruedFlag>
				<xsl:value-of select="nsmpr0:ACCRUED_FLAG"/>
			</nstrgmpr:accruedFlag>
			<nstrgmpr:encumberedFlag>
				<xsl:value-of select="nsmpr0:ENCUMBERED_FLAG"/>
			</nstrgmpr:encumberedFlag>
			<nstrgmpr:encumberedAmount>
				<xsl:value-of select="nsmpr0:ENCUMBERED_AMOUNT"/>
			</nstrgmpr:encumberedAmount>
			<nstrgmpr:unencumberedQuantity>
				<xsl:value-of select="nsmpr0:UNENCUMBERED_QUANTITY"/>
			</nstrgmpr:unencumberedQuantity>
			<nstrgmpr:unencumberedAmount>
				<xsl:value-of select="nsmpr0:UNENCUMBERED_AMOUNT"/>
			</nstrgmpr:unencumberedAmount>
			<nstrgmpr:failedFundsLookupCode>
				<xsl:value-of select="nsmpr0:FAILED_FUNDS_LOOKUP_CODE"/>
			</nstrgmpr:failedFundsLookupCode>
			<nstrgmpr:glEncumberedDate>
				<xsl:value-of select="nsmpr0:GL_ENCUMBERED_DATE"/>
			</nstrgmpr:glEncumberedDate>
			<nstrgmpr:glEncumberedPeriodName>
				<xsl:value-of select="nsmpr0:GL_ENCUMBERED_PERIOD_NAME"/>
			</nstrgmpr:glEncumberedPeriodName>
			<nstrgmpr:glCancelledDate>
				<xsl:value-of select="nsmpr0:GL_CANCELLED_DATE"/>
			</nstrgmpr:glCancelledDate>
			<nstrgmpr:destinationTypeCode>
				<xsl:value-of select="nsmpr0:DESTINATION_TYPE_CODE"/>
			</nstrgmpr:destinationTypeCode>
			<nstrgmpr:destinationOrganizationId>
				<xsl:value-of select="nsmpr0:DESTINATION_ORGANIZATION_ID"/>
			</nstrgmpr:destinationOrganizationId>
			<nstrgmpr:destinationSubinventory>
				<xsl:value-of select="nsmpr0:DESTINATION_SUBINVENTORY"/>
			</nstrgmpr:destinationSubinventory>
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
			<nstrgmpr:wipEntityId>
				<xsl:value-of select="nsmpr0:WIP_ENTITY_ID"/>
			</nstrgmpr:wipEntityId>
			<nstrgmpr:wipOperationSeqNum>
				<xsl:value-of select="nsmpr0:WIP_OPERATION_SEQ_NUM"/>
			</nstrgmpr:wipOperationSeqNum>
			<nstrgmpr:wipResourceSeqNum>
				<xsl:value-of select="nsmpr0:WIP_RESOURCE_SEQ_NUM"/>
			</nstrgmpr:wipResourceSeqNum>
			<nstrgmpr:wipRepetitiveScheduleId>
				<xsl:value-of select="nsmpr0:WIP_REPETITIVE_SCHEDULE_ID"/>
			</nstrgmpr:wipRepetitiveScheduleId>
			<nstrgmpr:wipLineId>
				<xsl:value-of select="nsmpr0:WIP_LINE_ID"/>
			</nstrgmpr:wipLineId>
			<nstrgmpr:bomResourceId>
				<xsl:value-of select="nsmpr0:BOM_RESOURCE_ID"/>
			</nstrgmpr:bomResourceId>
			<nstrgmpr:budgetAccountId>
				<xsl:value-of select="nsmpr0:BUDGET_ACCOUNT_ID"/>
			</nstrgmpr:budgetAccountId>
			<nstrgmpr:accrualAccountId>
				<xsl:value-of select="nsmpr0:ACCRUAL_ACCOUNT_ID"/>
			</nstrgmpr:accrualAccountId>
			<nstrgmpr:varianceAccountId>
				<xsl:value-of select="nsmpr0:VARIANCE_ACCOUNT_ID"/>
			</nstrgmpr:varianceAccountId>
			<nstrgmpr:preventEncumbranceFlag>
				<xsl:value-of select="nsmpr0:PREVENT_ENCUMBRANCE_FLAG"/>
			</nstrgmpr:preventEncumbranceFlag>
			<nstrgmpr:ussglTransactionCode>
				<xsl:value-of select="nsmpr0:USSGL_TRANSACTION_CODE"/>
			</nstrgmpr:ussglTransactionCode>
			<nstrgmpr:governmentContext>
				<xsl:value-of select="nsmpr0:GOVERNMENT_CONTEXT"/>
			</nstrgmpr:governmentContext>
			<nstrgmpr:destinationContext>
				<xsl:value-of select="nsmpr0:DESTINATION_CONTEXT"/>
			</nstrgmpr:destinationContext>
			<nstrgmpr:distributionNum>
				<xsl:value-of select="nsmpr0:DISTRIBUTION_NUM"/>
			</nstrgmpr:distributionNum>
			<nstrgmpr:sourceDistributionId>
				<xsl:value-of select="nsmpr0:SOURCE_DISTRIBUTION_ID"/>
			</nstrgmpr:sourceDistributionId>
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
			<nstrgmpr:projectId>
				<xsl:value-of select="nsmpr0:PROJECT_ID"/>
			</nstrgmpr:projectId>
			<nstrgmpr:taskId>
				<xsl:value-of select="nsmpr0:TASK_ID"/>
			</nstrgmpr:taskId>
			<nstrgmpr:expenditureType>
				<xsl:value-of select="nsmpr0:EXPENDITURE_TYPE"/>
			</nstrgmpr:expenditureType>
			<nstrgmpr:projectAccountingContext>
				<xsl:value-of select="nsmpr0:PROJECT_ACCOUNTING_CONTEXT"/>
			</nstrgmpr:projectAccountingContext>
			<nstrgmpr:expenditureOrganizationId>
				<xsl:value-of select="nsmpr0:EXPENDITURE_ORGANIZATION_ID"/>
			</nstrgmpr:expenditureOrganizationId>
			<nstrgmpr:glClosedDate>
				<xsl:value-of select="nsmpr0:GL_CLOSED_DATE"/>
			</nstrgmpr:glClosedDate>
			<nstrgmpr:accrueOnReceiptFlag>
				<xsl:value-of select="nsmpr0:ACCRUE_ON_RECEIPT_FLAG"/>
			</nstrgmpr:accrueOnReceiptFlag>
			<nstrgmpr:expenditureItemDate>
				<xsl:value-of select="nsmpr0:EXPENDITURE_ITEM_DATE"/>
			</nstrgmpr:expenditureItemDate>
			<nstrgmpr:orgId>
				<xsl:value-of select="nsmpr0:ORG_ID"/>
			</nstrgmpr:orgId>
			<nstrgmpr:kanbanCardId>
				<xsl:value-of select="nsmpr0:KANBAN_CARD_ID"/>
			</nstrgmpr:kanbanCardId>
			<nstrgmpr:awardId>
				<xsl:value-of select="nsmpr0:AWARD_ID"/>
			</nstrgmpr:awardId>
			<nstrgmpr:mrcRateDate>
				<xsl:value-of select="nsmpr0:MRC_RATE_DATE"/>
			</nstrgmpr:mrcRateDate>
			<nstrgmpr:mrcRate>
				<xsl:value-of select="nsmpr0:MRC_RATE"/>
			</nstrgmpr:mrcRate>
			<nstrgmpr:mrcEncumberedAmount>
				<xsl:value-of select="nsmpr0:MRC_ENCUMBERED_AMOUNT"/>
			</nstrgmpr:mrcEncumberedAmount>
			<nstrgmpr:mrcUnencumberedAmount>
				<xsl:value-of select="nsmpr0:MRC_UNENCUMBERED_AMOUNT"/>
			</nstrgmpr:mrcUnencumberedAmount>
			<nstrgmpr:endItemUnitNumber>
				<xsl:value-of select="nsmpr0:END_ITEM_UNIT_NUMBER"/>
			</nstrgmpr:endItemUnitNumber>
			<nstrgmpr:taxRecoveryOverrideFlag>
				<xsl:value-of select="nsmpr0:TAX_RECOVERY_OVERRIDE_FLAG"/>
			</nstrgmpr:taxRecoveryOverrideFlag>
			<nstrgmpr:recoverableTax>
				<xsl:value-of select="nsmpr0:RECOVERABLE_TAX"/>
			</nstrgmpr:recoverableTax>
			<nstrgmpr:nonrecoverableTax>
				<xsl:value-of select="nsmpr0:NONRECOVERABLE_TAX"/>
			</nstrgmpr:nonrecoverableTax>
			<nstrgmpr:recoveryRate>
				<xsl:value-of select="nsmpr0:RECOVERY_RATE"/>
			</nstrgmpr:recoveryRate>
			<nstrgmpr:okeContractLineId>
				<xsl:value-of select="nsmpr0:OKE_CONTRACT_LINE_ID"/>
			</nstrgmpr:okeContractLineId>
			<nstrgmpr:okeContractDeliverableId>
				<xsl:value-of select="nsmpr0:OKE_CONTRACT_DELIVERABLE_ID"/>
			</nstrgmpr:okeContractDeliverableId>
			<nstrgmpr:amountOrdered>
				<xsl:value-of select="nsmpr0:AMOUNT_ORDERED"/>
			</nstrgmpr:amountOrdered>
			<nstrgmpr:amountDelivered>
				<xsl:value-of select="nsmpr0:AMOUNT_DELIVERED"/>
			</nstrgmpr:amountDelivered>
			<nstrgmpr:amountCancelled>
				<xsl:value-of select="nsmpr0:AMOUNT_CANCELLED"/>
			</nstrgmpr:amountCancelled>
			<nstrgmpr:distributionType>
				<xsl:value-of select="nsmpr0:DISTRIBUTION_TYPE"/>
			</nstrgmpr:distributionType>
			<nstrgmpr:amountToEncumber>
				<xsl:value-of select="nsmpr0:AMOUNT_TO_ENCUMBER"/>
			</nstrgmpr:amountToEncumber>
			<nstrgmpr:invoiceAdjustmentFlag>
				<xsl:value-of select="nsmpr0:INVOICE_ADJUSTMENT_FLAG"/>
			</nstrgmpr:invoiceAdjustmentFlag>
			<nstrgmpr:destChargeAccountId>
				<xsl:value-of select="nsmpr0:DEST_CHARGE_ACCOUNT_ID"/>
			</nstrgmpr:destChargeAccountId>
			<nstrgmpr:destVarianceAccountId>
				<xsl:value-of select="nsmpr0:DEST_VARIANCE_ACCOUNT_ID"/>
			</nstrgmpr:destVarianceAccountId>
			<nstrgmpr:quantityFinanced>
				<xsl:value-of select="nsmpr0:QUANTITY_FINANCED"/>
			</nstrgmpr:quantityFinanced>
			<nstrgmpr:amountFinanced>
				<xsl:value-of select="nsmpr0:AMOUNT_FINANCED"/>
			</nstrgmpr:amountFinanced>
			<nstrgmpr:quantityRecouped>
				<xsl:value-of select="nsmpr0:QUANTITY_RECOUPED"/>
			</nstrgmpr:quantityRecouped>
			<nstrgmpr:amountRecouped>
				<xsl:value-of select="nsmpr0:AMOUNT_RECOUPED"/>
			</nstrgmpr:amountRecouped>
			<nstrgmpr:retainageWithheldAmount>
				<xsl:value-of select="nsmpr0:RETAINAGE_WITHHELD_AMOUNT"/>
			</nstrgmpr:retainageWithheldAmount>
			<nstrgmpr:retainageReleasedAmount>
				<xsl:value-of select="nsmpr0:RETAINAGE_RELEASED_AMOUNT"/>
			</nstrgmpr:retainageReleasedAmount>
			<nstrgmpr:wfItemKey>
				<xsl:value-of select="nsmpr0:WF_ITEM_KEY"/>
			</nstrgmpr:wfItemKey>
			<nstrgmpr:invoicedValInNtfn>
				<xsl:value-of select="nsmpr0:INVOICED_VAL_IN_NTFN"/>
			</nstrgmpr:invoicedValInNtfn>
			<nstrgmpr:taxAttributeUpdateCode>
				<xsl:value-of select="nsmpr0:TAX_ATTRIBUTE_UPDATE_CODE"/>
			</nstrgmpr:taxAttributeUpdateCode>
			<nstrgmpr:interfaceDistributionRef>
				<xsl:value-of select="nsmpr0:INTERFACE_DISTRIBUTION_REF"/>
			</nstrgmpr:interfaceDistributionRef>
			<nstrgmpr:lcmFlag>
				<xsl:value-of select="nsmpr0:LCM_FLAG"/>
			</nstrgmpr:lcmFlag>
			<nstrgmpr:groupLineId>
				<xsl:value-of select="nsmpr0:GROUP_LINE_ID"/>
			</nstrgmpr:groupLineId>
			<nstrgmpr:udaTemplateId>
				<xsl:value-of select="nsmpr0:UDA_TEMPLATE_ID"/>
			</nstrgmpr:udaTemplateId>
			<nstrgmpr:draftId>
				<xsl:value-of select="nsmpr0:DRAFT_ID"/>
			</nstrgmpr:draftId>
			<nstrgmpr:amountFunded>
				<xsl:value-of select="nsmpr0:AMOUNT_FUNDED"/>
			</nstrgmpr:amountFunded>
			<nstrgmpr:fundedValue>
				<xsl:value-of select="nsmpr0:FUNDED_VALUE"/>
			</nstrgmpr:fundedValue>
			<nstrgmpr:partialFundedFlag>
				<xsl:value-of select="nsmpr0:PARTIAL_FUNDED_FLAG"/>
			</nstrgmpr:partialFundedFlag>
			<nstrgmpr:quantityFunded>
				<xsl:value-of select="nsmpr0:QUANTITY_FUNDED"/>
			</nstrgmpr:quantityFunded>
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
			<nstrgmpr:amountChangedFlag>
				<xsl:value-of select="nsmpr0:AMOUNT_CHANGED_FLAG"/>
			</nstrgmpr:amountChangedFlag>
			<nstrgmpr:amountReversed>
				<xsl:value-of select="nsmpr0:AMOUNT_REVERSED"/>
			</nstrgmpr:amountReversed>
			<nstrgmpr:clmMiscLoa>
				<xsl:value-of select="nsmpr0:CLM_MISC_LOA"/>
			</nstrgmpr:clmMiscLoa>
			<nstrgmpr:clmDefenceFunding>
				<xsl:value-of select="nsmpr0:CLM_DEFENCE_FUNDING"/>
			</nstrgmpr:clmDefenceFunding>
			<nstrgmpr:clmFmsCaseNumber>
				<xsl:value-of select="nsmpr0:CLM_FMS_CASE_NUMBER"/>
			</nstrgmpr:clmFmsCaseNumber>
			<nstrgmpr:clmAgencyAcctIdentifier>
				<xsl:value-of select="nsmpr0:CLM_AGENCY_ACCT_IDENTIFIER"/>
			</nstrgmpr:clmAgencyAcctIdentifier>
			<nstrgmpr:changeInFundedValue>
				<xsl:value-of select="nsmpr0:CHANGE_IN_FUNDED_VALUE"/>
			</nstrgmpr:changeInFundedValue>
			<nstrgmpr:acrn>
				<xsl:value-of select="nsmpr0:ACRN"/>
			</nstrgmpr:acrn>
			<nstrgmpr:revisionNum>
				<xsl:value-of select="nsmpr0:REVISION_NUM"/>
			</nstrgmpr:revisionNum>
			<nstrgmpr:clmPaymentSequenceNum>
				<xsl:value-of select="nsmpr0:CLM_PAYMENT_SEQUENCE_NUM"/>
			</nstrgmpr:clmPaymentSequenceNum>
		</nstrgmpr:poDistribution>
	</xsl:template>
</xsl:stylesheet>
