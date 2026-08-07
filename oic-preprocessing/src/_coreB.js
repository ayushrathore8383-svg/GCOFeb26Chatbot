/* ---------- core B: DEFLATE + PDF text extraction (pure JS) ---------- */

var __P___LENS = [3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 15, 17, 19, 23, 27, 31, 35, 43, 51,
    59, 67, 83, 99, 115, 131, 163, 195, 227, 258];
var __P___LEXT = [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4,
    4, 5, 5, 5, 5, 0];
var __P___DISTS = [1, 2, 3, 4, 5, 7, 9, 13, 17, 25, 33, 49, 65, 97, 129, 193, 257, 385,
    513, 769, 1025, 1537, 2049, 3073, 4097, 6145, 8193, 12289, 16385, 24577];
var __P___DEXT = [0, 0, 0, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10,
    10, 11, 11, 12, 12, 13, 13];
var __P___CLCIDX = [16, 17, 18, 0, 8, 7, 9, 6, 10, 5, 11, 4, 12, 3, 13, 2, 14, 1, 15];

function __P___buildHuff(lengths, n) {
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
function __P___inflate(bytes, start, end) {
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
                len = __P___LENS[sym] + bits(__P___LEXT[sym]);
                sym = decode(dc);
                if (sym >= 30) {
                    throw new Error('invalid distance code');
                }
                dist = __P___DISTS[sym] + bits(__P___DEXT[sym]);
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
        fixedL = __P___buildHuff(lengths, 288);
        var dl = [];
        for (i = 0; i < 30; i++) { dl[i] = 5; }
        fixedD = __P___buildHuff(dl, 30);
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
                lengths[__P___CLCIDX[i]] = bits(3);
            }
            var lencode = __P___buildHuff(lengths, 19);
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
            codes(__P___buildHuff(litLens, nlen), __P___buildHuff(distLens, ndist));
        } else {
            throw new Error('invalid block type');
        }
    } while (!last);

    return out;
}

/* LZWDecode. Used by PDF 1.1 and other pre-1.2 producers, which cannot use
   FlateDecode at all: Flate was only introduced in PDF 1.2. */
function __P___lzwDecode(bytes, start, end, earlyChange) {
    var out = [];
    var dict = [];
    var dictLen = 0;
    var i;

    function reset() {
        dict = [];
        for (i = 0; i < 256; i++) { dict[i] = [i]; }
        dict[256] = null;
        dict[257] = null;
        dictLen = 258;
    }
    reset();

    var codeWidth = 9;
    var bitbuf = 0;
    var bitcnt = 0;
    var pos = start;
    var prev = null;
    var guard = 0;

    while (guard++ < 4000000) {
        while (bitcnt < codeWidth) {
            if (pos >= end) { return out; }
            bitbuf = (bitbuf << 8) | bytes[pos++];
            bitcnt += 8;
        }
        var code = (bitbuf >> (bitcnt - codeWidth)) & ((1 << codeWidth) - 1);
        bitcnt -= codeWidth;

        if (code === 256) {
            reset();
            codeWidth = 9;
            prev = null;
            continue;
        }
        if (code === 257) { return out; }

        var entry;
        if (code < dictLen && dict[code]) {
            entry = dict[code];
        } else if (prev) {
            entry = prev.concat([prev[0]]);
        } else {
            return out;
        }

        for (i = 0; i < entry.length; i++) { out.push(entry[i]); }

        if (prev) {
            dict[dictLen++] = prev.concat([entry[0]]);
        }
        prev = entry;

        var next = dictLen + (earlyChange ? 1 : 0);
        if (next >= 2048) { codeWidth = 12; }
        else if (next >= 1024) { codeWidth = 11; }
        else if (next >= 512) { codeWidth = 10; }
        else { codeWidth = 9; }
    }
    return out;
}

