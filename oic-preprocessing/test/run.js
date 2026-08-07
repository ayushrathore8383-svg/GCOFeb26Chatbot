/*
 * Test harness for the six OIC JavaScript libraries.
 *
 *   python3 test/make_fixtures.py
 *   node test/run.js
 *
 * Each dist file is loaded into a bare sandbox with no Node globals, which is
 * the closest local approximation of the OIC JavaScript runtime: if a library
 * accidentally reaches for require, Buffer or console it fails here.
 */
var fs = require('fs');
var path = require('path');
var vm = require('vm');

var DIST = path.join(__dirname, '..', 'dist');
var FIX = path.join(__dirname, 'fixtures');

function load(file) {
    var sandbox = {};
    vm.createContext(sandbox);
    vm.runInContext(fs.readFileSync(path.join(DIST, file), 'utf8'), sandbox, { filename: file });
    return sandbox;
}

function b64(name) {
    return fs.readFileSync(path.join(FIX, name)).toString('base64');
}

var LIB = {
    format: load('validateFileFormat.js'),
    password: load('validatePasswordProtection.js'),
    zero: load('validateZeroValue.js'),
    classify: load('classifyDocument.js'),
    pharmacy: load('validatePharmacyInvoice.js'),
    multi: load('validateMultiInvoice.js')
};

var pass = 0;
var fail = 0;
var failures = [];

function check(label, actual, expected) {
    if (actual === expected) {
        pass++;
        console.log('  ok    ' + label + '  ->  ' + actual);
    } else {
        fail++;
        failures.push(label + ': expected ' + expected + ', got ' + actual);
        console.log('  FAIL  ' + label + '  ->  ' + actual + ' (expected ' + expected + ')');
    }
}

function show(r) {
    console.log('        ' + r.reason);
}

console.log('\n1. validateFileFormat');
[
    ['valid_invoice.pdf', 'PASSED'],
    ['not_a_pdf.docx', 'NOT_PDF'],
    ['truncated.pdf', 'CORRUPT_PDF'],
    ['empty.pdf', 'EMPTY_FILE']
].forEach(function (t) {
    var r = LIB.format.validateFileFormat(t[0], b64(t[0]));
    check(t[0], r.status, t[1]);
    show(r);
});
(function () {
    var r = LIB.format.validateFileFormat('report.xlsx', '');
    check('report.xlsx wrong extension beats empty', r.status, 'NOT_PDF');
    var r2 = LIB.format.validateFileFormat('scan.PDF', '');
    check('scan.PDF with no content', r2.status, 'EMPTY_FILE');
    var r3 = LIB.format.validateFileFormat('invoice.pdf', b64('not_a_pdf.docx'));
    check('non-pdf renamed to .pdf', r3.status, 'NOT_PDF');
    show(r3);
    var r4 = LIB.format.validateFileFormat('SCAN.PDF', b64('valid_invoice.pdf'));
    check('uppercase extension accepted', r4.status, 'PASSED');
})();

console.log('\n2. validatePasswordProtection');
[
    ['valid_invoice.pdf', 'PASSED'],
    ['encrypted_invoice.pdf', 'PASSWORD_PROTECTED']
].forEach(function (t) {
    var r = LIB.password.validatePasswordProtection(b64(t[0]));
    check(t[0], r.status, t[1]);
    show(r);
});

(function () {
    var r = LIB.password.validatePasswordProtection(b64('encrypted_invoice.pdf'));
    check('encryption dict /V resolved', r.encryptVersion, 2);
    check('encryption dict /R resolved', r.encryptRevision, 3);
    check('encryption dict /P resolved', r.permissions, -3904);
    check('encryption dict /Filter resolved', r.cryptFilter, 'Standard');
})();

console.log('\n   text extraction sanity');
(function () {
    var r = LIB.zero.zv_extractPdfText(b64('valid_invoice.pdf'));
    check('flate stream text extracted', r.hasTextLayer, true);
    check('invoice number present', r.text.indexOf('INV-2026-00841') >= 0, true);
    check('gross total present', r.text.indexOf('570.00') >= 0, true);
    var u = LIB.zero.zv_extractPdfText(b64('valid_invoice_uncompressed.pdf'));
    check('uncompressed stream text extracted', u.hasTextLayer, true);
    var s = LIB.zero.zv_extractPdfText(b64('scanned_no_text.pdf'));
    check('scanned pdf has no text layer', s.hasTextLayer, false);
})();

console.log('\n   stream filter coverage');
(function () {
    var baseline = LIB.zero.zv_extractPdfText(b64('valid_invoice.pdf')).text;
    check('baseline flate text non-empty', baseline.length > 300, true);
    [
        ['lzw_invoice_v11.pdf', 'LZWDecode'],
        ['a85_lzw_invoice.pdf', 'ASCII85Decode'],
        ['runlength_invoice.pdf', 'RunLengthDecode'],
        ['valid_invoice_uncompressed.pdf', '']
    ].forEach(function (t) {
        var r = LIB.zero.zv_extractPdfText(b64(t[0]));
        check(t[0] + ' text matches flate baseline', r.text === baseline, true);
        if (t[1]) {
            check(t[0] + ' filter reported', r.filtersSeen.indexOf(t[1]) >= 0, true);
        }
        check(t[0] + ' no failed filters', r.filtersFailed, '');
    });
})();

