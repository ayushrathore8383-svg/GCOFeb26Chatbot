/*
 * Oracle Integration Cloud - AP invoice pre-processing.
 * Deployable JavaScript library: validateZeroValue.js
 *
 * Generated from oic-preprocessing/src by build.js - edit the sources, not this file.
 * Pure ECMAScript 5. No JAR, no require(), no browser or Node APIs.
 */

/* ---------- core A: base64 + byte helpers (no dependencies) ---------- */

function zv_b64ToBytes(b64) {
    var chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
    var lookup = {};
    var i;
    for (i = 0; i < chars.length; i++) {
        lookup[chars.charAt(i)] = i;
    }
    var clean = String(b64 === null || b64 === undefined ? '' : b64).replace(/[^A-Za-z0-9+\/]/g, '');
    var len = clean.length;
    var bytes = [];
    var buf = 0;
    var bits = 0;
    for (i = 0; i < len; i++) {
        buf = (buf << 6) | lookup[clean.charAt(i)];
        bits += 6;
        if (bits >= 8) {
            bits -= 8;
            bytes.push((buf >> bits) & 0xFF);
        }
    }
    return bytes;
}

function zv_bytesToLatin1(bytes) {
    var parts = [];
    var chunk = [];
    var i;
    for (i = 0; i < bytes.length; i++) {
        chunk.push(String.fromCharCode(bytes[i] & 0xFF));
        if (chunk.length === 8192) {
            parts.push(chunk.join(''));
            chunk = [];
        }
    }
    parts.push(chunk.join(''));
    return parts.join('');
}

function zv_isPdf(bytes) {
    var head = zv_bytesToLatin1(bytes.slice(0, 1024));
    return head.indexOf('%PDF-') >= 0;
}

/* ---------- core B: DEFLATE + PDF text extraction (pure JS) ---------- */

var zv_LENS = [3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31, 35, 43, 51,
    59, 67, 83, 99, 115, 131, 163, 195, 227, 258];
var zv_LEXT = [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4,
    4, 5, 5, 5, 5, 0];
var zv_DISTS = [1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193, 257, 385,
    513, 769, 1025, 1537, 2049, 3073, 4097, 6145, 8193, 12289, 16385, 24577];
var zv_DEXT = [0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10,
    10, 11, 11, 12, 12, 13, 13];
var zv_CLCIDX = [16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15];

function zv_buildHuff(lengths, n) {
    var counts = [];
    var offs = [];
    var symbols = [];
    var i;
    for (i = 0; i < 16; i++) {
        counts[i] = 0;
        offs[i] = 0;
    }
    for (i = 0; i < n; i++) {
        counts[lengths[i]]++;
    }
    counts[0] = 0;
    offs[1] = 0;
    for (i = 1; i < 15; i++) {
        offs[i + 1] = offs[i] + counts[i];
    }
    for (i = 0; i < n; i++) {
        if (lengths[i]) {
            symbols[offs[lengths[i]]++] = i;
        }
    }
    return { counts: counts, symbols: symbols };
}

