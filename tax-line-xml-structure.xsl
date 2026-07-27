<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:nstrgmpr="http://xmlns.oracle.com/apps/target" xmlns:nsmpr0="http://xmlns.oracle.com/apps/source">
	<xsl:output indent="yes" method="xml"/>
	<xsl:template match="/">
		<nstrgmpr:taxLine>
			<nstrgmpr:taxLineId>
				<xsl:value-of select="nsmpr0:TAX_LINE_ID"/>
			</nstrgmpr:taxLineId>
			<nstrgmpr:internalOrganizationId>
				<xsl:value-of select="nsmpr0:INTERNAL_ORGANIZATION_ID"/>
			</nstrgmpr:internalOrganizationId>
			<nstrgmpr:applicationId>
				<xsl:value-of select="nsmpr0:APPLICATION_ID"/>
			</nstrgmpr:applicationId>
			<nstrgmpr:entityCode>
				<xsl:value-of select="nsmpr0:ENTITY_CODE"/>
			</nstrgmpr:entityCode>
			<nstrgmpr:eventClassCode>
				<xsl:value-of select="nsmpr0:EVENT_CLASS_CODE"/>
			</nstrgmpr:eventClassCode>
			<nstrgmpr:eventTypeCode>
				<xsl:value-of select="nsmpr0:EVENT_TYPE_CODE"/>
			</nstrgmpr:eventTypeCode>
			<nstrgmpr:trxId>
				<xsl:value-of select="nsmpr0:TRX_ID"/>
			</nstrgmpr:trxId>
			<nstrgmpr:trxLineId>
				<xsl:value-of select="nsmpr0:TRX_LINE_ID"/>
			</nstrgmpr:trxLineId>
			<nstrgmpr:trxLevelType>
				<xsl:value-of select="nsmpr0:TRX_LEVEL_TYPE"/>
			</nstrgmpr:trxLevelType>
			<nstrgmpr:trxLineNumber>
				<xsl:value-of select="nsmpr0:TRX_LINE_NUMBER"/>
			</nstrgmpr:trxLineNumber>
			<nstrgmpr:docEventStatus>
				<xsl:value-of select="nsmpr0:DOC_EVENT_STATUS"/>
			</nstrgmpr:docEventStatus>
			<nstrgmpr:taxEventClassCode>
				<xsl:value-of select="nsmpr0:TAX_EVENT_CLASS_CODE"/>
			</nstrgmpr:taxEventClassCode>
			<nstrgmpr:taxEventTypeCode>
				<xsl:value-of select="nsmpr0:TAX_EVENT_TYPE_CODE"/>
			</nstrgmpr:taxEventTypeCode>
			<nstrgmpr:taxLineNumber>
				<xsl:value-of select="nsmpr0:TAX_LINE_NUMBER"/>
			</nstrgmpr:taxLineNumber>
			<nstrgmpr:contentOwnerId>
				<xsl:value-of select="nsmpr0:CONTENT_OWNER_ID"/>
			</nstrgmpr:contentOwnerId>
			<nstrgmpr:taxRegimeId>
				<xsl:value-of select="nsmpr0:TAX_REGIME_ID"/>
			</nstrgmpr:taxRegimeId>
			<nstrgmpr:taxRegimeCode>
				<xsl:value-of select="nsmpr0:TAX_REGIME_CODE"/>
			</nstrgmpr:taxRegimeCode>
			<nstrgmpr:taxId>
				<xsl:value-of select="nsmpr0:TAX_ID"/>
			</nstrgmpr:taxId>
			<nstrgmpr:tax>
				<xsl:value-of select="nsmpr0:TAX"/>
			</nstrgmpr:tax>
			<nstrgmpr:taxStatusId>
				<xsl:value-of select="nsmpr0:TAX_STATUS_ID"/>
			</nstrgmpr:taxStatusId>
			<nstrgmpr:taxStatusCode>
				<xsl:value-of select="nsmpr0:TAX_STATUS_CODE"/>
			</nstrgmpr:taxStatusCode>
			<nstrgmpr:taxRateId>
				<xsl:value-of select="nsmpr0:TAX_RATE_ID"/>
			</nstrgmpr:taxRateId>
			<nstrgmpr:taxRateCode>
				<xsl:value-of select="nsmpr0:TAX_RATE_CODE"/>
			</nstrgmpr:taxRateCode>
			<nstrgmpr:taxRate>
				<xsl:value-of select="nsmpr0:TAX_RATE"/>
			</nstrgmpr:taxRate>
			<nstrgmpr:taxApportionmentLineNumber>
				<xsl:value-of select="nsmpr0:TAX_APPORTIONMENT_LINE_NUMBER"/>
			</nstrgmpr:taxApportionmentLineNumber>
			<nstrgmpr:trxIdLevel2>
				<xsl:value-of select="nsmpr0:TRX_ID_LEVEL2"/>
			</nstrgmpr:trxIdLevel2>
			<nstrgmpr:trxIdLevel3>
				<xsl:value-of select="nsmpr0:TRX_ID_LEVEL3"/>
			</nstrgmpr:trxIdLevel3>
			<nstrgmpr:trxIdLevel4>
				<xsl:value-of select="nsmpr0:TRX_ID_LEVEL4"/>
			</nstrgmpr:trxIdLevel4>
			<nstrgmpr:trxIdLevel5>
				<xsl:value-of select="nsmpr0:TRX_ID_LEVEL5"/>
			</nstrgmpr:trxIdLevel5>
			<nstrgmpr:trxIdLevel6>
				<xsl:value-of select="nsmpr0:TRX_ID_LEVEL6"/>
			</nstrgmpr:trxIdLevel6>
			<nstrgmpr:trxUserKeyLevel1>
				<xsl:value-of select="nsmpr0:TRX_USER_KEY_LEVEL1"/>
			</nstrgmpr:trxUserKeyLevel1>
			<nstrgmpr:trxUserKeyLevel2>
				<xsl:value-of select="nsmpr0:TRX_USER_KEY_LEVEL2"/>
			</nstrgmpr:trxUserKeyLevel2>
			<nstrgmpr:trxUserKeyLevel3>
				<xsl:value-of select="nsmpr0:TRX_USER_KEY_LEVEL3"/>
			</nstrgmpr:trxUserKeyLevel3>
			<nstrgmpr:trxUserKeyLevel4>
				<xsl:value-of select="nsmpr0:TRX_USER_KEY_LEVEL4"/>
			</nstrgmpr:trxUserKeyLevel4>
			<nstrgmpr:trxUserKeyLevel5>
				<xsl:value-of select="nsmpr0:TRX_USER_KEY_LEVEL5"/>
			</nstrgmpr:trxUserKeyLevel5>
			<nstrgmpr:trxUserKeyLevel6>
				<xsl:value-of select="nsmpr0:TRX_USER_KEY_LEVEL6"/>
			</nstrgmpr:trxUserKeyLevel6>
			<nstrgmpr:mrcTaxLineFlag>
				<xsl:value-of select="nsmpr0:MRC_TAX_LINE_FLAG"/>
			</nstrgmpr:mrcTaxLineFlag>
			<nstrgmpr:ledgerId>
				<xsl:value-of select="nsmpr0:LEDGER_ID"/>
			</nstrgmpr:ledgerId>
			<nstrgmpr:establishmentId>
				<xsl:value-of select="nsmpr0:ESTABLISHMENT_ID"/>
			</nstrgmpr:establishmentId>
			<nstrgmpr:legalEntityId>
				<xsl:value-of select="nsmpr0:LEGAL_ENTITY_ID"/>
			</nstrgmpr:legalEntityId>
			<nstrgmpr:legalEntityTaxRegNumber>
				<xsl:value-of select="nsmpr0:LEGAL_ENTITY_TAX_REG_NUMBER"/>
			</nstrgmpr:legalEntityTaxRegNumber>
			<nstrgmpr:hqEstbRegNumber>
				<xsl:value-of select="nsmpr0:HQ_ESTB_REG_NUMBER"/>
			</nstrgmpr:hqEstbRegNumber>
			<nstrgmpr:hqEstbPartyTaxProfId>
				<xsl:value-of select="nsmpr0:HQ_ESTB_PARTY_TAX_PROF_ID"/>
			</nstrgmpr:hqEstbPartyTaxProfId>
			<nstrgmpr:currencyConversionDate>
				<xsl:value-of select="nsmpr0:CURRENCY_CONVERSION_DATE"/>
			</nstrgmpr:currencyConversionDate>
			<nstrgmpr:currencyConversionType>
				<xsl:value-of select="nsmpr0:CURRENCY_CONVERSION_TYPE"/>
			</nstrgmpr:currencyConversionType>
			<nstrgmpr:currencyConversionRate>
				<xsl:value-of select="nsmpr0:CURRENCY_CONVERSION_RATE"/>
			</nstrgmpr:currencyConversionRate>
			<nstrgmpr:taxCurrencyConversionDate>
				<xsl:value-of select="nsmpr0:TAX_CURRENCY_CONVERSION_DATE"/>
			</nstrgmpr:taxCurrencyConversionDate>
			<nstrgmpr:taxCurrencyConversionType>
				<xsl:value-of select="nsmpr0:TAX_CURRENCY_CONVERSION_TYPE"/>
			</nstrgmpr:taxCurrencyConversionType>
			<nstrgmpr:taxCurrencyConversionRate>
				<xsl:value-of select="nsmpr0:TAX_CURRENCY_CONVERSION_RATE"/>
			</nstrgmpr:taxCurrencyConversionRate>
			<nstrgmpr:trxCurrencyCode>
				<xsl:value-of select="nsmpr0:TRX_CURRENCY_CODE"/>
			</nstrgmpr:trxCurrencyCode>
			<nstrgmpr:minimumAccountableUnit>
				<xsl:value-of select="nsmpr0:MINIMUM_ACCOUNTABLE_UNIT"/>
			</nstrgmpr:minimumAccountableUnit>
			<nstrgmpr:precision>
				<xsl:value-of select="nsmpr0:PRECISION"/>
			</nstrgmpr:precision>
			<nstrgmpr:trxNumber>
				<xsl:value-of select="nsmpr0:TRX_NUMBER"/>
			</nstrgmpr:trxNumber>
			<nstrgmpr:trxDate>
				<xsl:value-of select="nsmpr0:TRX_DATE"/>
			</nstrgmpr:trxDate>
			<nstrgmpr:unitPrice>
				<xsl:value-of select="nsmpr0:UNIT_PRICE"/>
			</nstrgmpr:unitPrice>
			<nstrgmpr:lineAmt>
				<xsl:value-of select="nsmpr0:LINE_AMT"/>
			</nstrgmpr:lineAmt>
			<nstrgmpr:trxLineQuantity>
				<xsl:value-of select="nsmpr0:TRX_LINE_QUANTITY"/>
			</nstrgmpr:trxLineQuantity>
			<nstrgmpr:taxBaseModifierRate>
				<xsl:value-of select="nsmpr0:TAX_BASE_MODIFIER_RATE"/>
			</nstrgmpr:taxBaseModifierRate>
			<nstrgmpr:refDocApplicationId>
				<xsl:value-of select="nsmpr0:REF_DOC_APPLICATION_ID"/>
			</nstrgmpr:refDocApplicationId>
			<nstrgmpr:refDocEntityCode>
				<xsl:value-of select="nsmpr0:REF_DOC_ENTITY_CODE"/>
			</nstrgmpr:refDocEntityCode>
			<nstrgmpr:refDocEventClassCode>
				<xsl:value-of select="nsmpr0:REF_DOC_EVENT_CLASS_CODE"/>
			</nstrgmpr:refDocEventClassCode>
			<nstrgmpr:refDocTrxId>
				<xsl:value-of select="nsmpr0:REF_DOC_TRX_ID"/>
			</nstrgmpr:refDocTrxId>
			<nstrgmpr:refDocLineId>
				<xsl:value-of select="nsmpr0:REF_DOC_LINE_ID"/>
			</nstrgmpr:refDocLineId>
			<nstrgmpr:refDocLineQuantity>
				<xsl:value-of select="nsmpr0:REF_DOC_LINE_QUANTITY"/>
			</nstrgmpr:refDocLineQuantity>
			<nstrgmpr:otherDocLineAmt>
				<xsl:value-of select="nsmpr0:OTHER_DOC_LINE_AMT"/>
			</nstrgmpr:otherDocLineAmt>
			<nstrgmpr:otherDocLineTaxAmt>
				<xsl:value-of select="nsmpr0:OTHER_DOC_LINE_TAX_AMT"/>
			</nstrgmpr:otherDocLineTaxAmt>
			<nstrgmpr:otherDocLineTaxableAmt>
				<xsl:value-of select="nsmpr0:OTHER_DOC_LINE_TAXABLE_AMT"/>
			</nstrgmpr:otherDocLineTaxableAmt>
			<nstrgmpr:unroundedTaxableAmt>
				<xsl:value-of select="nsmpr0:UNROUNDED_TAXABLE_AMT"/>
			</nstrgmpr:unroundedTaxableAmt>
			<nstrgmpr:unroundedTaxAmt>
				<xsl:value-of select="nsmpr0:UNROUNDED_TAX_AMT"/>
			</nstrgmpr:unroundedTaxAmt>
			<nstrgmpr:relatedDocApplicationId>
				<xsl:value-of select="nsmpr0:RELATED_DOC_APPLICATION_ID"/>
			</nstrgmpr:relatedDocApplicationId>
			<nstrgmpr:relatedDocEntityCode>
				<xsl:value-of select="nsmpr0:RELATED_DOC_ENTITY_CODE"/>
			</nstrgmpr:relatedDocEntityCode>
			<nstrgmpr:relatedDocEventClassCode>
				<xsl:value-of select="nsmpr0:RELATED_DOC_EVENT_CLASS_CODE"/>
			</nstrgmpr:relatedDocEventClassCode>
			<nstrgmpr:relatedDocTrxId>
				<xsl:value-of select="nsmpr0:RELATED_DOC_TRX_ID"/>
			</nstrgmpr:relatedDocTrxId>
			<nstrgmpr:relatedDocNumber>
				<xsl:value-of select="nsmpr0:RELATED_DOC_NUMBER"/>
			</nstrgmpr:relatedDocNumber>
			<nstrgmpr:relatedDocDate>
				<xsl:value-of select="nsmpr0:RELATED_DOC_DATE"/>
			</nstrgmpr:relatedDocDate>
			<nstrgmpr:appliedFromApplicationId>
				<xsl:value-of select="nsmpr0:APPLIED_FROM_APPLICATION_ID"/>
			</nstrgmpr:appliedFromApplicationId>
			<nstrgmpr:appliedFromEventClassCode>
				<xsl:value-of select="nsmpr0:APPLIED_FROM_EVENT_CLASS_CODE"/>
			</nstrgmpr:appliedFromEventClassCode>
			<nstrgmpr:appliedFromEntityCode>
				<xsl:value-of select="nsmpr0:APPLIED_FROM_ENTITY_CODE"/>
			</nstrgmpr:appliedFromEntityCode>
			<nstrgmpr:appliedFromTrxId>
				<xsl:value-of select="nsmpr0:APPLIED_FROM_TRX_ID"/>
			</nstrgmpr:appliedFromTrxId>
			<nstrgmpr:appliedFromLineId>
				<xsl:value-of select="nsmpr0:APPLIED_FROM_LINE_ID"/>
			</nstrgmpr:appliedFromLineId>
			<nstrgmpr:appliedFromTrxNumber>
				<xsl:value-of select="nsmpr0:APPLIED_FROM_TRX_NUMBER"/>
			</nstrgmpr:appliedFromTrxNumber>
			<nstrgmpr:adjustedDocApplicationId>
				<xsl:value-of select="nsmpr0:ADJUSTED_DOC_APPLICATION_ID"/>
			</nstrgmpr:adjustedDocApplicationId>
			<nstrgmpr:adjustedDocEntityCode>
				<xsl:value-of select="nsmpr0:ADJUSTED_DOC_ENTITY_CODE"/>
			</nstrgmpr:adjustedDocEntityCode>
			<nstrgmpr:adjustedDocEventClassCode>
				<xsl:value-of select="nsmpr0:ADJUSTED_DOC_EVENT_CLASS_CODE"/>
			</nstrgmpr:adjustedDocEventClassCode>
			<nstrgmpr:adjustedDocTrxId>
				<xsl:value-of select="nsmpr0:ADJUSTED_DOC_TRX_ID"/>
			</nstrgmpr:adjustedDocTrxId>
			<nstrgmpr:adjustedDocLineId>
				<xsl:value-of select="nsmpr0:ADJUSTED_DOC_LINE_ID"/>
			</nstrgmpr:adjustedDocLineId>
			<nstrgmpr:adjustedDocNumber>
				<xsl:value-of select="nsmpr0:ADJUSTED_DOC_NUMBER"/>
			</nstrgmpr:adjustedDocNumber>
			<nstrgmpr:adjustedDocDate>
				<xsl:value-of select="nsmpr0:ADJUSTED_DOC_DATE"/>
			</nstrgmpr:adjustedDocDate>
			<nstrgmpr:appliedToApplicationId>
				<xsl:value-of select="nsmpr0:APPLIED_TO_APPLICATION_ID"/>
			</nstrgmpr:appliedToApplicationId>
			<nstrgmpr:appliedToEventClassCode>
				<xsl:value-of select="nsmpr0:APPLIED_TO_EVENT_CLASS_CODE"/>
			</nstrgmpr:appliedToEventClassCode>
			<nstrgmpr:appliedToEntityCode>
				<xsl:value-of select="nsmpr0:APPLIED_TO_ENTITY_CODE"/>
			</nstrgmpr:appliedToEntityCode>
			<nstrgmpr:appliedToTrxId>
				<xsl:value-of select="nsmpr0:APPLIED_TO_TRX_ID"/>
			</nstrgmpr:appliedToTrxId>
			<nstrgmpr:appliedToLineId>
				<xsl:value-of select="nsmpr0:APPLIED_TO_LINE_ID"/>
			</nstrgmpr:appliedToLineId>
			<nstrgmpr:summaryTaxLineId>
				<xsl:value-of select="nsmpr0:SUMMARY_TAX_LINE_ID"/>
			</nstrgmpr:summaryTaxLineId>
			<nstrgmpr:offsetLinkToTaxLineId>
				<xsl:value-of select="nsmpr0:OFFSET_LINK_TO_TAX_LINE_ID"/>
			</nstrgmpr:offsetLinkToTaxLineId>
			<nstrgmpr:offsetFlag>
				<xsl:value-of select="nsmpr0:OFFSET_FLAG"/>
			</nstrgmpr:offsetFlag>
			<nstrgmpr:processForRecoveryFlag>
				<xsl:value-of select="nsmpr0:PROCESS_FOR_RECOVERY_FLAG"/>
			</nstrgmpr:processForRecoveryFlag>
			<nstrgmpr:taxJurisdictionId>
				<xsl:value-of select="nsmpr0:TAX_JURISDICTION_ID"/>
			</nstrgmpr:taxJurisdictionId>
			<nstrgmpr:taxJurisdictionCode>
				<xsl:value-of select="nsmpr0:TAX_JURISDICTION_CODE"/>
			</nstrgmpr:taxJurisdictionCode>
			<nstrgmpr:placeOfSupply>
				<xsl:value-of select="nsmpr0:PLACE_OF_SUPPLY"/>
			</nstrgmpr:placeOfSupply>
			<nstrgmpr:placeOfSupplyTypeCode>
				<xsl:value-of select="nsmpr0:PLACE_OF_SUPPLY_TYPE_CODE"/>
			</nstrgmpr:placeOfSupplyTypeCode>
			<nstrgmpr:placeOfSupplyResultId>
				<xsl:value-of select="nsmpr0:PLACE_OF_SUPPLY_RESULT_ID"/>
			</nstrgmpr:placeOfSupplyResultId>
			<nstrgmpr:taxDateRuleId>
				<xsl:value-of select="nsmpr0:TAX_DATE_RULE_ID"/>
			</nstrgmpr:taxDateRuleId>
			<nstrgmpr:taxDate>
				<xsl:value-of select="nsmpr0:TAX_DATE"/>
			</nstrgmpr:taxDate>
			<nstrgmpr:taxDetermineDate>
				<xsl:value-of select="nsmpr0:TAX_DETERMINE_DATE"/>
			</nstrgmpr:taxDetermineDate>
			<nstrgmpr:taxPointDate>
				<xsl:value-of select="nsmpr0:TAX_POINT_DATE"/>
			</nstrgmpr:taxPointDate>
			<nstrgmpr:trxLineDate>
				<xsl:value-of select="nsmpr0:TRX_LINE_DATE"/>
			</nstrgmpr:trxLineDate>
			<nstrgmpr:taxTypeCode>
				<xsl:value-of select="nsmpr0:TAX_TYPE_CODE"/>
			</nstrgmpr:taxTypeCode>
			<nstrgmpr:taxCode>
				<xsl:value-of select="nsmpr0:TAX_CODE"/>
			</nstrgmpr:taxCode>
			<nstrgmpr:taxRegistrationId>
				<xsl:value-of select="nsmpr0:TAX_REGISTRATION_ID"/>
			</nstrgmpr:taxRegistrationId>
			<nstrgmpr:taxRegistrationNumber>
				<xsl:value-of select="nsmpr0:TAX_REGISTRATION_NUMBER"/>
			</nstrgmpr:taxRegistrationNumber>
			<nstrgmpr:registrationPartyType>
				<xsl:value-of select="nsmpr0:REGISTRATION_PARTY_TYPE"/>
			</nstrgmpr:registrationPartyType>
			<nstrgmpr:roundingLevelCode>
				<xsl:value-of select="nsmpr0:ROUNDING_LEVEL_CODE"/>
			</nstrgmpr:roundingLevelCode>
			<nstrgmpr:roundingRuleCode>
				<xsl:value-of select="nsmpr0:ROUNDING_RULE_CODE"/>
			</nstrgmpr:roundingRuleCode>
			<nstrgmpr:roundingLvlPartyTaxProfId>
				<xsl:value-of select="nsmpr0:ROUNDING_LVL_PARTY_TAX_PROF_ID"/>
			</nstrgmpr:roundingLvlPartyTaxProfId>
			<nstrgmpr:roundingLvlPartyType>
				<xsl:value-of select="nsmpr0:ROUNDING_LVL_PARTY_TYPE"/>
			</nstrgmpr:roundingLvlPartyType>
			<nstrgmpr:compoundingTaxFlag>
				<xsl:value-of select="nsmpr0:COMPOUNDING_TAX_FLAG"/>
			</nstrgmpr:compoundingTaxFlag>
			<nstrgmpr:origTaxStatusId>
				<xsl:value-of select="nsmpr0:ORIG_TAX_STATUS_ID"/>
			</nstrgmpr:origTaxStatusId>
			<nstrgmpr:origTaxStatusCode>
				<xsl:value-of select="nsmpr0:ORIG_TAX_STATUS_CODE"/>
			</nstrgmpr:origTaxStatusCode>
			<nstrgmpr:origTaxRateId>
				<xsl:value-of select="nsmpr0:ORIG_TAX_RATE_ID"/>
			</nstrgmpr:origTaxRateId>
			<nstrgmpr:origTaxRateCode>
				<xsl:value-of select="nsmpr0:ORIG_TAX_RATE_CODE"/>
			</nstrgmpr:origTaxRateCode>
			<nstrgmpr:origTaxRate>
				<xsl:value-of select="nsmpr0:ORIG_TAX_RATE"/>
			</nstrgmpr:origTaxRate>
			<nstrgmpr:origTaxJurisdictionId>
				<xsl:value-of select="nsmpr0:ORIG_TAX_JURISDICTION_ID"/>
			</nstrgmpr:origTaxJurisdictionId>
			<nstrgmpr:origTaxJurisdictionCode>
				<xsl:value-of select="nsmpr0:ORIG_TAX_JURISDICTION_CODE"/>
			</nstrgmpr:origTaxJurisdictionCode>
			<nstrgmpr:origTaxAmtIncludedFlag>
				<xsl:value-of select="nsmpr0:ORIG_TAX_AMT_INCLUDED_FLAG"/>
			</nstrgmpr:origTaxAmtIncludedFlag>
			<nstrgmpr:origSelfAssessedFlag>
				<xsl:value-of select="nsmpr0:ORIG_SELF_ASSESSED_FLAG"/>
			</nstrgmpr:origSelfAssessedFlag>
			<nstrgmpr:taxCurrencyCode>
				<xsl:value-of select="nsmpr0:TAX_CURRENCY_CODE"/>
			</nstrgmpr:taxCurrencyCode>
			<nstrgmpr:taxAmt>
				<xsl:value-of select="nsmpr0:TAX_AMT"/>
			</nstrgmpr:taxAmt>
			<nstrgmpr:taxAmtTaxCurr>
				<xsl:value-of select="nsmpr0:TAX_AMT_TAX_CURR"/>
			</nstrgmpr:taxAmtTaxCurr>
			<nstrgmpr:taxAmtFunclCurr>
				<xsl:value-of select="nsmpr0:TAX_AMT_FUNCL_CURR"/>
			</nstrgmpr:taxAmtFunclCurr>
			<nstrgmpr:taxableAmt>
				<xsl:value-of select="nsmpr0:TAXABLE_AMT"/>
			</nstrgmpr:taxableAmt>
			<nstrgmpr:taxableAmtTaxCurr>
				<xsl:value-of select="nsmpr0:TAXABLE_AMT_TAX_CURR"/>
			</nstrgmpr:taxableAmtTaxCurr>
			<nstrgmpr:taxableAmtFunclCurr>
				<xsl:value-of select="nsmpr0:TAXABLE_AMT_FUNCL_CURR"/>
			</nstrgmpr:taxableAmtFunclCurr>
			<nstrgmpr:origTaxableAmt>
				<xsl:value-of select="nsmpr0:ORIG_TAXABLE_AMT"/>
			</nstrgmpr:origTaxableAmt>
			<nstrgmpr:origTaxableAmtTaxCurr>
				<xsl:value-of select="nsmpr0:ORIG_TAXABLE_AMT_TAX_CURR"/>
			</nstrgmpr:origTaxableAmtTaxCurr>
			<nstrgmpr:calTaxAmt>
				<xsl:value-of select="nsmpr0:CAL_TAX_AMT"/>
			</nstrgmpr:calTaxAmt>
			<nstrgmpr:calTaxAmtTaxCurr>
				<xsl:value-of select="nsmpr0:CAL_TAX_AMT_TAX_CURR"/>
			</nstrgmpr:calTaxAmtTaxCurr>
			<nstrgmpr:calTaxAmtFunclCurr>
				<xsl:value-of select="nsmpr0:CAL_TAX_AMT_FUNCL_CURR"/>
			</nstrgmpr:calTaxAmtFunclCurr>
			<nstrgmpr:origTaxAmt>
				<xsl:value-of select="nsmpr0:ORIG_TAX_AMT"/>
			</nstrgmpr:origTaxAmt>
			<nstrgmpr:origTaxAmtTaxCurr>
				<xsl:value-of select="nsmpr0:ORIG_TAX_AMT_TAX_CURR"/>
			</nstrgmpr:origTaxAmtTaxCurr>
			<nstrgmpr:recTaxAmt>
				<xsl:value-of select="nsmpr0:REC_TAX_AMT"/>
			</nstrgmpr:recTaxAmt>
			<nstrgmpr:recTaxAmtTaxCurr>
				<xsl:value-of select="nsmpr0:REC_TAX_AMT_TAX_CURR"/>
			</nstrgmpr:recTaxAmtTaxCurr>
			<nstrgmpr:recTaxAmtFunclCurr>
				<xsl:value-of select="nsmpr0:REC_TAX_AMT_FUNCL_CURR"/>
			</nstrgmpr:recTaxAmtFunclCurr>
			<nstrgmpr:nrecTaxAmt>
				<xsl:value-of select="nsmpr0:NREC_TAX_AMT"/>
			</nstrgmpr:nrecTaxAmt>
			<nstrgmpr:nrecTaxAmtTaxCurr>
				<xsl:value-of select="nsmpr0:NREC_TAX_AMT_TAX_CURR"/>
			</nstrgmpr:nrecTaxAmtTaxCurr>
			<nstrgmpr:nrecTaxAmtFunclCurr>
				<xsl:value-of select="nsmpr0:NREC_TAX_AMT_FUNCL_CURR"/>
			</nstrgmpr:nrecTaxAmtFunclCurr>
			<nstrgmpr:taxExemptionId>
				<xsl:value-of select="nsmpr0:TAX_EXEMPTION_ID"/>
			</nstrgmpr:taxExemptionId>
			<nstrgmpr:taxRateBeforeExemption>
				<xsl:value-of select="nsmpr0:TAX_RATE_BEFORE_EXEMPTION"/>
			</nstrgmpr:taxRateBeforeExemption>
			<nstrgmpr:taxRateNameBeforeExemption>
				<xsl:value-of select="nsmpr0:TAX_RATE_NAME_BEFORE_EXEMPTION"/>
			</nstrgmpr:taxRateNameBeforeExemption>
			<nstrgmpr:exemptRateModifier>
				<xsl:value-of select="nsmpr0:EXEMPT_RATE_MODIFIER"/>
			</nstrgmpr:exemptRateModifier>
			<nstrgmpr:exemptCertificateNumber>
				<xsl:value-of select="nsmpr0:EXEMPT_CERTIFICATE_NUMBER"/>
			</nstrgmpr:exemptCertificateNumber>
			<nstrgmpr:exemptReason>
				<xsl:value-of select="nsmpr0:EXEMPT_REASON"/>
			</nstrgmpr:exemptReason>
			<nstrgmpr:exemptReasonCode>
				<xsl:value-of select="nsmpr0:EXEMPT_REASON_CODE"/>
			</nstrgmpr:exemptReasonCode>
			<nstrgmpr:taxExceptionId>
				<xsl:value-of select="nsmpr0:TAX_EXCEPTION_ID"/>
			</nstrgmpr:taxExceptionId>
			<nstrgmpr:taxRateBeforeException>
				<xsl:value-of select="nsmpr0:TAX_RATE_BEFORE_EXCEPTION"/>
			</nstrgmpr:taxRateBeforeException>
			<nstrgmpr:taxRateNameBeforeException>
				<xsl:value-of select="nsmpr0:TAX_RATE_NAME_BEFORE_EXCEPTION"/>
			</nstrgmpr:taxRateNameBeforeException>
			<nstrgmpr:exceptionRate>
				<xsl:value-of select="nsmpr0:EXCEPTION_RATE"/>
			</nstrgmpr:exceptionRate>
			<nstrgmpr:taxApportionmentFlag>
				<xsl:value-of select="nsmpr0:TAX_APPORTIONMENT_FLAG"/>
			</nstrgmpr:taxApportionmentFlag>
			<nstrgmpr:historicalFlag>
				<xsl:value-of select="nsmpr0:HISTORICAL_FLAG"/>
			</nstrgmpr:historicalFlag>
			<nstrgmpr:taxableBasisFormula>
				<xsl:value-of select="nsmpr0:TAXABLE_BASIS_FORMULA"/>
			</nstrgmpr:taxableBasisFormula>
			<nstrgmpr:taxCalculationFormula>
				<xsl:value-of select="nsmpr0:TAX_CALCULATION_FORMULA"/>
			</nstrgmpr:taxCalculationFormula>
			<nstrgmpr:cancelFlag>
				<xsl:value-of select="nsmpr0:CANCEL_FLAG"/>
			</nstrgmpr:cancelFlag>
			<nstrgmpr:purgeFlag>
				<xsl:value-of select="nsmpr0:PURGE_FLAG"/>
			</nstrgmpr:purgeFlag>
			<nstrgmpr:deleteFlag>
				<xsl:value-of select="nsmpr0:DELETE_FLAG"/>
			</nstrgmpr:deleteFlag>
			<nstrgmpr:taxAmtIncludedFlag>
				<xsl:value-of select="nsmpr0:TAX_AMT_INCLUDED_FLAG"/>
			</nstrgmpr:taxAmtIncludedFlag>
			<nstrgmpr:selfAssessedFlag>
				<xsl:value-of select="nsmpr0:SELF_ASSESSED_FLAG"/>
			</nstrgmpr:selfAssessedFlag>
			<nstrgmpr:overriddenFlag>
				<xsl:value-of select="nsmpr0:OVERRIDDEN_FLAG"/>
			</nstrgmpr:overriddenFlag>
			<nstrgmpr:manuallyEnteredFlag>
				<xsl:value-of select="nsmpr0:MANUALLY_ENTERED_FLAG"/>
			</nstrgmpr:manuallyEnteredFlag>
			<nstrgmpr:reportingOnlyFlag>
				<xsl:value-of select="nsmpr0:REPORTING_ONLY_FLAG"/>
			</nstrgmpr:reportingOnlyFlag>
			<nstrgmpr:freezeUntilOverriddenFlag>
				<xsl:value-of select="nsmpr0:FREEZE_UNTIL_OVERRIDDEN_FLAG"/>
			</nstrgmpr:freezeUntilOverriddenFlag>
			<nstrgmpr:copiedFromOtherDocFlag>
				<xsl:value-of select="nsmpr0:COPIED_FROM_OTHER_DOC_FLAG"/>
			</nstrgmpr:copiedFromOtherDocFlag>
			<nstrgmpr:recalcRequiredFlag>
				<xsl:value-of select="nsmpr0:RECALC_REQUIRED_FLAG"/>
			</nstrgmpr:recalcRequiredFlag>
			<nstrgmpr:settlementFlag>
				<xsl:value-of select="nsmpr0:SETTLEMENT_FLAG"/>
			</nstrgmpr:settlementFlag>
			<nstrgmpr:itemDistChangedFlag>
				<xsl:value-of select="nsmpr0:ITEM_DIST_CHANGED_FLAG"/>
			</nstrgmpr:itemDistChangedFlag>
			<nstrgmpr:associatedChildFrozenFlag>
				<xsl:value-of select="nsmpr0:ASSOCIATED_CHILD_FROZEN_FLAG"/>
			</nstrgmpr:associatedChildFrozenFlag>
			<nstrgmpr:taxOnlyLineFlag>
				<xsl:value-of select="nsmpr0:TAX_ONLY_LINE_FLAG"/>
			</nstrgmpr:taxOnlyLineFlag>
			<nstrgmpr:compoundingDepTaxFlag>
				<xsl:value-of select="nsmpr0:COMPOUNDING_DEP_TAX_FLAG"/>
			</nstrgmpr:compoundingDepTaxFlag>
			<nstrgmpr:lastManualEntry>
				<xsl:value-of select="nsmpr0:LAST_MANUAL_ENTRY"/>
			</nstrgmpr:lastManualEntry>
			<nstrgmpr:taxProviderId>
				<xsl:value-of select="nsmpr0:TAX_PROVIDER_ID"/>
			</nstrgmpr:taxProviderId>
			<nstrgmpr:recordTypeCode>
				<xsl:value-of select="nsmpr0:RECORD_TYPE_CODE"/>
			</nstrgmpr:recordTypeCode>
			<nstrgmpr:reportingPeriodId>
				<xsl:value-of select="nsmpr0:REPORTING_PERIOD_ID"/>
			</nstrgmpr:reportingPeriodId>
			<nstrgmpr:legalMessageAppl2>
				<xsl:value-of select="nsmpr0:LEGAL_MESSAGE_APPL_2"/>
			</nstrgmpr:legalMessageAppl2>
			<nstrgmpr:legalMessageStatus>
				<xsl:value-of select="nsmpr0:LEGAL_MESSAGE_STATUS"/>
			</nstrgmpr:legalMessageStatus>
			<nstrgmpr:legalMessageRate>
				<xsl:value-of select="nsmpr0:LEGAL_MESSAGE_RATE"/>
			</nstrgmpr:legalMessageRate>
			<nstrgmpr:legalMessageBasis>
				<xsl:value-of select="nsmpr0:LEGAL_MESSAGE_BASIS"/>
			</nstrgmpr:legalMessageBasis>
			<nstrgmpr:legalMessageCalc>
				<xsl:value-of select="nsmpr0:LEGAL_MESSAGE_CALC"/>
			</nstrgmpr:legalMessageCalc>
			<nstrgmpr:legalMessageThreshold>
				<xsl:value-of select="nsmpr0:LEGAL_MESSAGE_THRESHOLD"/>
			</nstrgmpr:legalMessageThreshold>
			<nstrgmpr:legalMessagePos>
				<xsl:value-of select="nsmpr0:LEGAL_MESSAGE_POS"/>
			</nstrgmpr:legalMessagePos>
			<nstrgmpr:legalMessageTrn>
				<xsl:value-of select="nsmpr0:LEGAL_MESSAGE_TRN"/>
			</nstrgmpr:legalMessageTrn>
			<nstrgmpr:legalMessageExmpt>
				<xsl:value-of select="nsmpr0:LEGAL_MESSAGE_EXMPT"/>
			</nstrgmpr:legalMessageExmpt>
			<nstrgmpr:legalMessageExcpt>
				<xsl:value-of select="nsmpr0:LEGAL_MESSAGE_EXCPT"/>
			</nstrgmpr:legalMessageExcpt>
			<nstrgmpr:taxRegimeTemplateId>
				<xsl:value-of select="nsmpr0:TAX_REGIME_TEMPLATE_ID"/>
			</nstrgmpr:taxRegimeTemplateId>
			<nstrgmpr:taxApplicabilityResultId>
				<xsl:value-of select="nsmpr0:TAX_APPLICABILITY_RESULT_ID"/>
			</nstrgmpr:taxApplicabilityResultId>
			<nstrgmpr:directRateResultId>
				<xsl:value-of select="nsmpr0:DIRECT_RATE_RESULT_ID"/>
			</nstrgmpr:directRateResultId>
			<nstrgmpr:statusResultId>
				<xsl:value-of select="nsmpr0:STATUS_RESULT_ID"/>
			</nstrgmpr:statusResultId>
			<nstrgmpr:rateResultId>
				<xsl:value-of select="nsmpr0:RATE_RESULT_ID"/>
			</nstrgmpr:rateResultId>
			<nstrgmpr:basisResultId>
				<xsl:value-of select="nsmpr0:BASIS_RESULT_ID"/>
			</nstrgmpr:basisResultId>
			<nstrgmpr:threshResultId>
				<xsl:value-of select="nsmpr0:THRESH_RESULT_ID"/>
			</nstrgmpr:threshResultId>
			<nstrgmpr:calcResultId>
				<xsl:value-of select="nsmpr0:CALC_RESULT_ID"/>
			</nstrgmpr:calcResultId>
			<nstrgmpr:taxRegNumDetResultId>
				<xsl:value-of select="nsmpr0:TAX_REG_NUM_DET_RESULT_ID"/>
			</nstrgmpr:taxRegNumDetResultId>
			<nstrgmpr:evalExmptResultId>
				<xsl:value-of select="nsmpr0:EVAL_EXMPT_RESULT_ID"/>
			</nstrgmpr:evalExmptResultId>
			<nstrgmpr:evalExcptResultId>
				<xsl:value-of select="nsmpr0:EVAL_EXCPT_RESULT_ID"/>
			</nstrgmpr:evalExcptResultId>
			<nstrgmpr:enforceFromNaturalAcctFlag>
				<xsl:value-of select="nsmpr0:ENFORCE_FROM_NATURAL_ACCT_FLAG"/>
			</nstrgmpr:enforceFromNaturalAcctFlag>
			<nstrgmpr:taxHoldCode>
				<xsl:value-of select="nsmpr0:TAX_HOLD_CODE"/>
			</nstrgmpr:taxHoldCode>
			<nstrgmpr:taxHoldReleasedCode>
				<xsl:value-of select="nsmpr0:TAX_HOLD_RELEASED_CODE"/>
			</nstrgmpr:taxHoldReleasedCode>
			<nstrgmpr:prdTotalTaxAmt>
				<xsl:value-of select="nsmpr0:PRD_TOTAL_TAX_AMT"/>
			</nstrgmpr:prdTotalTaxAmt>
			<nstrgmpr:prdTotalTaxAmtTaxCurr>
				<xsl:value-of select="nsmpr0:PRD_TOTAL_TAX_AMT_TAX_CURR"/>
			</nstrgmpr:prdTotalTaxAmtTaxCurr>
			<nstrgmpr:prdTotalTaxAmtFunclCurr>
				<xsl:value-of select="nsmpr0:PRD_TOTAL_TAX_AMT_FUNCL_CURR"/>
			</nstrgmpr:prdTotalTaxAmtFunclCurr>
			<nstrgmpr:internalOrgLocationId>
				<xsl:value-of select="nsmpr0:INTERNAL_ORG_LOCATION_ID"/>
			</nstrgmpr:internalOrgLocationId>
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
			<nstrgmpr:numeric1>
				<xsl:value-of select="nsmpr0:NUMERIC1"/>
			</nstrgmpr:numeric1>
			<nstrgmpr:numeric2>
				<xsl:value-of select="nsmpr0:NUMERIC2"/>
			</nstrgmpr:numeric2>
			<nstrgmpr:numeric3>
				<xsl:value-of select="nsmpr0:NUMERIC3"/>
			</nstrgmpr:numeric3>
			<nstrgmpr:numeric4>
				<xsl:value-of select="nsmpr0:NUMERIC4"/>
			</nstrgmpr:numeric4>
			<nstrgmpr:numeric5>
				<xsl:value-of select="nsmpr0:NUMERIC5"/>
			</nstrgmpr:numeric5>
			<nstrgmpr:numeric6>
				<xsl:value-of select="nsmpr0:NUMERIC6"/>
			</nstrgmpr:numeric6>
			<nstrgmpr:numeric7>
				<xsl:value-of select="nsmpr0:NUMERIC7"/>
			</nstrgmpr:numeric7>
			<nstrgmpr:numeric8>
				<xsl:value-of select="nsmpr0:NUMERIC8"/>
			</nstrgmpr:numeric8>
			<nstrgmpr:numeric9>
				<xsl:value-of select="nsmpr0:NUMERIC9"/>
			</nstrgmpr:numeric9>
			<nstrgmpr:numeric10>
				<xsl:value-of select="nsmpr0:NUMERIC10"/>
			</nstrgmpr:numeric10>
			<nstrgmpr:char1>
				<xsl:value-of select="nsmpr0:CHAR1"/>
			</nstrgmpr:char1>
			<nstrgmpr:char2>
				<xsl:value-of select="nsmpr0:CHAR2"/>
			</nstrgmpr:char2>
			<nstrgmpr:char3>
				<xsl:value-of select="nsmpr0:CHAR3"/>
			</nstrgmpr:char3>
			<nstrgmpr:char4>
				<xsl:value-of select="nsmpr0:CHAR4"/>
			</nstrgmpr:char4>
			<nstrgmpr:char5>
				<xsl:value-of select="nsmpr0:CHAR5"/>
			</nstrgmpr:char5>
			<nstrgmpr:char6>
				<xsl:value-of select="nsmpr0:CHAR6"/>
			</nstrgmpr:char6>
			<nstrgmpr:char7>
				<xsl:value-of select="nsmpr0:CHAR7"/>
			</nstrgmpr:char7>
			<nstrgmpr:char8>
				<xsl:value-of select="nsmpr0:CHAR8"/>
			</nstrgmpr:char8>
			<nstrgmpr:char9>
				<xsl:value-of select="nsmpr0:CHAR9"/>
			</nstrgmpr:char9>
			<nstrgmpr:char10>
				<xsl:value-of select="nsmpr0:CHAR10"/>
			</nstrgmpr:char10>
			<nstrgmpr:date1>
				<xsl:value-of select="nsmpr0:DATE1"/>
			</nstrgmpr:date1>
			<nstrgmpr:date2>
				<xsl:value-of select="nsmpr0:DATE2"/>
			</nstrgmpr:date2>
			<nstrgmpr:date3>
				<xsl:value-of select="nsmpr0:DATE3"/>
			</nstrgmpr:date3>
			<nstrgmpr:date4>
				<xsl:value-of select="nsmpr0:DATE4"/>
			</nstrgmpr:date4>
			<nstrgmpr:date5>
				<xsl:value-of select="nsmpr0:DATE5"/>
			</nstrgmpr:date5>
			<nstrgmpr:date6>
				<xsl:value-of select="nsmpr0:DATE6"/>
			</nstrgmpr:date6>
			<nstrgmpr:date7>
				<xsl:value-of select="nsmpr0:DATE7"/>
			</nstrgmpr:date7>
			<nstrgmpr:date8>
				<xsl:value-of select="nsmpr0:DATE8"/>
			</nstrgmpr:date8>
			<nstrgmpr:date9>
				<xsl:value-of select="nsmpr0:DATE9"/>
			</nstrgmpr:date9>
			<nstrgmpr:date10>
				<xsl:value-of select="nsmpr0:DATE10"/>
			</nstrgmpr:date10>
			<nstrgmpr:createdBy>
				<xsl:value-of select="nsmpr0:CREATED_BY"/>
			</nstrgmpr:createdBy>
			<nstrgmpr:creationDate>
				<xsl:value-of select="nsmpr0:CREATION_DATE"/>
			</nstrgmpr:creationDate>
			<nstrgmpr:lastUpdatedBy>
				<xsl:value-of select="nsmpr0:LAST_UPDATED_BY"/>
			</nstrgmpr:lastUpdatedBy>
			<nstrgmpr:lastUpdateDate>
				<xsl:value-of select="nsmpr0:LAST_UPDATE_DATE"/>
			</nstrgmpr:lastUpdateDate>
			<nstrgmpr:lastUpdateLogin>
				<xsl:value-of select="nsmpr0:LAST_UPDATE_LOGIN"/>
			</nstrgmpr:lastUpdateLogin>
			<nstrgmpr:legalJustificationText1>
				<xsl:value-of select="nsmpr0:LEGAL_JUSTIFICATION_TEXT1"/>
			</nstrgmpr:legalJustificationText1>
			<nstrgmpr:legalJustificationText2>
				<xsl:value-of select="nsmpr0:LEGAL_JUSTIFICATION_TEXT2"/>
			</nstrgmpr:legalJustificationText2>
			<nstrgmpr:legalJustificationText3>
				<xsl:value-of select="nsmpr0:LEGAL_JUSTIFICATION_TEXT3"/>
			</nstrgmpr:legalJustificationText3>
			<nstrgmpr:reportingCurrencyCode>
				<xsl:value-of select="nsmpr0:REPORTING_CURRENCY_CODE"/>
			</nstrgmpr:reportingCurrencyCode>
			<nstrgmpr:lineAssessableValue>
				<xsl:value-of select="nsmpr0:LINE_ASSESSABLE_VALUE"/>
			</nstrgmpr:lineAssessableValue>
			<nstrgmpr:trxLineIndex>
				<xsl:value-of select="nsmpr0:TRX_LINE_INDEX"/>
			</nstrgmpr:trxLineIndex>
			<nstrgmpr:offsetTaxRateCode>
				<xsl:value-of select="nsmpr0:OFFSET_TAX_RATE_CODE"/>
			</nstrgmpr:offsetTaxRateCode>
			<nstrgmpr:prorationCode>
				<xsl:value-of select="nsmpr0:PRORATION_CODE"/>
			</nstrgmpr:prorationCode>
			<nstrgmpr:otherDocSource>
				<xsl:value-of select="nsmpr0:OTHER_DOC_SOURCE"/>
			</nstrgmpr:otherDocSource>
			<nstrgmpr:ctrlTotalLineTxAmt>
				<xsl:value-of select="nsmpr0:CTRL_TOTAL_LINE_TX_AMT"/>
			</nstrgmpr:ctrlTotalLineTxAmt>
			<nstrgmpr:taxRateType>
				<xsl:value-of select="nsmpr0:TAX_RATE_TYPE"/>
			</nstrgmpr:taxRateType>
			<nstrgmpr:compoundingTaxMissFlag>
				<xsl:value-of select="nsmpr0:COMPOUNDING_TAX_MISS_FLAG"/>
			</nstrgmpr:compoundingTaxMissFlag>
			<nstrgmpr:mrcLinkToTaxLineId>
				<xsl:value-of select="nsmpr0:MRC_LINK_TO_TAX_LINE_ID"/>
			</nstrgmpr:mrcLinkToTaxLineId>
			<nstrgmpr:refDocTrxLevelType>
				<xsl:value-of select="nsmpr0:REF_DOC_TRX_LEVEL_TYPE"/>
			</nstrgmpr:refDocTrxLevelType>
			<nstrgmpr:relatedDocTrxLevelType>
				<xsl:value-of select="nsmpr0:RELATED_DOC_TRX_LEVEL_TYPE"/>
			</nstrgmpr:relatedDocTrxLevelType>
			<nstrgmpr:appliedFromTrxLevelType>
				<xsl:value-of select="nsmpr0:APPLIED_FROM_TRX_LEVEL_TYPE"/>
			</nstrgmpr:appliedFromTrxLevelType>
			<nstrgmpr:adjustedDocTrxLevelType>
				<xsl:value-of select="nsmpr0:ADJUSTED_DOC_TRX_LEVEL_TYPE"/>
			</nstrgmpr:adjustedDocTrxLevelType>
			<nstrgmpr:appliedToTrxLevelType>
				<xsl:value-of select="nsmpr0:APPLIED_TO_TRX_LEVEL_TYPE"/>
			</nstrgmpr:appliedToTrxLevelType>
			<nstrgmpr:syncWithPrvdrFlag>
				<xsl:value-of select="nsmpr0:SYNC_WITH_PRVDR_FLAG"/>
			</nstrgmpr:syncWithPrvdrFlag>
			<nstrgmpr:appliedToTrxNumber>
				<xsl:value-of select="nsmpr0:APPLIED_TO_TRX_NUMBER"/>
			</nstrgmpr:appliedToTrxNumber>
			<nstrgmpr:interfaceEntityCode>
				<xsl:value-of select="nsmpr0:INTERFACE_ENTITY_CODE"/>
			</nstrgmpr:interfaceEntityCode>
			<nstrgmpr:interfaceTaxLineId>
				<xsl:value-of select="nsmpr0:INTERFACE_TAX_LINE_ID"/>
			</nstrgmpr:interfaceTaxLineId>
			<nstrgmpr:taxingJurisGeographyId>
				<xsl:value-of select="nsmpr0:TAXING_JURIS_GEOGRAPHY_ID"/>
			</nstrgmpr:taxingJurisGeographyId>
			<nstrgmpr:adjustedDocTaxLineId>
				<xsl:value-of select="nsmpr0:ADJUSTED_DOC_TAX_LINE_ID"/>
			</nstrgmpr:adjustedDocTaxLineId>
			<nstrgmpr:objectVersionNumber>
				<xsl:value-of select="nsmpr0:OBJECT_VERSION_NUMBER"/>
			</nstrgmpr:objectVersionNumber>
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
			<nstrgmpr:reversedTaxLineId>
				<xsl:value-of select="nsmpr0:REVERSED_TAX_LINE_ID"/>
			</nstrgmpr:reversedTaxLineId>
			<nstrgmpr:multipleJurisdictionsFlag>
				<xsl:value-of select="nsmpr0:MULTIPLE_JURISDICTIONS_FLAG"/>
			</nstrgmpr:multipleJurisdictionsFlag>
			<nstrgmpr:legalReportingStatus>
				<xsl:value-of select="nsmpr0:LEGAL_REPORTING_STATUS"/>
			</nstrgmpr:legalReportingStatus>
			<nstrgmpr:accountSourceTaxRateId>
				<xsl:value-of select="nsmpr0:ACCOUNT_SOURCE_TAX_RATE_ID"/>
			</nstrgmpr:accountSourceTaxRateId>
			<nstrgmpr:prvdrRecRateCode>
				<xsl:value-of select="nsmpr0:PRVDR_REC_RATE_CODE"/>
			</nstrgmpr:prvdrRecRateCode>
			<nstrgmpr:prvdrRecRate>
				<xsl:value-of select="nsmpr0:PRVDR_REC_RATE"/>
			</nstrgmpr:prvdrRecRate>
		</nstrgmpr:taxLine>
	</xsl:template>
</xsl:stylesheet>