console.log('\n   no-text diagnostics distinguish a scan from a decode failure');
(function () {
    var scan = LIB.zero.zv_extractPdfText(b64('scanned_image_only.pdf'));
    check('image-only has no text', scan.hasTextLayer, false);
    check('image-only counts image streams', scan.imageStreams, 1);
    check('image-only names DCTDecode', scan.filtersSeen.indexOf('DCTDecode') >= 0, true);
    check('image-only reason mentions image', scan.noTextReason.indexOf('image') >= 0, true);
    check('image-only does not blame a filter', scan.filtersFailed, '');

    var lzw = LIB.zero.zv_extractPdfText(b64('lzw_invoice_v11.pdf'));
    check('lzw pdf reports no failure reason', lzw.noTextReason, '');
})();

console.log('\n3. validateZeroValue');
[
    ['valid_invoice.pdf', 'PASSED', 570],
    ['zero_value_invoice.pdf', 'ZERO_VALUE', 0],
    ['pharmacy_invoice.pdf', 'PASSED', 1445.46],
    ['scanned_no_text.pdf', 'TOTAL_NOT_FOUND', 0]
].forEach(function (t) {
    var r = LIB.zero.validateZeroValue(b64(t[0]), '', '');
    check(t[0] + ' status', r.status, t[1]);
    check(t[0] + ' total', r.grossTotal, t[2]);
    show(r);
});

console.log('\n4. classifyDocument');
[
    ['valid_invoice.pdf', 'INVOICE', true],
    ['pharmacy_invoice.pdf', 'INVOICE', true],
    ['statement.pdf', 'STATEMENT', false],
    ['delivery_note.pdf', 'DELIVERY_NOTE', false],
    ['scanned_no_text.pdf', 'UNKNOWN', true]
].forEach(function (t) {
    var r = LIB.classify.classifyDocument(b64(t[0]), '', '');
    check(t[0] + ' type', r.documentType, t[1]);
    check(t[0] + ' passed', r.passed, t[2]);
    show(r);
});

console.log('\n5. validatePharmacyInvoice');
[
    ['pharmacy_invoice.pdf', 'PH,PHM,RX', 'PHARMACY_INVOICE'],
    ['valid_invoice.pdf', 'PH,PHM,RX', 'PASSED'],
    ['valid_invoice.pdf', '', 'CONFIG_MISSING'],
    ['scanned_no_text.pdf', 'PH', 'PO_NOT_FOUND']
].forEach(function (t) {
    var r = LIB.pharmacy.validatePharmacyInvoice(b64(t[0]), '', t[1]);
    check(t[0] + ' [' + t[1] + ']', r.status, t[2]);
    show(r);
});
(function () {
    var r = LIB.pharmacy.validatePharmacyInvoice(b64('pharmacy_invoice.pdf'), '', 'PH');
    check('captured PO number', r.poNumber, 'PH-4471200');
})();

console.log('\n6. validateMultiInvoice');
[
    ['valid_invoice.pdf', 'PASSED', 1],
    ['multi_invoice.pdf', 'MULTI_INVOICE', 2],
    ['two_page_single_invoice.pdf', 'PASSED', 2],
    ['scanned_no_text.pdf', 'UNDETERMINED', 1]
].forEach(function (t) {
    var r = LIB.multi.validateMultiInvoice(b64(t[0]), '');
    check(t[0] + ' status', r.status, t[1]);
    check(t[0] + ' pageCount', r.pageCount, t[2]);
    show(r);
});

console.log('\n7. textOverride reuse (parse once, run 3-6 off the same text)');
(function () {
    var t = LIB.zero.zv_extractPdfText(b64('pharmacy_invoice.pdf')).text;
    check('zero-value via override', LIB.zero.validateZeroValue('', t, '').status, 'PASSED');
    check('classify via override', LIB.classify.classifyDocument('', t, '').documentType, 'INVOICE');
    check('pharmacy via override', LIB.pharmacy.validatePharmacyInvoice('', t, 'PH').status, 'PHARMACY_INVOICE');
    check('multi via override', LIB.multi.validateMultiInvoice(b64('pharmacy_invoice.pdf'), t).status, 'PASSED');
})();

console.log('\n8. garbage input must not throw');
['', 'not base64 at all !!!', 'AAAA'].forEach(function (junk, i) {
    var ok = true;
    try {
        LIB.format.validateFileFormat('x.pdf', junk);
        LIB.password.validatePasswordProtection(junk);
        LIB.zero.validateZeroValue(junk, '', '');
        LIB.classify.classifyDocument(junk, '', '');
        LIB.pharmacy.validatePharmacyInvoice(junk, '', 'PH');
        LIB.multi.validateMultiInvoice(junk, '');
    } catch (e) {
        ok = false;
        console.log('        threw: ' + e.message);
    }
    check('junk input #' + (i + 1) + ' handled', ok, true);
});

console.log('\n9. every result object has a stable key set');
(function () {
    var samples = [
        LIB.format.validateFileFormat('valid_invoice.pdf', b64('valid_invoice.pdf')),
        LIB.format.validateFileFormat('x.docx', b64('not_a_pdf.docx'))
    ];
    check('fileFormat keys stable',
        Object.keys(samples[0]).join(',') === Object.keys(samples[1]).join(','), true);
    var z = [
        LIB.zero.validateZeroValue(b64('valid_invoice.pdf'), '', ''),
        LIB.zero.validateZeroValue(b64('scanned_no_text.pdf'), '', '')
    ];
    check('zeroValue keys stable',
        Object.keys(z[0]).join(',') === Object.keys(z[1]).join(','), true);
})();

console.log('\n' + pass + ' passed, ' + fail + ' failed');
if (fail > 0) {
    failures.forEach(function (f) { console.log('  - ' + f); });
    process.exit(1);
}
