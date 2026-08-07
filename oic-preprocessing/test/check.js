/*
 * Run the six validations against real PDFs, outside OIC.
 *
 *   node test/check.js invoice.pdf
 *   node test/check.js invoice.pdf --prefixes PH,PHM,RX
 *   node test/check.js ./sample-invoices --csv results.csv
 *   node test/check.js invoice.pdf --all --text
 *
 * Options
 *   --prefixes A,B   pharmacy PO prefixes for validation 5
 *   --family A,B     document types allowed through validation 4
 *   --tolerance N    zero-value tolerance for validation 3
 *   --all            run all six even after one rejects (default stops at the first)
 *   --text           print the extracted text layer
 *   --csv FILE       write one row per PDF, for batch triage
 *
 * A folder argument processes every .pdf inside it, one level deep.
 */
var fs = require('fs');
var path = require('path');
var vm = require('vm');

var DIST = path.join(__dirname, '..', 'dist');

function load(file) {
    var sandbox = {};
    vm.createContext(sandbox);
    vm.runInContext(fs.readFileSync(path.join(DIST, file), 'utf8'), sandbox, { filename: file });
    return sandbox;
}

var LIB = {
    format: load('validateFileFormat.js'),
    password: load('validatePasswordProtection.js'),
    zero: load('validateZeroValue.js'),
    classify: load('classifyDocument.js'),
    pharmacy: load('validatePharmacyInvoice.js'),
    multi: load('validateMultiInvoice.js')
};

/* ---------- argument parsing ---------- */
var argv = process.argv.slice(2);
var target = null;
var opt = { prefixes: '', family: '', tolerance: '', all: false, text: false, csv: null };

for (var i = 0; i < argv.length; i++) {
    var a = argv[i];
    if (a === '--all') { opt.all = true; }
    else if (a === '--text') { opt.text = true; }
    else if (a === '--prefixes') { opt.prefixes = argv[++i] || ''; }
    else if (a === '--family') { opt.family = argv[++i] || ''; }
    else if (a === '--tolerance') { opt.tolerance = argv[++i] || ''; }
    else if (a === '--csv') { opt.csv = argv[++i] || null; }
    else if (a.indexOf('--') === 0) { console.error('unknown option ' + a); process.exit(2); }
    else { target = a; }
}

if (!target) {
    console.error('usage: node test/check.js <file.pdf|folder> [--prefixes PH,PHM] ' +
        '[--family INVOICE] [--tolerance 0.01] [--all] [--text] [--csv out.csv]');
    process.exit(2);
}
if (!fs.existsSync(target)) {
    console.error('not found: ' + target);
    process.exit(2);
}

/* ---------- verdicts ---------- */

/* Statuses meaning "the check could not run on the evidence available". These must
   NOT stop the chain: a scanned PDF returns TOTAL_NOT_FOUND at step 3, and stopping
   there would skip the classification and multi-invoice checks that can still fire. */
var INDETERMINATE = {
    TOTAL_NOT_FOUND: 1, UNCLASSIFIED: 1, PO_NOT_FOUND: 1,
    UNDETERMINED: 1, CONFIG_MISSING: 1
};

function verdict(status) {
    if (status === 'PASSED') { return 'pass'; }
    if (status === 'ERROR') { return 'error'; }
    if (INDETERMINATE[status]) { return 'skip'; }
    return 'REJECT';
}

/* ---------- the pipeline, in the same order the integration should call it ---------- */
function runPipeline(filePath) {
    var fileName = path.basename(filePath);
    var b64 = fs.readFileSync(filePath).toString('base64');
    var steps = [];
    var pdfText = '';
    var stopped = false;
    var extract = null;

    function record(n, name, r) {
        steps.push({ n: n, name: name, result: r });
        var v = verdict(r.status);
        if ((v === 'REJECT' || v === 'error') && !opt.all) { stopped = true; }
        return r;
    }

    record(1, 'File format', LIB.format.validateFileFormat(fileName, b64));
    if (stopped) { return { fileName: fileName, steps: steps, pdfText: pdfText, reachedDu: false, extract: extract }; }

    record(2, 'Password protection', LIB.password.validatePasswordProtection(b64));
    if (stopped) { return { fileName: fileName, steps: steps, pdfText: pdfText, reachedDu: false, extract: extract }; }

    /* extract once, reuse across 3-5, exactly as the integration should */
    var extracted = LIB.zero.zv_extractPdfText(b64);
    pdfText = extracted.text;
    extract = extracted;

    record(3, 'Zero value', LIB.zero.validateZeroValue('', pdfText, opt.tolerance));
    if (stopped) { return { fileName: fileName, steps: steps, pdfText: pdfText, reachedDu: false, extract: extract }; }

    record(4, 'Classification', LIB.classify.classifyDocument('', pdfText, opt.family));
    if (stopped) { return { fileName: fileName, steps: steps, pdfText: pdfText, reachedDu: false, extract: extract }; }

    record(5, 'Pharmacy', LIB.pharmacy.validatePharmacyInvoice('', pdfText, opt.prefixes));
    if (stopped) { return { fileName: fileName, steps: steps, pdfText: pdfText, reachedDu: false, extract: extract }; }

    record(6, 'Multi-invoice', LIB.multi.validateMultiInvoice(b64, pdfText));

    var reachedDu = true;
    for (var s = 0; s < steps.length; s++) {
        if (steps[s].result.status !== 'PASSED') { reachedDu = false; }
    }
    return { fileName: fileName, steps: steps, pdfText: pdfText, reachedDu: reachedDu, extract: extract };
}

