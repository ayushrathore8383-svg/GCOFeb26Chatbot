/**
 * VALIDATION 1 - File format validation.
 *
 * OIC call signature:
 *   validateFileFormat(fileName, base64Content)
 *
 * fileName       - the Object Storage object name, e.g. "INV-00123.pdf"
 * base64Content  - the object read as base64. Required: empty content is rejected
 *                  as EMPTY_FILE.
 *
 * Reject when status !== "PASSED". Statuses: PASSED, NOT_PDF, EMPTY_FILE,
 * CORRUPT_PDF, ERROR.
 *
 * Checks run in order: extension, non-empty, %PDF- header, %%EOF trailer. The
 * header check is what catches a non-PDF that has simply been renamed to .pdf.
 */
function validateFileFormat(fileName, base64Content) {
    var res = {
        validation: 'FILE_FORMAT',
        passed: false,
        passedFlag: 'N',
        status: 'ERROR',
        reason: '',
        fileName: String(fileName === null || fileName === undefined ? '' : fileName),
        extension: '',
        extensionOk: false,
        magicOk: false,
        eofOk: false,
        pdfVersion: '',
        sizeBytes: 0,
        error: ''
    };

    try {
        var name = res.fileName;
        var dot = name.lastIndexOf('.');
        res.extension = dot >= 0 ? name.substring(dot + 1).toLowerCase() : '';
        res.extensionOk = res.extension === 'pdf';

        /* Extension is checked first so a .xlsx never reports as "empty". */
        if (!res.extensionOk) {
            res.status = 'NOT_PDF';
            res.reason = 'File extension is "' + res.extension + '", expected "pdf".';
            return res;
        }

        var bytes = __P___b64ToBytes(base64Content);
        res.sizeBytes = bytes.length;

        /* An empty payload is always a rejection. There is deliberately no
           "name only" mode: a zero-byte object and a missing object would be
           indistinguishable, and letting either through would send an unreadable
           file to Document Understanding. */
        if (res.sizeBytes === 0) {
            res.status = 'EMPTY_FILE';
            res.reason = 'File content is zero bytes (object empty, or no content was ' +
                'passed to the validation).';
            return res;
        }

        var head = __P___bytesToLatin1(bytes.slice(0, 1024));
        var magicAt = head.indexOf('%PDF-');
        res.magicOk = magicAt >= 0;
        if (res.magicOk) {
            var m = head.substring(magicAt).match(/^%PDF-(\d\.\d)/);
            res.pdfVersion = m ? m[1] : '';
        }

        var tailStart = bytes.length > 2048 ? bytes.length - 2048 : 0;
        var tail = __P___bytesToLatin1(bytes.slice(tailStart));
        res.eofOk = tail.indexOf('%%EOF') >= 0;

        if (!res.magicOk) {
            res.status = 'NOT_PDF';
            res.reason = 'File is named .pdf but the content does not start with the ' +
                '%PDF- header.';
            return res;
        }

        if (!res.eofOk) {
            res.status = 'CORRUPT_PDF';
            res.reason = 'PDF header found but the %%EOF trailer marker is missing - file is truncated.';
            return res;
        }

        res.passed = true;
        res.passedFlag = 'Y';
        res.status = 'PASSED';
        res.reason = 'Valid PDF ' + (res.pdfVersion ? 'v' + res.pdfVersion + ' ' : '') +
            '(' + res.sizeBytes + ' bytes).';
        return res;
    } catch (e) {
        res.status = 'ERROR';
        res.error = String(e && e.message ? e.message : e);
        res.reason = 'File format check failed: ' + res.error;
        return res;
    }
}
