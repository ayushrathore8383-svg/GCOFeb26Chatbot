<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:nstrgmpr="http://po.line.location.structure"
                xmlns:nsmpr0="http://source.data">

  <xsl:template match="/">
    <nstrgmpr:poLineLocation>
      <nstrgmpr:lineLocationId>
        <xsl:value-of select="nsmpr0:LINE_LOCATION_ID"/>
      </nstrgmpr:lineLocationId>
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
      <nstrgmpr:lastUpdateLogin>
        <xsl:value-of select="nsmpr0:LAST_UPDATE_LOGIN"/>
      </nstrgmpr:lastUpdateLogin>
      <nstrgmpr:creationDate>
        <xsl:value-of select="nsmpr0:CREATION_DATE"/>
      </nstrgmpr:creationDate>
      <nstrgmpr:createdBy>
        <xsl:value-of select="nsmpr0:CREATED_BY"/>
      </nstrgmpr:createdBy>
      <nstrgmpr:quantity>
        <xsl:value-of select="nsmpr0:QUANTITY"/>
      </nstrgmpr:quantity>
      <nstrgmpr:quantityReceived>
        <xsl:value-of select="nsmpr0:QUANTITY_RECEIVED"/>
      </nstrgmpr:quantityReceived>
      <nstrgmpr:quantityAccepted>
        <xsl:value-of select="nsmpr0:QUANTITY_ACCEPTED"/>
      </nstrgmpr:quantityAccepted>
      <nstrgmpr:quantityRejected>
        <xsl:value-of select="nsmpr0:QUANTITY_REJECTED"/>
      </nstrgmpr:quantityRejected>
      <nstrgmpr:quantityBilled>
        <xsl:value-of select="nsmpr0:QUANTITY_BILLED"/>
      </nstrgmpr:quantityBilled>
      <nstrgmpr:quantityCancelled>
        <xsl:value-of select="nsmpr0:QUANTITY_CANCELLED"/>
      </nstrgmpr:quantityCancelled>
      <nstrgmpr:unitMeasLookupCode>
        <xsl:value-of select="nsmpr0:UNIT_MEAS_LOOKUP_CODE"/>
      </nstrgmpr:unitMeasLookupCode>
      <nstrgmpr:poReleaseId>
        <xsl:value-of select="nsmpr0:PO_RELEASE_ID"/>
      </nstrgmpr:poReleaseId>
      <nstrgmpr:shipToLocationId>
        <xsl:value-of select="nsmpr0:SHIP_TO_LOCATION_ID"/>
      </nstrgmpr:shipToLocationId>
      <nstrgmpr:shipViaLookupCode>
        <xsl:value-of select="nsmpr0:SHIP_VIA_LOOKUP_CODE"/>
      </nstrgmpr:shipViaLookupCode>
      <nstrgmpr:needByDate>
        <xsl:value-of select="nsmpr0:NEED_BY_DATE"/>
      </nstrgmpr:needByDate>
      <nstrgmpr:promisedDate>
        <xsl:value-of select="nsmpr0:PROMISED_DATE"/>
      </nstrgmpr:promisedDate>
      <nstrgmpr:lastAcceptDate>
        <xsl:value-of select="nsmpr0:LAST_ACCEPT_DATE"/>
      </nstrgmpr:lastAcceptDate>
      <nstrgmpr:priceOverride>
        <xsl:value-of select="nsmpr0:PRICE_OVERRIDE"/>
      </nstrgmpr:priceOverride>
      <nstrgmpr:encumberedFlag>
        <xsl:value-of select="nsmpr0:ENCUMBERED_FLAG"/>
      </nstrgmpr:encumberedFlag>
      <nstrgmpr:encumberedDate>
        <xsl:value-of select="nsmpr0:ENCUMBERED_DATE"/>
      </nstrgmpr:encumberedDate>
      <nstrgmpr:unencumberedQuantity>
        <xsl:value-of select="nsmpr0:UNENCUMBERED_QUANTITY"/>
      </nstrgmpr:unencumberedQuantity>
      <nstrgmpr:fobLookupCode>
        <xsl:value-of select="nsmpr0:FOB_LOOKUP_CODE"/>
      </nstrgmpr:fobLookupCode>
      <nstrgmpr:freightTermsLookupCode>
        <xsl:value-of select="nsmpr0:FREIGHT_TERMS_LOOKUP_CODE"/>
      </nstrgmpr:freightTermsLookupCode>
      <nstrgmpr:taxableFlag>
        <xsl:value-of select="nsmpr0:TAXABLE_FLAG"/>
      </nstrgmpr:taxableFlag>
      <nstrgmpr:taxName>
        <xsl:value-of select="nsmpr0:TAX_NAME"/>
      </nstrgmpr:taxName>
      <nstrgmpr:estimatedTaxAmount>
        <xsl:value-of select="nsmpr0:ESTIMATED_TAX_AMOUNT"/>
      </nstrgmpr:estimatedTaxAmount>
      <nstrgmpr:fromHeaderId>
        <xsl:value-of select="nsmpr0:FROM_HEADER_ID"/>
      </nstrgmpr:fromHeaderId>
      <nstrgmpr:fromLineId>
        <xsl:value-of select="nsmpr0:FROM_LINE_ID"/>
      </nstrgmpr:fromLineId>
      <nstrgmpr:fromLineLocationId>
        <xsl:value-of select="nsmpr0:FROM_LINE_LOCATION_ID"/>
      </nstrgmpr:fromLineLocationId>
      <nstrgmpr:startDate>
        <xsl:value-of select="nsmpr0:START_DATE"/>
      </nstrgmpr:startDate>
      <nstrgmpr:endDate>
        <xsl:value-of select="nsmpr0:END_DATE"/>
      </nstrgmpr:endDate>
      <nstrgmpr:leadTime>
        <xsl:value-of select="nsmpr0:LEAD_TIME"/>
      </nstrgmpr:leadTime>
      <nstrgmpr:leadTimeUnit>
        <xsl:value-of select="nsmpr0:LEAD_TIME_UNIT"/>
      </nstrgmpr:leadTimeUnit>
      <nstrgmpr:priceDiscount>
        <xsl:value-of select="nsmpr0:PRICE_DISCOUNT"/>
      </nstrgmpr:priceDiscount>
      <nstrgmpr:termsId>
        <xsl:value-of select="nsmpr0:TERMS_ID"/>
      </nstrgmpr:termsId>
      <nstrgmpr:approvedFlag>
        <xsl:value-of select="nsmpr0:APPROVED_FLAG"/>
      </nstrgmpr:approvedFlag>
      <nstrgmpr:approvedDate>
        <xsl:value-of select="nsmpr0:APPROVED_DATE"/>
      </nstrgmpr:approvedDate>
      <nstrgmpr:closedFlag>
        <xsl:value-of select="nsmpr0:CLOSED_FLAG"/>
      </nstrgmpr:closedFlag>
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
      <nstrgmpr:unitOfMeasureClass>
        <xsl:value-of select="nsmpr0:UNIT_OF_MEASURE_CLASS"/>
      </nstrgmpr:unitOfMeasureClass>
      <nstrgmpr:encumberNow>
        <xsl:value-of select="nsmpr0:ENCUMBER_NOW"/>
      </nstrgmpr:encumberNow>
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
      <nstrgmpr:inspectionRequiredFlag>
        <xsl:value-of select="nsmpr0:INSPECTION_REQUIRED_FLAG"/>
      </nstrgmpr:inspectionRequiredFlag>
      <nstrgmpr:receiptRequiredFlag>
        <xsl:value-of select="nsmpr0:RECEIPT_REQUIRED_FLAG"/>
      </nstrgmpr:receiptRequiredFlag>
      <nstrgmpr:qtyRcvTolerance>
        <xsl:value-of select="nsmpr0:QTY_RCV_TOLERANCE"/>
      </nstrgmpr:qtyRcvTolerance>
      <nstrgmpr:qtyRcvExceptionCode>
        <xsl:value-of select="nsmpr0:QTY_RCV_EXCEPTION_CODE"/>
      </nstrgmpr:qtyRcvExceptionCode>
      <nstrgmpr:enforceShipToLocationCode>
        <xsl:value-of select="nsmpr0:ENFORCE_SHIP_TO_LOCATION_CODE"/>
      </nstrgmpr:enforceShipToLocationCode>
      <nstrgmpr:allowSubstituteReceiptsFlag>
        <xsl:value-of select="nsmpr0:ALLOW_SUBSTITUTE_RECEIPTS_FLAG"/>
      </nstrgmpr:allowSubstituteReceiptsFlag>
      <nstrgmpr:daysEarlyReceiptAllowed>
        <xsl:value-of select="nsmpr0:DAYS_EARLY_RECEIPT_ALLOWED"/>
      </nstrgmpr:daysEarlyReceiptAllowed>
      <nstrgmpr:daysLateReceiptAllowed>
        <xsl:value-of select="nsmpr0:DAYS_LATE_RECEIPT_ALLOWED"/>
      </nstrgmpr:daysLateReceiptAllowed>
      <nstrgmpr:receiptDaysExceptionCode>
        <xsl:value-of select="nsmpr0:RECEIPT_DAYS_EXCEPTION_CODE"/>
      </nstrgmpr:receiptDaysExceptionCode>
      <nstrgmpr:invoiceCloseTolerance>
        <xsl:value-of select="nsmpr0:INVOICE_CLOSE_TOLERANCE"/>
      </nstrgmpr:invoiceCloseTolerance>
      <nstrgmpr:receiveCloseTolerance>
        <xsl:value-of select="nsmpr0:RECEIVE_CLOSE_TOLERANCE"/>
      </nstrgmpr:receiveCloseTolerance>
      <nstrgmpr:shipToOrganizationId>
        <xsl:value-of select="nsmpr0:SHIP_TO_ORGANIZATION_ID"/>
      </nstrgmpr:shipToOrganizationId>
      <nstrgmpr:shipmentNum>
        <xsl:value-of select="nsmpr0:SHIPMENT_NUM"/>
      </nstrgmpr:shipmentNum>
      <nstrgmpr:sourceShipmentId>
        <xsl:value-of select="nsmpr0:SOURCE_SHIPMENT_ID"/>
      </nstrgmpr:sourceShipmentId>
      <nstrgmpr:shipmentType>
        <xsl:value-of select="nsmpr0:SHIPMENT_TYPE"/>
      </nstrgmpr:shipmentType>
      <nstrgmpr:closedCode>
        <xsl:value-of select="nsmpr0:CLOSED_CODE"/>
      </nstrgmpr:closedCode>
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
      <nstrgmpr:ussglTransactionCode>
        <xsl:value-of select="nsmpr0:USSGL_TRANSACTION_CODE"/>
      </nstrgmpr:ussglTransactionCode>
      <nstrgmpr:governmentContext>
        <xsl:value-of select="nsmpr0:GOVERNMENT_CONTEXT"/>
      </nstrgmpr:governmentContext>
      <nstrgmpr:receivingRoutingId>
        <xsl:value-of select="nsmpr0:RECEIVING_ROUTING_ID"/>
      </nstrgmpr:receivingRoutingId>
      <nstrgmpr:accrueOnReceiptFlag>
        <xsl:value-of select="nsmpr0:ACCRUE_ON_RECEIPT_FLAG"/>
      </nstrgmpr:accrueOnReceiptFlag>
      <nstrgmpr:closedReason>
        <xsl:value-of select="nsmpr0:CLOSED_REASON"/>
      </nstrgmpr:closedReason>
      <nstrgmpr:closedDate>
        <xsl:value-of select="nsmpr0:CLOSED_DATE"/>
      </nstrgmpr:closedDate>
      <nstrgmpr:closedBy>
        <xsl:value-of select="nsmpr0:CLOSED_BY"/>
      </nstrgmpr:closedBy>
      <nstrgmpr:orgId>
        <xsl:value-of select="nsmpr0:ORG_ID"/>
      </nstrgmpr:orgId>
      <nstrgmpr:quantityShipped>
        <xsl:value-of select="nsmpr0:QUANTITY_SHIPPED"/>
      </nstrgmpr:quantityShipped>
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
      <nstrgmpr:countryOfOriginCode>
        <xsl:value-of select="nsmpr0:COUNTRY_OF_ORIGIN_CODE"/>
      </nstrgmpr:countryOfOriginCode>
      <nstrgmpr:taxUserOverrideFlag>
        <xsl:value-of select="nsmpr0:TAX_USER_OVERRIDE_FLAG"/>
      </nstrgmpr:taxUserOverrideFlag>
      <nstrgmpr:matchOption>
        <xsl:value-of select="nsmpr0:MATCH_OPTION"/>
      </nstrgmpr:matchOption>
      <nstrgmpr:taxCodeId>
        <xsl:value-of select="nsmpr0:TAX_CODE_ID"/>
      </nstrgmpr:taxCodeId>
      <nstrgmpr:calculateTaxFlag>
        <xsl:value-of select="nsmpr0:CALCULATE_TAX_FLAG"/>
      </nstrgmpr:calculateTaxFlag>
      <nstrgmpr:changePromisedDateReason>
        <xsl:value-of select="nsmpr0:CHANGE_PROMISED_DATE_REASON"/>
      </nstrgmpr:changePromisedDateReason>
      <nstrgmpr:noteToReceiver>
        <xsl:value-of select="nsmpr0:NOTE_TO_RECEIVER"/>
      </nstrgmpr:noteToReceiver>
      <nstrgmpr:secondaryQuantity>
        <xsl:value-of select="nsmpr0:SECONDARY_QUANTITY"/>
      </nstrgmpr:secondaryQuantity>
      <nstrgmpr:secondaryUnitOfMeasure>
        <xsl:value-of select="nsmpr0:SECONDARY_UNIT_OF_MEASURE"/>
      </nstrgmpr:secondaryUnitOfMeasure>
      <nstrgmpr:preferredGrade>
        <xsl:value-of select="nsmpr0:PREFERRED_GRADE"/>
      </nstrgmpr:preferredGrade>
      <nstrgmpr:secondaryQuantityReceived>
        <xsl:value-of select="nsmpr0:SECONDARY_QUANTITY_RECEIVED"/>
      </nstrgmpr:secondaryQuantityReceived>
      <nstrgmpr:secondaryQuantityAccepted>
        <xsl:value-of select="nsmpr0:SECONDARY_QUANTITY_ACCEPTED"/>
      </nstrgmpr:secondaryQuantityAccepted>
      <nstrgmpr:secondaryQuantityRejected>
        <xsl:value-of select="nsmpr0:SECONDARY_QUANTITY_REJECTED"/>
      </nstrgmpr:secondaryQuantityRejected>
      <nstrgmpr:secondaryQuantityCancelled>
        <xsl:value-of select="nsmpr0:SECONDARY_QUANTITY_CANCELLED"/>
      </nstrgmpr:secondaryQuantityCancelled>
      <nstrgmpr:vmiFlag>
        <xsl:value-of select="nsmpr0:VMI_FLAG"/>
      </nstrgmpr:vmiFlag>
      <nstrgmpr:consignedFlag>
        <xsl:value-of select="nsmpr0:CONSIGNED_FLAG"/>
      </nstrgmpr:consignedFlag>
      <nstrgmpr:retroactiveDate>
        <xsl:value-of select="nsmpr0:RETROACTIVE_DATE"/>
      </nstrgmpr:retroactiveDate>
      <nstrgmpr:supplierOrderLineNumber>
        <xsl:value-of select="nsmpr0:SUPPLIER_ORDER_LINE_NUMBER"/>
      </nstrgmpr:supplierOrderLineNumber>
      <nstrgmpr:amount>
        <xsl:value-of select="nsmpr0:AMOUNT"/>
      </nstrgmpr:amount>
      <nstrgmpr:amountReceived>
        <xsl:value-of select="nsmpr0:AMOUNT_RECEIVED"/>
      </nstrgmpr:amountReceived>
      <nstrgmpr:amountBilled>
        <xsl:value-of select="nsmpr0:AMOUNT_BILLED"/>
      </nstrgmpr:amountBilled>
      <nstrgmpr:amountCancelled>
        <xsl:value-of select="nsmpr0:AMOUNT_CANCELLED"/>
      </nstrgmpr:amountCancelled>
      <nstrgmpr:amountRejected>
        <xsl:value-of select="nsmpr0:AMOUNT_REJECTED"/>
      </nstrgmpr:amountRejected>
      <nstrgmpr:amountAccepted>
        <xsl:value-of select="nsmpr0:AMOUNT_ACCEPTED"/>
      </nstrgmpr:amountAccepted>
      <nstrgmpr:dropShipFlag>
        <xsl:value-of select="nsmpr0:DROP_SHIP_FLAG"/>
      </nstrgmpr:dropShipFlag>
      <nstrgmpr:salesOrderUpdateDate>
        <xsl:value-of select="nsmpr0:SALES_ORDER_UPDATE_DATE"/>
      </nstrgmpr:salesOrderUpdateDate>
      <nstrgmpr:transactionFlowHeaderId>
        <xsl:value-of select="nsmpr0:TRANSACTION_FLOW_HEADER_ID"/>
      </nstrgmpr:transactionFlowHeaderId>
      <nstrgmpr:manualPriceChangeFlag>
        <xsl:value-of select="nsmpr0:MANUAL_PRICE_CHANGE_FLAG"/>
      </nstrgmpr:manualPriceChangeFlag>
      <nstrgmpr:finalMatchFlag>
        <xsl:value-of select="nsmpr0:FINAL_MATCH_FLAG"/>
      </nstrgmpr:finalMatchFlag>
      <nstrgmpr:shipmentClosedDate>
        <xsl:value-of select="nsmpr0:SHIPMENT_CLOSED_DATE"/>
      </nstrgmpr:shipmentClosedDate>
      <nstrgmpr:closedForReceivingDate>
        <xsl:value-of select="nsmpr0:CLOSED_FOR_RECEIVING_DATE"/>
      </nstrgmpr:closedForReceivingDate>
      <nstrgmpr:closedForInvoiceDate>
        <xsl:value-of select="nsmpr0:CLOSED_FOR_INVOICE_DATE"/>
      </nstrgmpr:closedForInvoiceDate>
      <nstrgmpr:secondaryQuantityShipped>
        <xsl:value-of select="nsmpr0:SECONDARY_QUANTITY_SHIPPED"/>
      </nstrgmpr:secondaryQuantityShipped>
      <nstrgmpr:valueBasis>
        <xsl:value-of select="nsmpr0:VALUE_BASIS"/>
      </nstrgmpr:valueBasis>
      <nstrgmpr:matchingBasis>
        <xsl:value-of select="nsmpr0:MATCHING_BASIS"/>
      </nstrgmpr:matchingBasis>
      <nstrgmpr:paymentType>
        <xsl:value-of select="nsmpr0:PAYMENT_TYPE"/>
      </nstrgmpr:paymentType>
      <nstrgmpr:description>
        <xsl:value-of select="nsmpr0:DESCRIPTION"/>
      </nstrgmpr:description>
      <nstrgmpr:workApproverId>
        <xsl:value-of select="nsmpr0:WORK_APPROVER_ID"/>
      </nstrgmpr:workApproverId>
      <nstrgmpr:bidPaymentId>
        <xsl:value-of select="nsmpr0:BID_PAYMENT_ID"/>
      </nstrgmpr:bidPaymentId>
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
      <nstrgmpr:amountShipped>
        <xsl:value-of select="nsmpr0:AMOUNT_SHIPPED"/>
      </nstrgmpr:amountShipped>
      <nstrgmpr:outsourcedAssembly>
        <xsl:value-of select="nsmpr0:OUTSOURCED_ASSEMBLY"/>
      </nstrgmpr:outsourcedAssembly>
      <nstrgmpr:taxAttributeUpdateCode>
        <xsl:value-of select="nsmpr0:TAX_ATTRIBUTE_UPDATE_CODE"/>
      </nstrgmpr:taxAttributeUpdateCode>
      <nstrgmpr:originalShipmentId>
        <xsl:value-of select="nsmpr0:ORIGINAL_SHIPMENT_ID"/>
      </nstrgmpr:originalShipmentId>
      <nstrgmpr:lcmFlag>
        <xsl:value-of select="nsmpr0:LCM_FLAG"/>
      </nstrgmpr:lcmFlag>
      <nstrgmpr:udaTemplateId>
        <xsl:value-of select="nsmpr0:UDA_TEMPLATE_ID"/>
      </nstrgmpr:udaTemplateId>
      <nstrgmpr:draftId>
        <xsl:value-of select="nsmpr0:DRAFT_ID"/>
      </nstrgmpr:draftId>
      <nstrgmpr:clmPeriodPerfEndDate>
        <xsl:value-of select="nsmpr0:CLM_PERIOD_PERF_END_DATE"/>
      </nstrgmpr:clmPeriodPerfEndDate>
      <nstrgmpr:clmPeriodPerfStartDate>
        <xsl:value-of select="nsmpr0:CLM_PERIOD_PERF_START_DATE"/>
      </nstrgmpr:clmPeriodPerfStartDate>
      <nstrgmpr:revisionNum>
        <xsl:value-of select="nsmpr0:REVISION_NUM"/>
      </nstrgmpr:revisionNum>
      <nstrgmpr:clmDeliveryPeriod>
        <xsl:value-of select="nsmpr0:CLM_DELIVERY_PERIOD"/>
      </nstrgmpr:clmDeliveryPeriod>
      <nstrgmpr:clmDeliveryPeriodUom>
        <xsl:value-of select="nsmpr0:CLM_DELIVERY_PERIOD_UOM"/>
      </nstrgmpr:clmDeliveryPeriodUom>
      <nstrgmpr:clmPopDuration>
        <xsl:value-of select="nsmpr0:CLM_POP_DURATION"/>
      </nstrgmpr:clmPopDuration>
      <nstrgmpr:clmPopDurationUom>
        <xsl:value-of select="nsmpr0:CLM_POP_DURATION_UOM"/>
      </nstrgmpr:clmPopDurationUom>
      <nstrgmpr:clmPromisePeriod>
        <xsl:value-of select="nsmpr0:CLM_PROMISE_PERIOD"/>
      </nstrgmpr:clmPromisePeriod>
      <nstrgmpr:clmPromisePeriodUom>
        <xsl:value-of select="nsmpr0:CLM_PROMISE_PERIOD_UOM"/>
      </nstrgmpr:clmPromisePeriodUom>
      <nstrgmpr:igtScheduleStatus>
        <xsl:value-of select="nsmpr0:IGT_SCHEDULE_STATUS"/>
      </nstrgmpr:igtScheduleStatus>
      <nstrgmpr:advancePaymentIndicator>
        <xsl:value-of select="nsmpr0:ADVANCE_PAYMENT_INDICATOR"/>
      </nstrgmpr:advancePaymentIndicator>
      <nstrgmpr:recreateDemandFlag>
        <xsl:value-of select="nsmpr0:RECREATE_DEMAND_FLAG"/>
      </nstrgmpr:recreateDemandFlag>
      <nstrgmpr:receiveOnlyFlag>
        <xsl:value-of select="nsmpr0:RECEIVE_ONLY_FLAG"/>
      </nstrgmpr:receiveOnlyFlag>
    </nstrgmpr:poLineLocation>
  </xsl:template>

</xsl:stylesheet>