function __P___ascii85Decode(bytes, start, end) {
    var out = [];
    var tuple = [];
    var i;
    var v;
    for (var p = start; p < end; p++) {
        var c = bytes[p];
        if (c === 0x7E) { break; }                 /* ~> end marker */
        if (c === 0x20 || c === 0x0A || c === 0x0D || c === 0x09 || c === 0x00) { continue; }
        if (c === 0x7A && tuple.length === 0) {    /* z == four zero bytes */
            out.push(0, 0, 0, 0);
            continue;
        }
        if (c < 33 || c > 117) { continue; }
        tuple.push(c - 33);
        if (tuple.length === 5) {
            v = 0;
            for (i = 0; i < 5; i++) { v = v * 85 + tuple[i]; }
            out.push((v >>> 24) & 255, (v >>> 16) & 255, (v >>> 8) & 255, v & 255);
            tuple = [];
        }
    }
    if (tuple.length > 1) {
        var n = tuple.length;
        for (i = n; i < 5; i++) { tuple.push(84); }
        v = 0;
        for (i = 0; i < 5; i++) { v = v * 85 + tuple[i]; }
        var quad = [(v >>> 24) & 255, (v >>> 16) & 255, (v >>> 8) & 255, v & 255];
        for (i = 0; i < n - 1; i++) { out.push(quad[i]); }
    }
    return out;
}

function __P___asciiHexDecode(bytes, start, end) {
    var out = [];
    var hi = -1;
    for (var p = start; p < end; p++) {
        var c = bytes[p];
        if (c === 0x3E) { break; }                 /* > end marker */
        var d = -1;
        if (c >= 48 && c <= 57) { d = c - 48; }
        else if (c >= 65 && c <= 70) { d = c - 55; }
        else if (c >= 97 && c <= 102) { d = c - 87; }
        else { continue; }
        if (hi < 0) { hi = d; } else { out.push((hi << 4) | d); hi = -1; }
    }
    if (hi >= 0) { out.push(hi << 4); }
    return out;
}

function __P___runLengthDecode(bytes, start, end) {
    var out = [];
    var p = start;
    while (p < end) {
        var len = bytes[p++];
        if (len === 128) { break; }
        if (len < 128) {
            for (var i = 0; i <= len && p < end; i++) { out.push(bytes[p++]); }
        } else {
            if (p >= end) { break; }
            var b = bytes[p++];
            for (var j = 0; j < 257 - len; j++) { out.push(b); }
        }
    }
    return out;
}

/* Undo a PNG predictor (/Predictor 10-15). Rare on content streams, common on
   cross-reference and object streams. */
function __P___applyPredictor(data, parms) {
    if (!parms || parms.predictor < 10) { return data; }
    var colors = parms.colors || 1;
    var bpc = parms.bpc || 8;
    var columns = parms.columns || 1;
    var bpp = Math.ceil(colors * bpc / 8);
    var rowLen = Math.ceil(colors * bpc * columns / 8);
    if (rowLen <= 0) { return data; }

    var out = [];
    var prevRow = [];
    var i;
    for (i = 0; i < rowLen; i++) { prevRow[i] = 0; }

    var pos = 0;
    while (pos < data.length) {
        var ft = data[pos++];
        var row = data.slice(pos, pos + rowLen);
        if (row.length === 0) { break; }
        pos += row.length;
        for (i = 0; i < row.length; i++) {
            var a = i >= bpp ? row[i - bpp] : 0;
            var b = prevRow[i] || 0;
            var c = i >= bpp ? (prevRow[i - bpp] || 0) : 0;
            var x = row[i];
            var v;
            if (ft === 1) { v = x + a; }
            else if (ft === 2) { v = x + b; }
            else if (ft === 3) { v = x + ((a + b) >> 1); }
            else if (ft === 4) {
                var pp = a + b - c;
                var pa = Math.abs(pp - a);
                var pb = Math.abs(pp - b);
                var pc = Math.abs(pp - c);
                v = x + (pa <= pb && pa <= pc ? a : (pb <= pc ? b : c));
            } else { v = x; }
            row[i] = v & 255;
        }
        for (i = 0; i < row.length; i++) { out.push(row[i]); }
        prevRow = row;
    }
    return out;
}

/* "/Filter /LZWDecode" or "/Filter [/ASCII85Decode /LZWDecode]" -> ordered names. */
function __P___parseFilters(dict) {
    var arr = dict.match(/\/Filter\s*\[([^\]]*)\]/);
    var names = [];
    var m;
    var re = /\/([A-Za-z0-9]+)/g;
    if (arr) {
        while ((m = re.exec(arr[1])) !== null) { names.push(m[1]); }
        return names;
    }
    var single = dict.match(/\/Filter\s*\/([A-Za-z0-9]+)/);
    if (single) { names.push(single[1]); }
    return names;
}

