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
        var bytes = __P___b64ToBytes(base64Content);
        if (bytes.length === 0) {
            res.status = 'ERROR';
            res.reason = 'No content supplied.';
            return res;
        }

        var s = __P___bytesToLatin1(bytes);
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
                var out = __P___inflate(bytes, dataStart, dataEnd);
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