/* Raw DEFLATE / zlib inflate over bytes[start .. end). Returns array of bytes. */
function zv_inflate(bytes, start, end) {
    var pos = start;
    var bitbuf = 0;
    var bitcnt = 0;
    var out = [];

    if (end - start > 2) {
        var cmf = bytes[start];
        var flg = bytes[start + 1];
        if ((cmf & 0x0F) === 8 && (((cmf << 8) + flg) % 31) === 0) {
            pos = start + 2;
        }
    }

    function bits(n) {
        var v;
        while (bitcnt < n) {
            if (pos >= end) {
                throw new Error('unexpected end of deflate stream');
            }
            bitbuf |= bytes[pos++] << bitcnt;
            bitcnt += 8;
        }
        v = bitbuf & ((1 << n) - 1);
        bitbuf >>>= n;
        bitcnt -= n;
        return v;
    }

    function decode(h) {
        var code = 0;
        var first = 0;
        var index = 0;
        var len;
        var count;
        for (len = 1; len <= 15; len++) {
            code |= bits(1);
            count = h.counts[len];
            if (code - first < count) {
                return h.symbols[index + (code - first)];
            }
            index += count;
            first += count;
            first <<= 1;
            code <<= 1;
        }
        throw new Error('invalid huffman code');
    }

    function codes(lc, dc) {
        var sym;
        var len;
        var dist;
        var from;
        var i;
        for (;;) {
            sym = decode(lc);
            if (sym < 256) {
                out.push(sym);
            } else if (sym === 256) {
                return;
            } else {
                sym -= 257;
                if (sym >= 29) {
                    throw new Error('invalid length code');
                }
                len = zv_LENS[sym] + bits(zv_LEXT[sym]);
                sym = decode(dc);
                if (sym >= 30) {
                    throw new Error('invalid distance code');
                }
                dist = zv_DISTS[sym] + bits(zv_DEXT[sym]);
                from = out.length - dist;
                if (from < 0) {
                    throw new Error('distance before start');
                }
                for (i = 0; i < len; i++) {
                    out.push(out[from + i]);
                }
            }
        }
    }

    var fixedL = null;
    var fixedD = null;
    function buildFixed() {
        var lengths = [];
        var i;
        for (i = 0; i < 144; i++) { lengths[i] = 8; }
        for (i = 144; i < 256; i++) { lengths[i] = 9; }
        for (i = 256; i < 280; i++) { lengths[i] = 7; }
        for (i = 280; i < 288; i++) { lengths[i] = 8; }
        fixedL = zv_buildHuff(lengths, 288);
        var dl = [];
        for (i = 0; i < 30; i++) { dl[i] = 5; }
        fixedD = zv_buildHuff(dl, 30);
    }

    var last;
    var type;
    do {
        last = bits(1);
        type = bits(2);
        if (type === 0) {
            bitbuf = 0;
            bitcnt = 0;
            if (pos + 4 > end) {
                throw new Error('unexpected end of stored block');
            }
            var slen = bytes[pos] | (bytes[pos + 1] << 8);
            pos += 4;
            if (pos + slen > end) {
                throw new Error('stored block overruns stream');
            }
            for (var si = 0; si < slen; si++) {
                out.push(bytes[pos++]);
            }
        } else if (type === 1) {
            if (fixedL === null) {
                buildFixed();
            }
            codes(fixedL, fixedD);
        } else if (type === 2) {
            var nlen = bits(5) + 257;
            var ndist = bits(5) + 1;
            var ncode = bits(4) + 4;
            var lengths = [];
            var i;
            for (i = 0; i < 320; i++) {
                lengths[i] = 0;
            }
            for (i = 0; i < ncode; i++) {
                lengths[zv_CLCIDX[i]] = bits(3);
            }
            var lencode = zv_buildHuff(lengths, 19);
            i = 0;
            while (i < nlen + ndist) {
                var sym = decode(lencode);
                var val;
                var rep;
                if (sym < 16) {
                    lengths[i++] = sym;
                } else {
                    if (sym === 16) {
                        if (i === 0) {
                            throw new Error('no previous length to repeat');
                        }
                        val = lengths[i - 1];
                        rep = 3 + bits(2);
                    } else if (sym === 17) {
                        val = 0;
                        rep = 3 + bits(3);
                    } else {
                        val = 0;
                        rep = 11 + bits(7);
                    }
                    while (rep--) {
                        lengths[i++] = val;
                    }
                }
            }
            var litLens = lengths.slice(0, nlen);
            var distLens = lengths.slice(nlen, nlen + ndist);
            codes(zv_buildHuff(litLens, nlen), zv_buildHuff(distLens, ndist));
        } else {
            throw new Error('invalid block type');
        }
    } while (!last);

    return out;
}