function __P___parseDecodeParms(dict) {
    var p = { predictor: 1, colors: 1, bpc: 8, columns: 1, earlyChange: 1 };
    var m = dict.match(/\/Predictor\s+(\d+)/);
    if (m) { p.predictor = parseInt(m[1], 10); }
    m = dict.match(/\/Colors\s+(\d+)/);
    if (m) { p.colors = parseInt(m[1], 10); }
    m = dict.match(/\/BitsPerComponent\s+(\d+)/);
    if (m) { p.bpc = parseInt(m[1], 10); }
    m = dict.match(/\/Columns\s+(\d+)/);
    if (m) { p.columns = parseInt(m[1], 10); }
    m = dict.match(/\/EarlyChange\s+(\d+)/);
    if (m) { p.earlyChange = parseInt(m[1], 10); }
    return p;
}

var __P___IMAGE_FILTERS = {
    DCTDecode: 1, JPXDecode: 1, CCITTFaxDecode: 1, JBIG2Decode: 1
};

/* Run a stream through its whole filter chain.
   Returns { bytes, ok, unsupported } - unsupported names the filter that stopped it. */
function __P___decodeStream(bytes, start, end, dict) {
    var filters = __P___parseFilters(dict);
    var parms = __P___parseDecodeParms(dict);
    var data = null;
    var i;

    if (filters.length === 0) {
        data = bytes.slice(start, end);
        return { bytes: data, ok: true, unsupported: '' };
    }

    var curStart = start;
    var curEnd = end;
    var src = bytes;

    for (i = 0; i < filters.length; i++) {
        var f = filters[i];
        if (__P___IMAGE_FILTERS[f]) {
            return { bytes: [], ok: false, unsupported: f };
        }
        try {
            if (f === 'FlateDecode' || f === 'Fl') {
                data = __P___inflate(src, curStart, curEnd);
            } else if (f === 'LZWDecode' || f === 'LZW') {
                data = __P___lzwDecode(src, curStart, curEnd, parms.earlyChange);
            } else if (f === 'ASCII85Decode' || f === 'A85') {
                data = __P___ascii85Decode(src, curStart, curEnd);
            } else if (f === 'ASCIIHexDecode' || f === 'AHx') {
                data = __P___asciiHexDecode(src, curStart, curEnd);
            } else if (f === 'RunLengthDecode' || f === 'RL') {
                data = __P___runLengthDecode(src, curStart, curEnd);
            } else if (f === 'Crypt') {
                return { bytes: [], ok: false, unsupported: f };
            } else {
                return { bytes: [], ok: false, unsupported: f };
            }
        } catch (e) {
            return { bytes: [], ok: false, unsupported: f + ' (' +
                String(e && e.message ? e.message : e) + ')' };
        }
        if (f === 'FlateDecode' || f === 'Fl' || f === 'LZWDecode' || f === 'LZW') {
            data = __P___applyPredictor(data, parms);
        }
        src = data;
        curStart = 0;
        curEnd = data.length;
    }
    return { bytes: data || [], ok: true, unsupported: '' };
}

/* Does this decoded stream carry text-drawing operators? All text sits inside
   BT/ET, but accept the show-text operators directly too. */
function __P___hasTextOps(s) {
    return s.indexOf('BT') >= 0 || s.indexOf('Tj') >= 0 || s.indexOf('TJ') >= 0;
}

/* Turn one decoded content stream into plain text. */
function __P___contentText(c) {
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

function __P___normalise(t) {
    return String(t)
        .replace(/\u0000/g, '')
        .replace(/[\r\f\u000b]/g, '\n')
        .replace(/[ \t\u00a0]+/g, ' ')
        .replace(/ *\n+ */g, '\n')
        .replace(/^\n+|\n+$/g, '');
}

/* Walk every stream in the PDF, decode what can be decoded, and pull the text out.
   Returns the text plus enough diagnostics to tell an image-only scan apart from a
   text PDF this code failed to read - those two need completely different fixes. */
function __P___extractTextEx(bytes) {
    var s = __P___bytesToLatin1(bytes);
    var chunks = [];
    var idx = 0;
    var guard = 0;

    var diag = {
        streamsFound: 0,
        streamsDecoded: 0,
        streamsWithText: 0,
        imageStreams: 0,
        filtersSeen: {},
        filtersFailed: {}
    };

    function note(bag, name) {
        if (!name) { return; }
        bag[name] = (bag[name] || 0) + 1;
    }

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

        diag.streamsFound++;

        var filters = __P___parseFilters(dict);
        for (var fi = 0; fi < filters.length; fi++) { note(diag.filtersSeen, filters[fi]); }

        /* Image XObjects hold no text. Count them: a PDF that is nothing but image
           streams is a genuine scan. */
        var isImage = dict.indexOf('/Subtype') >= 0 && dict.indexOf('/Image') >= 0;
        for (var ii = 0; ii < filters.length; ii++) {
            if (__P___IMAGE_FILTERS[filters[ii]]) { isImage = true; }
        }
        if (isImage) {
            diag.imageStreams++;
            continue;
        }

        var decoded = __P___decodeStream(bytes, dataStart, dataEnd, dict);
        if (!decoded.ok) {
            note(diag.filtersFailed, decoded.unsupported);
            continue;
        }
        diag.streamsDecoded++;

        var ds = __P___bytesToLatin1(decoded.bytes);
        if (__P___hasTextOps(ds)) {
            diag.streamsWithText++;
            chunks.push(__P___contentText(ds));
        }
    }

    return { text: __P___normalise(chunks.join('\n')), diag: diag };
}

