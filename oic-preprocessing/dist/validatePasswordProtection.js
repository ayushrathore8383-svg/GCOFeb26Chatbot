/*
 * Oracle Integration Cloud - AP invoice pre-processing.
 * Deployable JavaScript library: validatePasswordProtection.js
 *
 * Generated from oic-preprocessing/src by build.js - edit the sources, not this file.
 * Pure ECMAScript 5. No JAR, no require(), no browser or Node APIs.
 */

/* ---------- core A: base64 + byte helpers (no dependencies) ---------- */

function pp_b64ToBytes(b64) {
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

function pp_bytesToLatin1(bytes) {
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

function pp_isPdf(bytes) {
    var head = pp_bytesToLatin1(bytes.slice(0, 1024));
    return head.indexOf('%PDF-') >= 0;
}

/* ---------- core B: DEFLATE + PDF text extraction (pure JS) ---------- */

var pp_LENS = [3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31, 35, 43, 51,
    59, 67, 83, 99, 115, 131, 163, 195, 227, 258];
var pp_LEXT = [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4,
    4, 5, 5, 5, 5, 0];
var pp_DISTS = [1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193, 257, 385,
    513, 769, 1025, 1537, 2049, 3073, 4097, 6145, 8193, 12289, 16385, 24577];
var pp_DEXT = [0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10,
    10, 11, 11, 12, 12, 13, 13];
var pp_CLCIDX = [16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15];

function pp_buildHuff(lengths, n) {
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
function pp_inflate(bytes, start, end) {
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
                len = pp_LENS[sym] + bits(pp_LEXT[sym]);
                sym = decode(dc);
                if (sym >= 30) {
                    throw new Error('invalid distance code');
                }
                dist = pp_DISTS[sym] + bits(pp_DEXT[sym]);
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
        fixedL = pp_buildHuff(lengths, 288);
        var dl = [];
        for (i = 0; i < 30; i++) { dl[i] = 5; }
        fixedD = pp_buildHuff(dl, 30);
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
                lengths[pp_CLCIDX[i]] = bits(3);
            }
            var lencode = pp_buildHuff(lengths, 19);
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
            codes(pp_buildHuff(litLens, nlen), pp_buildHuff(distLens, ndist));
        } else {
            throw new Error('invalid block type');
        }
    } while (!last);

    return out;
}

/* Turn one decoded content stream into plain text. */
function pp_contentText(c) {
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

function pp_normalise(t) {
    return String(t)
        .replace(/\u0000/g, '')
        .replace(/[\r\f\u000b]/g, '\n')
        .replace(/[ \t\u00a0]+/g, ' ')
        .replace(/ *\n+ */g, '\n')
        .replace(/^\n+|\n+$/g, '');
}

/* Extract all text-layer text from a PDF held as a byte array. */
function pp_extractText(bytes) {
    var s = pp_bytesToLatin1(bytes);
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
                chunks.push(pp_contentText(plain));
            }
            continue;
        }

        try {
            var raw = pp_inflate(bytes, dataStart, dataEnd);
            var rs = pp_bytesToLatin1(raw);
            if (rs.indexOf('Tj') >= 0 || rs.indexOf('TJ') >= 0) {
                chunks.push(pp_contentText(rs));
            }
        } catch (e) {
            /* encrypted, damaged, or an unsupported filter chain: skip */
        }
    }
    return pp_normalise(chunks.join('\n'));
}

/* Whitespace-free lowercase form, for keyword matching on PDFs that split glyphs. */
function pp_compact(t) {
    return String(t).toLowerCase().replace(/\s+/g, '');
}

