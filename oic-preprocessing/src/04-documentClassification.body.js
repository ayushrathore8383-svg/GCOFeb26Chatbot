/**
 * VALIDATION 4 - Document classification (invoice family or not).
 *
 * OIC call signature:
 *   classifyDocument(base64Content, textOverride, invoiceFamilyStr)
 *
 * invoiceFamilyStr - optional comma-separated list of document types that should
 *                    proceed into the extraction pipeline.
 *                    Default: "INVOICE,CREDIT_NOTE".
 *                    Set to "INVOICE" alone if credit notes must be excluded, or
 *                    "INVOICE,CREDIT_NOTE,PROFORMA" to include pro formas.
 *
 * Possible documentType values:
 *   INVOICE, CREDIT_NOTE, PROFORMA, STATEMENT, PURCHASE_ORDER, DELIVERY_NOTE,
 *   REMITTANCE_ADVICE, QUOTATION, REMINDER, UNKNOWN
 *
 * Exclude from the APEX processing queue when passed === false and
 * status === "NOT_INVOICE".
 *
 * status === "UNCLASSIFIED" means there was no text to classify on (scanned PDF).
 * That returns passed = true on purpose so the document still reaches Document
 * Understanding, which can classify it properly from the image.
 */

var DC_SIGNALS = [
    { type: 'CREDIT_NOTE', term: 'creditnote', weight: 6 },
    { type: 'CREDIT_NOTE', term: 'creditmemo', weight: 6 },
    { type: 'CREDIT_NOTE', term: 'creditnoteno', weight: 3 },

    { type: 'INVOICE', term: 'taxinvoice', weight: 5 },
    { type: 'INVOICE', term: 'vatinvoice', weight: 5 },
    { type: 'INVOICE', term: 'invoiceno', weight: 4 },
    { type: 'INVOICE', term: 'invoicenumber', weight: 4 },
    { type: 'INVOICE', term: 'invoicedate', weight: 4 },
    { type: 'INVOICE', term: 'invoice', weight: 3 },
    { type: 'INVOICE', term: 'amountdue', weight: 2 },
    { type: 'INVOICE', term: 'billto', weight: 2 },
    { type: 'INVOICE', term: 'remitto', weight: 2 },
    { type: 'INVOICE', term: 'subtotal', weight: 2 },
    { type: 'INVOICE', term: 'paymentterms', weight: 2 },
    { type: 'INVOICE', term: 'vatregistration', weight: 2 },
    { type: 'INVOICE', term: 'vatreg', weight: 1 },
    { type: 'INVOICE', term: 'duedate', weight: 1 },

    { type: 'PROFORMA', term: 'proforma', weight: 6 },
    { type: 'PROFORMA', term: 'proformainvoice', weight: 3 },

    { type: 'STATEMENT', term: 'statementofaccount', weight: 7 },
    { type: 'STATEMENT', term: 'accountstatement', weight: 6 },
    { type: 'STATEMENT', term: 'statementdate', weight: 4 },
    { type: 'STATEMENT', term: 'openingbalance', weight: 3 },
    { type: 'STATEMENT', term: 'broughtforward', weight: 3 },
    { type: 'STATEMENT', term: 'agedanalysis', weight: 3 },
    { type: 'STATEMENT', term: 'currentbalance', weight: 2 },

    { type: 'PURCHASE_ORDER', term: 'purchaseorderno', weight: 4 },
    { type: 'PURCHASE_ORDER', term: 'purchaseorder', weight: 3 },
    { type: 'PURCHASE_ORDER', term: 'orderconfirmation', weight: 4 },
    { type: 'PURCHASE_ORDER', term: 'deliverto', weight: 2 },

    { type: 'DELIVERY_NOTE', term: 'deliverynote', weight: 7 },
    { type: 'DELIVERY_NOTE', term: 'despatchnote', weight: 7 },
    { type: 'DELIVERY_NOTE', term: 'dispatchnote', weight: 7 },
    { type: 'DELIVERY_NOTE', term: 'packingslip', weight: 7 },
    { type: 'DELIVERY_NOTE', term: 'packinglist', weight: 6 },
    { type: 'DELIVERY_NOTE', term: 'goodsreceivednote', weight: 6 },

    { type: 'REMITTANCE_ADVICE', term: 'remittanceadvice', weight: 7 },
    { type: 'REMITTANCE_ADVICE', term: 'paymentadvice', weight: 5 },

    { type: 'QUOTATION', term: 'quotation', weight: 6 },
    { type: 'QUOTATION', term: 'quotationno', weight: 3 },
    { type: 'QUOTATION', term: 'estimateno', weight: 4 },

    { type: 'REMINDER', term: 'overduereminder', weight: 6 },
    { type: 'REMINDER', term: 'paymentreminder', weight: 6 },
    { type: 'REMINDER', term: 'finaldemand', weight: 6 },
    { type: 'REMINDER', term: 'dunning', weight: 5 }
];

/* "purchase order" appears on most invoices as a reference field, so it only
   counts towards PURCHASE_ORDER when there is no invoice evidence at all. */
var DC_AMBIGUOUS = { 'purchaseorderno': 1, 'purchaseorder': 1, 'deliverto': 1 };

