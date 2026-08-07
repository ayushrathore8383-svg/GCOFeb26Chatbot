/**
 * VALIDATION 5 - Pharmacy invoice detection by PO number prefix.
 *
 * OIC call signature:
 *   validatePharmacyInvoice(base64Content, textOverride, pharmacyPrefixes)
 *
 * pharmacyPrefixes - REQUIRED. Comma-separated list of PO number prefixes that
 *                    route to pharmacy, e.g. "PH,PHM,RX".
 *                    [EVIDENCE NEEDED: the real prefix list for your AP setup.
 *                    There is no default because guessing it would either reject
 *                    good invoices or let pharmacy invoices through silently.]
 *
 * Reject to the APEX rejected queue when status === "PHARMACY_INVOICE".
 *
 * status === "CONFIG_MISSING" means no prefixes were supplied. It returns
 * passed = true so nothing is wrongly rejected, but route that status to an
 * error/alert path in OIC - the check is not actually running.
 */

var PH_PO_PATTERNS = [
    /(?:purchase\s*order|p\s*\.?\s*o\s*\.?)\s*(?:number|no\.?|num|nbr|ref(?:erence)?|#)?\s*[:#\-]?\s*([A-Za-z0-9][A-Za-z0-9\-\/]{2,29})/gi,
    /(?:customer\s*(?:po|order)|your\s*(?:po|order)|order)\s*(?:number|no\.?|ref(?:erence)?|#)\s*[:#\-]?\s*([A-Za-z0-9][A-Za-z0-9\-\/]{2,29})/gi
];

/* Reject obvious non-PO captures: dates, plain money, single words. */
var PH_REJECT = [
    /^\d{1,2}[\-\/]\d{1,2}[\-\/]\d{2,4}$/,
    /^\d{1,2}[\-\/][A-Za-z]{3}[\-\/]?\d{0,4}$/,
    /^(number|no|date|ref|reference|not|none|n\/a|na|tbc|tba)$/i
];

function ph_looksLikePo(value) {
    if (!value || value.length < 3) { return false; }
    for (var i = 0; i < PH_REJECT.length; i++) {
        if (PH_REJECT[i].test(value)) { return false; }
    }
    /* a PO reference must contain at least one digit */
    return /\d/.test(value);
}

function ph_extractPoNumbers(text) {
    var seen = {};
    var list = [];
    for (var p = 0; p < PH_PO_PATTERNS.length; p++) {
        var re = PH_PO_PATTERNS[p];
        re.lastIndex = 0;
        var m;
        var guard = 0;
        while ((m = re.exec(text)) !== null && guard++ < 500) {
            var raw = String(m[1]).replace(/[^A-Za-z0-9\-\/]/g, '').toUpperCase();
            if (!ph_looksLikePo(raw)) { continue; }
            if (seen[raw]) { continue; }
            seen[raw] = true;
            list.push(raw);
        }
    }
    return list;
}

function validatePharmacyInvoice(base64Content, textOverride, pharmacyPrefixes) {
    var res = {
        validation: 'PHARMACY_INVOICE',
        passed: false,
        passedFlag: 'N',
        status: 'ERROR',
        reason: '',
        poNumber: '',
        poNumbers: '',
        poCount: 0,
        matchedPrefix: '',
        prefixesUsed: '',
        hasTextLayer: false,
        error: ''
    };

    try {
        var prefixRaw = pharmacyPrefixes === null || pharmacyPrefixes === undefined
            ? '' : String(pharmacyPrefixes);
        var prefixes = [];
        var parts = prefixRaw.toUpperCase().split(',');
        for (var i = 0; i < parts.length; i++) {
            var p = parts[i].replace(/[^A-Z0-9\-\/]/g, '');
            if (p.length > 0) { prefixes.push(p); }
        }
        res.prefixesUsed = prefixes.join(',');

        if (prefixes.length === 0) {
            res.passed = true;
            res.passedFlag = 'Y';
            res.status = 'CONFIG_MISSING';
            res.reason = 'No pharmacy PO prefixes were supplied, so the pharmacy check ' +
                'did not run. Pass a comma-separated list such as "PH,PHM,RX".';
            return res;
        }

        var text = __P___resolveText(base64Content, textOverride);
        res.hasTextLayer = text.length > 20;

        if (!res.hasTextLayer) {
            res.passed = true;
            res.passedFlag = 'Y';
            res.status = 'PO_NOT_FOUND';
            res.reason = 'No text layer found (scanned or image-only PDF) - PO number ' +
                'cannot be read here. Re-run this check on the DU-extracted PO number.';
            return res;
        }

        var pos = ph_extractPoNumbers(text);
        res.poNumbers = pos.join(',');
        res.poCount = pos.length;

        if (pos.length === 0) {
            res.passed = true;
            res.passedFlag = 'Y';
            res.status = 'PO_NOT_FOUND';
            res.reason = 'No PO number found in the text layer.';
            return res;
        }

        res.poNumber = pos[0];

        for (var a = 0; a < pos.length; a++) {
            for (var b = 0; b < prefixes.length; b++) {
                if (pos[a].indexOf(prefixes[b]) === 0) {
                    res.poNumber = pos[a];
                    res.matchedPrefix = prefixes[b];
                    res.status = 'PHARMACY_INVOICE';
                    res.reason = 'PO number ' + pos[a] + ' starts with pharmacy prefix "' +
                        prefixes[b] + '" - route to pharmacy handling.';
                    return res;
                }
            }
        }

        res.passed = true;
        res.passedFlag = 'Y';
        res.status = 'PASSED';
        res.reason = 'PO number(s) ' + res.poNumbers + ' do not match any pharmacy prefix (' +
            res.prefixesUsed + ').';
        return res;
    } catch (e) {
        res.status = 'ERROR';
        res.error = String(e && e.message ? e.message : e);
        res.reason = 'Pharmacy check failed: ' + res.error;
        return res;
    }
}