/* Turn one decoded content stream into plain text. */
function zv_contentText(c) {
    var out = [];
    var i = 0;
    var n = c.length;
    var ch;
    while (i < n) {
        ch = c.charAt(i);
        if (ch === '(') {
            var depth = 1;
            var buf = '';
            i++;
            while (i < n && depth > 0) {
                var d = c.charAt(i);
                if (d === '\\') {
                    var e = c.charAt(i + 1);
                    if (e >= '0' && e <= '7') {
                        var oct = '';
                        var k = i + 1;
                        while (k < n && oct.length < 3 && c.charAt(k) >= '0' && c.charAt(k) <= '7') {
                            oct += c.charAt(k);
                            k++;
                        }
                        buf += String.fromCharCode(parseInt(oct, 8));
                        i = k;
                        continue;
                    }
                    if (e === 'n') { buf += '\n'; }
                    else if (e === 'r') { buf += '\n'; }
                    else if (e === 't') { buf += ' '; }
                    else if (e === 'b' || e === 'f') { buf += ' '; }
                    else if (e === '\n' || e === '\r') { /* line continuation */ }
                    else { buf += e; }
                    i += 2;
                    continue;
                }
                if (d === '(') { depth++; buf += d; i++; continue; }
                if (d === ')') { depth--; if (depth > 0) { buf += d; } i++; continue; }
                buf += d;
                i++;
            }
            out.push(buf);
            continue;
        }
        if (ch === '<' && c.charAt(i + 1) !== '<') {
            var endHex = c.indexOf('>', i);
            if (endHex < 0) { break; }
            var hex = c.substring(i + 1, endHex).replace(/[^0-9A-Fa-f]/g, '');
            var hbuf = '';
            for (var j = 0; j + 1 < hex.length; j += 2) {
                hbuf += String.fromCharCode(parseInt(hex.substr(j, 2), 16));
            }
            out.push(hbuf);
            i = endHex + 1;
            continue;
        }
        if (ch === 'T') {
            var nx = c.charAt(i + 1);
            if (nx === 'd' || nx === 'D' || nx === '*') {
                out.push('\n');
                i += 2;
                continue;
            }
        }
        if (ch === 'E' && c.charAt(i + 1) === 'T') {
            out.push('\n');
            i += 2;
            continue;
        }
        i++;
    }
    return out.join('');
}

function zv_normalise(t) {
    return String(t)
        .replace(/\u0000/g, '')
        .replace(/[\r\f\u000b]/g, '\n')
        .replace(/[ \t\u00a0]+/g, ' ')
        .replace(/ *\n+ */g, '\n')
        .replace(/^\n+|\n+$/g, '');
}

/* Extract all text-layer text from a PDF held as a byte array. */
function zv_extractText(bytes) {
    var s = zv_bytesToLatin1(bytes);
    var chunks = [];
    var idx = 0;
    var guard = 0;
    while (guard++ < 20000) {
        var st = s.indexOf('stream', idx);
        if (st < 0) { break; }
        if (s.substring(st - 3, st) === 'end') {
            idx = st + 6;
            continue;
        }
        var dictStart = s.lastIndexOf('<<', st);
        var dict = dictStart >= 0 ? s.substring(dictStart, st) : '';
        var dataStart = st + 6;
        if (s.charAt(dataStart) === '\r') { dataStart++; }
        if (s.charAt(dataStart) === '\n') { dataStart++; }
        var dataEnd = s.indexOf('endstream', dataStart);
        if (dataEnd < 0) { break; }
        idx = dataEnd + 9;

        if (dict.indexOf('/Image') >= 0 || dict.indexOf('/DCTDecode') >= 0 ||
            dict.indexOf('/JPXDecode') >= 0 || dict.indexOf('/CCITTFaxDecode') >= 0 ||
            dict.indexOf('/JBIG2Decode') >= 0) {
            continue;
        }

        if (dict.indexOf('/FlateDecode') < 0) {
            var plain = s.substring(dataStart, dataEnd);
            if (plain.indexOf('Tj') >= 0 || plain.indexOf('TJ') >= 0) {
                chunks.push(zv_contentText(plain));
            }
            continue;
        }

        try {
            var raw = zv_inflate(bytes, dataStart, dataEnd);
            var rs = zv_bytesToLatin1(raw);
            if (rs.indexOf('Tj') >= 0 || rs.indexOf('TJ') >= 0) {
                chunks.push(zv_contentText(rs));
            }
        } catch (e) {
            /* encrypted, damaged, or an unsupported filter chain: skip */
        }
    }
    return zv_normalise(chunks.join('\n'));
}

