/**
 * VALIDATION 3 - Zero-value invoice check.
 *
 * OIC call signature:
 *   validateZeroValue(base64Content, textOverride, zeroToleranceStr)
 *
 * base64Content    - the PDF as base64. Ignored when textOverride is supplied.
 * textOverride     - optional. Text from a previous __P__extractPdfText call, so the
 *                    PDF is only parsed once across validations 3-6. Pass "" to skip.
 * zeroToleranceStr - optional. Absolute value at or below which the total counts as
 *                    zero. Pass "" for the default of 0.
 *
 * Reject when status === "ZERO_VALUE".
 * status === "TOTAL_NOT_FOUND" means no total could be read (usually a scanned
 * image PDF). That returns passed = true on purpose: the document is sent on to
 * Document Understanding rather than being rejected on missing evidence.
 */

var ZV_LABELS = [
    { name: 'GROSS_TOTAL', re: /(gross\s*(?:total|amount|value))/i },
    { name: 'BALANCE_DUE', re: /(balance\s*due|amount\s*due|total\s*due|amount\s*payable|total\s*payable|please\s*pay)/i },
    { name: 'INVOICE_TOTAL', re: /(invoice\s*total|grand\s*total|total\s*inc(?:l|luding)?[^\n]{0,12}(?:vat|tax|gst)?|total\s*\(?inc)/i },
    { name: 'NET_TOTAL', re: /(net\s*(?:total|amount)|sub\s*-?\s*total)/i },
    { name: 'TOTAL', re: /(^|\s)total(\s|:|$)/i }
];

/* Labels that look like totals but count things, not money. */
var ZV_NOISE = /(qty|quantity|item|line|page|unit|weight|hours|count|no\.)/i;

var ZV_NUMBER = /\(?-?(?:[0-9]{1,3}(?:[.,][0-9]{3})*|[0-9]+)(?:[.,][0-9]{1,2})?\)?/g;

function zv_amountsOnLine(line) {
    var stripped = line.replace(/[A-Za-z£$€¥]+/g, ' ');
    var found = stripped.match(ZV_NUMBER);
    var vals = [];
    if (!found) { return vals; }
    for (var i = 0; i < found.length; i++) {
        var v = __P___parseAmount(found[i]);
        if (v !== null) { vals.push(v); }
    }
    return vals;
}

function zv_findTotal(lines) {
    var i;
    var l;
    for (var p = 0; p < ZV_LABELS.length; p++) {
        var label = ZV_LABELS[p];
        /* scan bottom-up: invoice totals live at the foot of the document */
        for (i = lines.length - 1; i >= 0; i--) {
            l = lines[i];
            if (!label.re.test(l)) { continue; }
            if (ZV_NOISE.test(l)) { continue; }
            var after = l.replace(label.re, ' ');
            var vals = zv_amountsOnLine(after);
            if (vals.length > 0) {
                return { label: label.name, matchedLine: l, value: vals[vals.length - 1] };
            }
            /* label and figure split across two lines */
            if (i + 1 < lines.length) {
                var next = zv_amountsOnLine(lines[i + 1]);
                if (next.length > 0) {
                    return {
                        label: label.name,
                        matchedLine: l + ' | ' + lines[i + 1],
                        value: next[next.length - 1]
                    };
                }
            }
        }
    }
    return null;
}

function validateZeroValue(base64Content, textOverride, zeroToleranceStr) {
    var res = {
        validation: 'ZERO_VALUE',
        passed: false,
        passedFlag: 'N',
        status: 'ERROR',
        reason: '',
        grossTotal: 0,
        totalFound: false,
        matchedLabel: '',
        matchedLine: '',
        hasTextLayer: false,
        noTextReason: '',
        error: ''
    };

    try {
        var tolerance = 0;
        if (zeroToleranceStr !== null && zeroToleranceStr !== undefined &&
            String(zeroToleranceStr).length > 0) {
            var t = parseFloat(zeroToleranceStr);
            if (!isNaN(t)) { tolerance = Math.abs(t); }
        }

        var resolved = __P___resolveText(base64Content, textOverride);
        var text = resolved.text;
        res.noTextReason = resolved.reason;
        res.hasTextLayer = text.length > 20;

        if (!res.hasTextLayer) {
            res.passed = true;
            res.passedFlag = 'Y';
            res.status = 'TOTAL_NOT_FOUND';
            res.reason = 'No readable text: ' + res.noTextReason +
                '. Gross total cannot be checked here - sending to Document Understanding.';
            return res;
        }

        var hit = zv_findTotal(text.split('\n'));
        if (hit === null) {
            res.passed = true;
            res.passedFlag = 'Y';
            res.status = 'TOTAL_NOT_FOUND';
            res.reason = 'Text layer present but no recognisable total label was found. ' +
                'Sending to Document Understanding.';
            return res;
        }

        res.totalFound = true;
        res.grossTotal = hit.value;
        res.matchedLabel = hit.label;
        res.matchedLine = hit.matchedLine.length > 200
            ? hit.matchedLine.substring(0, 200)
            : hit.matchedLine;

        if (Math.abs(hit.value) <= tolerance) {
            res.status = 'ZERO_VALUE';
            res.reason = 'Gross total is ' + hit.value + ' (matched on "' + hit.label +
                '") - zero-value invoice.';
            return res;
        }

        res.passed = true;
        res.passedFlag = 'Y';
        res.status = 'PASSED';
        res.reason = 'Gross total is ' + hit.value + ' (matched on "' + hit.label + '").';
        return res;
    } catch (e) {
        res.status = 'ERROR';
        res.error = String(e && e.message ? e.message : e);
        res.reason = 'Zero-value check failed: ' + res.error;
        return res;
    }
}