function dc_score(compact) {
    var scores = {};
    var matched = [];
    var i;
    for (i = 0; i < DC_SIGNALS.length; i++) {
        var sig = DC_SIGNALS[i];
        if (compact.indexOf(sig.term) >= 0) {
            if (!scores[sig.type]) { scores[sig.type] = 0; }
            scores[sig.type] += sig.weight;
            matched.push(sig.type + ':' + sig.term);
        }
    }
    return { scores: scores, matched: matched };
}

function classifyDocument(base64Content, textOverride, invoiceFamilyStr) {
    var res = {
        validation: 'DOCUMENT_CLASSIFICATION',
        passed: false,
        passedFlag: 'N',
        status: 'ERROR',
        reason: '',
        documentType: 'UNKNOWN',
        confidence: 'NONE',
        invoiceScore: 0,
        competingType: '',
        competingScore: 0,
        matchedTerms: '',
        hasTextLayer: false,
        noTextReason: '',
        error: ''
    };

    try {
        var family = 'INVOICE,CREDIT_NOTE';
        if (invoiceFamilyStr !== null && invoiceFamilyStr !== undefined &&
            String(invoiceFamilyStr).length > 0) {
            family = String(invoiceFamilyStr).toUpperCase();
        }
        var familyList = family.replace(/\s+/g, '').split(',');

        var resolved = __P___resolveText(base64Content, textOverride);
        var text = resolved.text;
        res.noTextReason = resolved.reason;
        res.hasTextLayer = text.length > 20;

        if (!res.hasTextLayer) {
            res.passed = true;
            res.passedFlag = 'Y';
            res.status = 'UNCLASSIFIED';
            res.reason = 'No readable text: ' + res.noTextReason +
                '. Cannot classify here - sending to Document Understanding to classify.';
            return res;
        }

        var compact = __P___compact(text);
        var scored = dc_score(compact);
        var scores = scored.scores;
        res.matchedTerms = scored.matched.join(', ');

        var invoiceScore = (scores.INVOICE || 0);
        var creditScore = (scores.CREDIT_NOTE || 0);
        res.invoiceScore = invoiceScore + creditScore;

        /* Discount the ambiguous PO terms when invoice evidence is present. */
        if (invoiceScore >= 4 && scores.PURCHASE_ORDER) {
            var discount = 0;
            for (var k in DC_AMBIGUOUS) {
                if (DC_AMBIGUOUS.hasOwnProperty(k) && compact.indexOf(k) >= 0) {
                    for (var j = 0; j < DC_SIGNALS.length; j++) {
                        if (DC_SIGNALS[j].term === k) { discount += DC_SIGNALS[j].weight; }
                    }
                }
            }
            scores.PURCHASE_ORDER = scores.PURCHASE_ORDER - discount;
            if (scores.PURCHASE_ORDER < 0) { scores.PURCHASE_ORDER = 0; }
        }

        /* Highest non-invoice-family score. */
        var bestType = '';
        var bestScore = 0;
        for (var t in scores) {
            if (!scores.hasOwnProperty(t)) { continue; }
            if (t === 'INVOICE' || t === 'CREDIT_NOTE') { continue; }
            if (scores[t] > bestScore) { bestScore = scores[t]; bestType = t; }
        }
        res.competingType = bestType;
        res.competingScore = bestScore;

        if (res.invoiceScore >= 4 && res.invoiceScore >= bestScore) {
            res.documentType = creditScore >= 6 ? 'CREDIT_NOTE' : 'INVOICE';
        } else if (bestScore >= 4) {
            res.documentType = bestType;
        } else if (res.invoiceScore >= 3) {
            res.documentType = 'INVOICE';
        } else {
            res.documentType = 'UNKNOWN';
        }

        var top = res.documentType === 'INVOICE' || res.documentType === 'CREDIT_NOTE'
            ? res.invoiceScore : bestScore;
        res.confidence = top >= 8 ? 'HIGH' : (top >= 4 ? 'MEDIUM' : 'LOW');

        var inFamily = false;
        for (var f = 0; f < familyList.length; f++) {
            if (familyList[f] === res.documentType) { inFamily = true; }
        }

        if (res.documentType === 'UNKNOWN') {
            res.passed = true;
            res.passedFlag = 'Y';
            res.status = 'UNCLASSIFIED';
            res.reason = 'Text layer present but no document type scored high enough. ' +
                'Sending to Document Understanding to classify.';
            return res;
        }

        if (!inFamily) {
            res.status = 'NOT_INVOICE';
            res.reason = 'Classified as ' + res.documentType + ' (score ' + top +
                ', confidence ' + res.confidence + ') - not in the invoice family (' +
                family + ').';
            return res;
        }

        res.passed = true;
        res.passedFlag = 'Y';
        res.status = 'PASSED';
        res.reason = 'Classified as ' + res.documentType + ' (score ' + top +
            ', confidence ' + res.confidence + ').';
        return res;
    } catch (e) {
        res.status = 'ERROR';
        res.error = String(e && e.message ? e.message : e);
        res.reason = 'Document classification failed: ' + res.error;
        return res;
    }
}
