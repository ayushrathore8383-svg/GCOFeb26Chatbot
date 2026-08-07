/**
 * VALIDATION 6 - Multi-invoice PDF detection.
 *
 * OIC call signature:
 *   validateMultiInvoice(base64Content, textOverride)
 *
 * base64Content - always required here: the page count is read from the PDF
 *                 object structure, not from the text.
 * textOverride  - optional, as in validations 3-5.
 *
 * Reject, log to the database and show in the APEX rejected queue when
 * status === "MULTI_INVOICE".
 *
 * Two independent signals are used, and either one is enough to reject:
 *   1. More than one distinct invoice number appears in the text.
 *   2. More than one "Page 1 of N" marker appears - each one starts a new document.
 *
 * Known false positive: a covering page or an appendix that quotes a second
 * invoice number will trip signal 1. invoiceNumbers is returned in full so the
 * AP team can see what was matched from the APEX rejected queue.
 */

var MI_INVOICE_NO = /invoice\s*(?:no|number|nbr|num|#)\s*\.?\s*[:#\-]?\s*([A-Za-z0-9][A-Za-z0-9\-\/]{2,29})/gi;
var MI_PAGE_ONE = /page\s*1\s*(?:of|\/)\s*\d+/gi;
var MI_PAGE_OF = /page\s*(\d+)\s*(?:of|\/)\s*(\d+)/gi;

var MI_REJECT = /^(number|no|date|ref|reference|none|n\/a|na|tbc|tba|to|for)$/i;

function mi_invoiceNumbers(text) {
    var seen = {};
    var list = [];
    var m;
    var guard = 0;
    MI_INVOICE_NO.lastIndex = 0;
    while ((m = MI_INVOICE_NO.exec(text)) !== null && guard++ < 1000) {
        var raw = String(m[1]).replace(/[^A-Za-z0-9\-\/]/g, '').toUpperCase();
        if (raw.length < 3) { continue; }
        if (MI_REJECT.test(raw)) { continue; }
        if (!/\d/.test(raw)) { continue; }
        if (seen[raw]) { continue; }
        seen[raw] = true;
        list.push(raw);
    }
    return list;
}

function mi_countMatches(text, re) {
    re.lastIndex = 0;
    var n = 0;
    var guard = 0;
    while (re.exec(text) !== null && guard++ < 5000) { n++; }
    return n;
}

/* Count page objects, including pages hidden inside compressed object streams. */
function mi_pageCount(bytes) {
    var s = __P___bytesToLatin1(bytes);
    var re = /\/Type\s*\/Page[^s]/g;
    var count = mi_countMatches(s, re);
    if (count > 0) { return count; }

    /* PDF 1.5+ cross-reference streams keep the page tree inside object streams. */
    var idx = 0;
    var guard = 0;
    while (guard++ < 2000) {
        var st = s.indexOf('stream', idx);
        if (st < 0) { break; }
        if (s.substring(st - 3, st) === 'end') { idx = st + 6; continue; }
        var dictStart = s.lastIndexOf('<<', st);
        var dict = dictStart >= 0 ? s.substring(dictStart, st) : '';
        var dataStart = st + 6;
        if (s.charAt(dataStart) === '\r') { dataStart++; }
        if (s.charAt(dataStart) === '\n') { dataStart++; }
        var dataEnd = s.indexOf('endstream', dataStart);
        if (dataEnd < 0) { break; }
        idx = dataEnd + 9;
        if (dict.indexOf('/ObjStm') < 0) { continue; }
        try {
            var raw = __P___inflate(bytes, dataStart, dataEnd);
            count += mi_countMatches(__P___bytesToLatin1(raw), /\/Type\s*\/Page[^s]/g);
        } catch (ignored) {
            /* skip */
        }
    }
    return count;
}

function validateMultiInvoice(base64Content, textOverride) {
    var res = {
        validation: 'MULTI_INVOICE',
        passed: false,
        passedFlag: 'N',
        status: 'ERROR',
        reason: '',
        invoiceCount: 0,
        invoiceNumbers: '',
        pageOneMarkers: 0,
        pageCount: 0,
        detectedBy: '',
        hasTextLayer: false,
        noTextReason: '',
        error: ''
    };

    try {
        var bytes = __P___b64ToBytes(base64Content);
        res.pageCount = bytes.length > 0 ? mi_pageCount(bytes) : 0;

        var resolved = __P___resolveText(base64Content, textOverride);
        var text = resolved.text;
        res.noTextReason = resolved.reason;
        res.hasTextLayer = text.length > 20;

        if (!res.hasTextLayer) {
            res.passed = true;
            res.passedFlag = 'Y';
            res.status = 'UNDETERMINED';
            res.reason = 'No readable text: ' + res.noTextReason + '. ' + res.pageCount +
                ' page(s) detected. Cannot count invoices here - sending to ' +
                'Document Understanding.';
            return res;
        }

        var numbers = mi_invoiceNumbers(text);
        res.invoiceCount = numbers.length;
        res.invoiceNumbers = numbers.join(',');
        res.pageOneMarkers = mi_countMatches(text, MI_PAGE_ONE);

        if (numbers.length > 1) {
            res.detectedBy = 'DISTINCT_INVOICE_NUMBERS';
            res.status = 'MULTI_INVOICE';
            res.reason = numbers.length + ' distinct invoice numbers found (' +
                res.invoiceNumbers + ') across ' + res.pageCount +
                ' page(s) - PDF contains more than one invoice.';
            return res;
        }

        if (res.pageOneMarkers > 1) {
            res.detectedBy = 'REPEATED_PAGE_ONE_MARKER';
            res.status = 'MULTI_INVOICE';
            res.reason = res.pageOneMarkers + ' separate "Page 1 of N" markers found ' +
                'across ' + res.pageCount + ' page(s) - PDF contains more than one document.';
            return res;
        }

        res.passed = true;
        res.passedFlag = 'Y';
        res.status = 'PASSED';
        res.reason = 'Single invoice detected (' +
            (res.invoiceCount === 1 ? 'invoice number ' + res.invoiceNumbers
                : 'no invoice number in text') +
            ', ' + res.pageCount + ' page(s)).';
        return res;
    } catch (e) {
        res.status = 'ERROR';
        res.error = String(e && e.message ? e.message : e);
        res.reason = 'Multi-invoice check failed: ' + res.error;
        return res;
    }
}