/* Whitespace-free lowercase form, for keyword matching on PDFs that split glyphs. */
function zv_compact(t) {
    return String(t).toLowerCase().replace(/\s+/g, '');
}

/* Parse "1,234.56" / "1.234,56" / "(120.00)" / "-45" into a number, or null. */
function zv_parseAmount(raw) {
    var s = String(raw).replace(/[^0-9.,()\-]/g, '');
    if (!s) { return null; }
    var neg = (s.indexOf('(') >= 0 && s.indexOf(')') >= 0) || s.indexOf('-') === 0;
    s = s.replace(/[()\-]/g, '');
    if (!s) { return null; }
    var lastDot = s.lastIndexOf('.');
    var lastCom = s.lastIndexOf(',');
    var dec = lastDot > lastCom ? lastDot : lastCom;
    var intPart;
    var fracPart = '';
    var tail = s.length - dec - 1;
    if (dec >= 0 && tail > 0 && tail <= 2) {
        intPart = s.substring(0, dec).replace(/[.,]/g, '');
        fracPart = s.substring(dec + 1);
    } else {
        intPart = s.replace(/[.,]/g, '');
    }
    if (!/^[0-9]*$/.test(intPart) || !/^[0-9]*$/.test(fracPart)) { return null; }
    if (intPart === '' && fracPart === '') { return null; }
    var v = parseFloat((intPart === '' ? '0' : intPart) + '.' + (fracPart === '' ? '0' : fracPart));
    if (isNaN(v)) { return null; }
    return neg ? -v : v;
}

/* Resolve text from either a caller-supplied override or the PDF bytes. */
function zv_resolveText(base64Content, textOverride) {
    if (textOverride !== null && textOverride !== undefined && String(textOverride).length > 0) {
        return zv_normalise(String(textOverride));
    }
    return zv_extractText(zv_b64ToBytes(base64Content));
}

/* Exposed so OIC can extract once and pass the text into the later checks. */
function zv_extractPdfText(base64Content) {
    var res = { text: '', textLength: 0, hasTextLayer: false, error: '' };
    try {
        res.text = zv_extractText(zv_b64ToBytes(base64Content));
        res.textLength = res.text.length;
        res.hasTextLayer = res.textLength > 20;
    } catch (e) {
        res.error = String(e && e.message ? e.message : e);
    }
    return res;
}

/**
 * VALIDATION 3 - Zero-value invoice check.
 *
 * OIC call signature:
 *   validateZeroValue(base64Content, textOverride, zeroToleranceStr)
 *
 * base64Content    - the PDF as base64. Ignored when textOverride is supplied.
 * textOverride     - optional. Text from a previous zv_extractPdfText call, so the
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
        var v = zv_parseAmount(found[i]);
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
        error: ''
    };

    try {
        var tolerance = 0;
        if (zeroToleranceStr !== null && zeroToleranceStr !== undefined &&
            String(zeroToleranceStr).length > 0) {
            var t = parseFloat(zeroToleranceStr);
            if (!isNaN(t)) { tolerance = Math.abs(t); }
        }

        var text = zv_resolveText(base64Content, textOverride);
        res.hasTextLayer = text.length > 20;

        if (!res.hasTextLayer) {
            res.passed = true;
            res.passedFlag = 'Y';
            res.status = 'TOTAL_NOT_FOUND';
            res.reason = 'No text layer found (scanned or image-only PDF) - gross total ' +
                'cannot be read here. Sending to Document Understanding.';
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