/* Parse "1,234.56" / "1.234,56" / "(120.00)" / "-45" into a number, or null. */
function pp_parseAmount(raw) {
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
function pp_resolveText(base64Content, textOverride) {
    if (textOverride !== null && textOverride !== undefined && String(textOverride).length > 0) {
        return pp_normalise(String(textOverride));
    }
    return pp_extractText(pp_b64ToBytes(base64Content));
}

/* Exposed so OIC can extract once and pass the text into the later checks. */
function pp_extractPdfText(base64Content) {
    var res = { text: '', textLength: 0, hasTextLayer: false, error: '' };
    try {
        res.text = pp_extractText(pp_b64ToBytes(base64Content));
        res.textLength = res.text.length;
        res.hasTextLayer = res.textLength > 20;
    } catch (e) {
        res.error = String(e && e.message ? e.message : e);
    }
    return res;
}

/**
 * VALIDATION 2 - Password protection detection.
 *
 * OIC call signature:
 *   validatePasswordProtection(base64Content)
 *
 * Reject with APEX status "Password Protected" when status === "PASSWORD_PROTECTED".
 *
 * How it works: an encrypted PDF carries an /Encrypt entry in its trailer. This
 * function finds that entry and reads /V (algorithm version), /R (revision) and
 * /P (permission bitmask) out of the encryption dictionary. It also tries to
 * inflate the content streams: on an encrypted file every stream fails to
 * inflate, which is used as a corroborating signal.
 *
 * Limitation: distinguishing a user-password PDF (cannot be opened at all) from
 * an owner-password PDF (opens freely, only permissions are restricted) requires
 * running RC4/AES against the empty password, which pure JavaScript cannot do
 * here. Both are reported as PASSWORD_PROTECTED. Both also fail in Document
 * Understanding, so rejecting both is the safe default - but see
 * "ownerPasswordLikely" below if you want to let permissions-only files through.
 */
function validatePasswordProtection(base64Content) {
    var res = {
        validation: 'PASSWORD_PROTECTION',
        passed: false,
        passedFlag: 'N',
        status: 'ERROR',
        reason: '',
        encrypted: false,
        encryptVersion: 0,
        encryptRevision: 0,
        permissions: 0,
        cryptFilter: '',
        streamsDecoded: 0,
        ownerPasswordLikely: false,
        error: ''
    };

    try {
        var bytes = pp_b64ToBytes(base64Content);
        if (bytes.length === 0) {
            res.status = 'ERROR';
            res.reason = 'No content supplied.';
            return res;
        }

        var s = pp_bytesToLatin1(bytes);
        var encIdx = s.indexOf('/Encrypt');
        res.encrypted = encIdx >= 0;

        /* Count how many streams inflate cleanly - zero means the body is encrypted. */
        var decoded = 0;
        var idx = 0;
        var guard = 0;
        while (guard++ < 500) {
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
            if (dict.indexOf('/FlateDecode') < 0) { continue; }
            try {
                var out = pp_inflate(bytes, dataStart, dataEnd);
                if (out.length > 0) { decoded++; }
            } catch (ignored) {
                /* encrypted or damaged */
            }
        }
        res.streamsDecoded = decoded;

        if (!res.encrypted) {
            res.passed = true;
            res.passedFlag = 'Y';
            res.status = 'PASSED';
            res.reason = 'No /Encrypt dictionary - document is not password protected.';
            return res;
        }

        /* Read the encryption dictionary values. In the trailer /Encrypt is almost
           always an indirect reference ("/Encrypt 9 0 R") pointing at an object
           earlier in the file, so the reference has to be followed - reading
           forward from /Encrypt alone lands past the end of the document. */
        var window = '';
        var ref = s.substring(encIdx, encIdx + 64).match(/^\/Encrypt\s+(\d+)\s+(\d+)\s+R/);
        if (ref) {
            var objRe = new RegExp('(?:^|[^0-9])' + ref[1] + '\\s+' + ref[2] + '\\s+obj');
            var om = objRe.exec(s);
            if (om) {
                var objStart = om.index + om[0].length;
                window = s.substring(objStart, objStart + 4000);
            }
        }
        if (window === '') {
            /* inline dictionary, or the referenced object could not be located */
            window = s.substring(encIdx, encIdx + 4000);
        }
        var mv = window.match(/\/V\s+(\d+)/);
        var mr = window.match(/\/R\s+(\d+)/);
        var mp = window.match(/\/P\s+(-?\d+)/);
        var mf = window.match(/\/Filter\s*\/([A-Za-z0-9]+)/);
        if (mv) { res.encryptVersion = parseInt(mv[1], 10); }
        if (mr) { res.encryptRevision = parseInt(mr[1], 10); }
        if (mp) { res.permissions = parseInt(mp[1], 10); }
        if (mf) { res.cryptFilter = mf[1]; }

        /* If some streams still inflated, the body is not really encrypted, which
           in practice means an owner-password / permissions-only file. */
        res.ownerPasswordLikely = decoded > 0;

        res.status = 'PASSWORD_PROTECTED';
        res.reason = 'PDF is encrypted (/Encrypt present' +
            (res.cryptFilter ? ', filter ' + res.cryptFilter : '') +
            (res.encryptRevision ? ', R' + res.encryptRevision : '') +
            '). ' + decoded + ' of the content streams could be read.';
        return res;
    } catch (e) {
        res.status = 'ERROR';
        res.error = String(e && e.message ? e.message : e);
        res.reason = 'Password protection check failed: ' + res.error;
        return res;
    }
}