/* ---------- reporting ---------- */
function rejectingStep(run) {
    for (var i = 0; i < run.steps.length; i++) {
        var v = verdict(run.steps[i].result.status);
        if (v === 'REJECT' || v === 'error') { return run.steps[i]; }
    }
    return null;
}

function unresolvedCount(run) {
    var n = 0;
    for (var i = 0; i < run.steps.length; i++) {
        if (verdict(run.steps[i].result.status) === 'skip') { n++; }
    }
    return n;
}

function report(run) {
    console.log('\n' + run.fileName);
    console.log('-'.repeat(Math.max(run.fileName.length, 60)));
    run.steps.forEach(function (s) {
        var v = verdict(s.result.status);
        var tag = v === 'pass' ? ' ok ' : (v === 'REJECT' ? 'STOP' : (v === 'error' ? ' ?? ' : ' -- '));
        console.log('[' + tag + '] ' + s.n + '. ' + s.name + ': ' + s.result.status);
        console.log('        ' + s.result.reason);
        if (s.result.error) { console.log('        error: ' + s.result.error); }
    });

    var x = run.extract;
    if (x && !x.hasTextLayer) {
        console.log('\n  no text could be read: ' + x.noTextReason);
        console.log('  streams ' + x.streamsFound + ', decoded ' + x.streamsDecoded +
            ', with text ' + x.streamsWithText + ', image ' + x.imageStreams +
            ' | filters: ' + (x.filtersSeen || 'none') +
            (x.filtersFailed ? ' | FAILED: ' + x.filtersFailed : ''));
    } else if (x) {
        console.log('\n  text read from ' + x.streamsWithText + '/' + x.streamsFound +
            ' stream(s) | filters: ' + (x.filtersSeen || 'none'));
    }

    var stop = rejectingStep(run);
    if (stop) {
        console.log('\n=> REJECTED at step ' + stop.n + ' (' + stop.name + '): ' +
            stop.result.status);
    } else if (run.reachedDu) {
        console.log('\n=> proceeds to DU key-value extraction, all six checks clean');
    } else {
        console.log('\n=> proceeds to DU, but ' + unresolvedCount(run) +
            ' check(s) could not run - see the -- rows above');
    }

    if (opt.text) {
        console.log('\n--- extracted text layer (' + run.pdfText.length + ' chars) ---');
        console.log(run.pdfText || '(none - scanned or image-only PDF)');
    }
}

function csvCell(v) {
    var s = String(v === null || v === undefined ? '' : v);
    return '"' + s.replace(/"/g, '""') + '"';
}

function csvRow(run) {
    var by = {};
    run.steps.forEach(function (s) { by[s.n] = s.result; });
    var stop = rejectingStep(run);
    var outcome = stop ? 'REJECTED_' + stop.result.status
        : (run.reachedDu ? 'TO_DU' : 'TO_DU_UNRESOLVED');
    return [
        run.fileName,
        outcome,
        by[1] ? by[1].status : '',
        by[2] ? by[2].status : '',
        by[3] ? by[3].status : '',
        by[4] ? by[4].status : '',
        by[5] ? by[5].status : '',
        by[6] ? by[6].status : '',
        by[3] ? by[3].hasTextLayer : '',
        run.pdfText.length,
        by[3] ? by[3].grossTotal : '',
        by[4] ? by[4].documentType : '',
        by[5] ? by[5].poNumber : '',
        by[6] ? by[6].pageCount : '',
        by[6] ? by[6].invoiceNumbers : '',
        run.extract ? run.extract.filtersSeen : '',
        run.extract ? run.extract.filtersFailed : '',
        run.extract ? run.extract.noTextReason : ''
    ].map(csvCell).join(',');
}

/* ---------- main ---------- */
var files = [];
if (fs.statSync(target).isDirectory()) {
    fs.readdirSync(target).forEach(function (f) {
        if (/\.pdf$/i.test(f)) { files.push(path.join(target, f)); }
    });
    files.sort();
    if (files.length === 0) {
        console.error('no .pdf files in ' + target);
        process.exit(2);
    }
} else {
    files.push(target);
}

var runs = [];
files.forEach(function (f) {
    var run;
    try {
        run = runPipeline(f);
    } catch (e) {
        console.error('\n' + path.basename(f) + ': harness failed - ' + e.message);
        return;
    }
    runs.push(run);
    if (files.length === 1 || !opt.csv) { report(run); }
});

if (files.length > 1) {
    var toDu = 0;
    var rejected = 0;
    var unresolved = 0;
    var noText = 0;
    runs.forEach(function (r) {
        if (rejectingStep(r)) { rejected++; }
        else if (r.reachedDu) { toDu++; }
        else { unresolved++; }
        if (r.pdfText.length <= 20) { noText++; }
    });
    console.log('\n=== ' + runs.length + ' file(s) ===');
    console.log('  to DU, all checks clean : ' + toDu);
    console.log('  rejected                : ' + rejected);
    console.log('  to DU, checks unresolved: ' + unresolved);
    console.log('  no text layer (scanned) : ' + noText +
        '  <- checks 3-6 cannot run on these');
}

if (opt.csv) {
    var header = ['file', 'outcome', 'check1_format', 'check2_password', 'check3_zero',
        'check4_class', 'check5_pharmacy', 'check6_multi', 'has_text_layer',
        'text_chars', 'gross_total', 'document_type', 'po_number', 'page_count',
        'invoice_numbers', 'filters_seen', 'filters_failed',
        'no_text_reason'].map(csvCell).join(',');
    var body = runs.map(csvRow).join('\n');
    fs.writeFileSync(opt.csv, header + '\n' + body + '\n');
    console.log('\nwrote ' + opt.csv);
}