/* Extract all text-layer text from a PDF held as a byte array. */
function __P___extractText(bytes) {
    return __P___extractTextEx(bytes).text;
}

function __P___keysOf(bag) {
    var out = [];
    for (var k in bag) {
        if (bag.hasOwnProperty(k)) { out.push(k + '(' + bag[k] + ')'); }
    }
    return out.join(', ');
}

/* Plain-English account of why there is no text, without asserting a cause the
   code cannot actually observe. */
function __P___noTextReason(diag) {
    if (diag.streamsFound === 0) {
        return 'no streams found in the PDF';
    }
    if (diag.streamsDecoded === 0 && diag.imageStreams > 0 &&
            __P___keysOf(diag.filtersFailed) === '') {
        return 'image-only PDF: ' + diag.imageStreams +
            ' image stream(s) and no readable content streams, so this is a scan';
    }
    if (__P___keysOf(diag.filtersFailed) !== '') {
        return 'stream(s) could not be decoded - unsupported or failing filter: ' +
            __P___keysOf(diag.filtersFailed) +
            '. This is a limitation of the extractor, not necessarily a scan';
    }
    if (diag.streamsWithText === 0) {
        return diag.streamsDecoded + ' stream(s) decoded but none contained text ' +
            'operators; ' + diag.imageStreams + ' image stream(s) present';
    }
    return 'text operators were found but produced no readable characters, which ' +
        'usually means a custom font encoding with no usable mapping';
}

/* Whitespace-free lowercase form, for keyword matching on PDFs that split glyphs. */
function __P___compact(t) {
    return String(t).toLowerCase().replace(/\s+/g, '');
}

/* Parse "1,234.56" / "1.234,56" / "(120.00)" / "-45" into a number, or null. */
function __P___parseAmount(raw) {
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

/* Resolve text from either a caller-supplied override or the PDF bytes.
   Returns { text, reason } where reason explains an empty text result. */
function __P___resolveText(base64Content, textOverride) {
    if (textOverride !== null && textOverride !== undefined && String(textOverride).length > 0) {
        return { text: __P___normalise(String(textOverride)), reason: '' };
    }
    var ex = __P___extractTextEx(__P___b64ToBytes(base64Content));
    return {
        text: ex.text,
        reason: ex.text.length > 20 ? '' : __P___noTextReason(ex.diag)
    };
}

/* Exposed so OIC can extract once and pass the text into the later checks.
   The diagnostic fields are what tell you whether a document with no text is a
   real scan or a PDF this extractor could not read. */
function __P__extractPdfText(base64Content) {
    var res = {
        text: '',
        textLength: 0,
        hasTextLayer: false,
        streamsFound: 0,
        streamsDecoded: 0,
        streamsWithText: 0,
        imageStreams: 0,
        filtersSeen: '',
        filtersFailed: '',
        noTextReason: '',
        error: ''
    };
    try {
        var ex = __P___extractTextEx(__P___b64ToBytes(base64Content));
        res.text = ex.text;
        res.textLength = ex.text.length;
        res.hasTextLayer = res.textLength > 20;
        res.streamsFound = ex.diag.streamsFound;
        res.streamsDecoded = ex.diag.streamsDecoded;
        res.streamsWithText = ex.diag.streamsWithText;
        res.imageStreams = ex.diag.imageStreams;
        res.filtersSeen = __P___keysOf(ex.diag.filtersSeen);
        res.filtersFailed = __P___keysOf(ex.diag.filtersFailed);
        if (!res.hasTextLayer) { res.noTextReason = __P___noTextReason(ex.diag); }
    } catch (e) {
        res.error = String(e && e.message ? e.message : e);
    }
    return res;
}
