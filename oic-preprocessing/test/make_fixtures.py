#!/usr/bin/env python3
"""Build small PDF fixtures (FlateDecode content streams) for the OIC validators.

    python3 make_fixtures.py

Writes .pdf files into test/fixtures/. No third-party dependencies.
"""
import os
import zlib

OUT = os.path.join(os.path.dirname(os.path.abspath(__file__)), "fixtures")


def escape(s):
    return s.replace("\\", r"\\").replace("(", r"\(").replace(")", r"\)")


def content_stream(lines):
    parts = ["BT", "/F1 10 Tf", "50 780 Td", "14 TL"]
    for line in lines:
        parts.append("(%s) Tj" % escape(line))
        parts.append("0 -14 Td")
    parts.append("ET")
    return "\n".join(parts).encode("latin-1")


def lzw_encode(data, early=1):
    """PDF LZWDecode encoder. Width growth mirrors the decoder in _coreB.js exactly."""
    bits = []

    def emit(code, width):
        for i in range(width - 1, -1, -1):
            bits.append((code >> i) & 1)

    def width_for(decoder_dict_len):
        # The encoder's dictionary runs exactly one entry ahead of the decoder's,
        # because the decoder only adds an entry once it has read the FOLLOWING
        # code. Code width must be chosen from the decoder's count, not our own,
        # or the two disagree for one code at each width boundary.
        nxt = decoder_dict_len + early
        if nxt >= 2048:
            return 12
        if nxt >= 1024:
            return 11
        if nxt >= 512:
            return 10
        return 9

    dic = {bytes([i]): i for i in range(256)}
    nxt = 258
    width = 9
    emit(256, width)
    w = b""
    for ch in data:
        c = bytes([ch])
        if w + c in dic:
            w = w + c
            continue
        emit(dic[w], width)
        dic[w + c] = nxt
        nxt += 1
        if nxt + early >= 4096:
            emit(256, width)
            dic = {bytes([i]): i for i in range(256)}
            nxt = 258
            width = 9
        else:
            width = width_for(nxt - 1)
        w = c
    if w:
        emit(dic[w], width)
    emit(257, width)

    while len(bits) % 8:
        bits.append(0)
    out = bytearray()
    for i in range(0, len(bits), 8):
        byte = 0
        for j in range(8):
            byte = (byte << 1) | bits[i + j]
        out.append(byte)
    return bytes(out)


def ascii85_encode(data):
    out = []
    for i in range(0, len(data), 4):
        block = data[i:i + 4]
        pad = 4 - len(block)
        block = block + b"\x00" * pad
        v = int.from_bytes(block, "big")
        chars = []
        for _ in range(5):
            chars.append(v % 85)
            v //= 85
        chars.reverse()
        enc = "".join(chr(c + 33) for c in chars)
        out.append(enc[: 5 - pad] if pad else enc)
    return ("".join(out) + "~>").encode("latin-1")


def apply_filter(raw, mode):
    """Returns (data, filter_entry)."""
    if mode == "none":
        return raw, ""
    if mode == "flate":
        return zlib.compress(raw, 9), " /Filter /FlateDecode"
    if mode == "lzw":
        return lzw_encode(raw), " /Filter /LZWDecode"
    if mode == "a85lzw":
        return ascii85_encode(lzw_encode(raw)), " /Filter [/ASCII85Decode /LZWDecode]"
    if mode == "rle":
        # run-length: emit every byte as a literal run, which is valid if inefficient
        out = bytearray()
        for i in range(0, len(raw), 128):
            chunk = raw[i:i + 128]
            out.append(len(chunk) - 1)
            out += chunk
        out.append(128)
        return bytes(out), " /Filter /RunLengthDecode"
    raise ValueError(mode)


def build_image_only_pdf():
    """A page whose only content draws an image. No text operators anywhere:
    this is what a real scan looks like to the extractor."""
    jpeg = b"\xff\xd8\xff\xe0" + b"\x00" * 400 + b"\xff\xd9"
    content = b"q 595 0 0 842 0 0 cm /Im0 Do Q"
    objects = {
        1: b"<< /Type /Catalog /Pages 2 0 R >>",
        2: b"<< /Type /Pages /Kids [3 0 R] /Count 1 >>",
        3: (b"<< /Type /Page /Parent 2 0 R /MediaBox [0 0 595 842] "
            b"/Resources << /XObject << /Im0 5 0 R >> >> /Contents 4 0 R >>"),
        4: ("<< /Length %d >>\nstream\n" % len(content)).encode() + content + b"\nendstream",
        5: (("<< /Type /XObject /Subtype /Image /Width 1700 /Height 2400 "
             "/ColorSpace /DeviceGray /BitsPerComponent 8 /Filter /DCTDecode "
             "/Length %d >>\nstream\n" % len(jpeg)).encode() + jpeg + b"\nendstream"),
    }
    out = bytearray(b"%PDF-1.4\n%\xe2\xe3\xcf\xd3\n")
    offsets = {}
    for num in sorted(objects):
        offsets[num] = len(out)
        out += ("%d 0 obj\n" % num).encode() + objects[num] + b"\nendobj\n"
    xref_pos = len(out)
    out += ("xref\n0 %d\n" % (max(objects) + 1)).encode()
    out += b"0000000000 65535 f \n"
    for num in range(1, max(objects) + 1):
        out += ("%010d 00000 n \n" % offsets[num]).encode()
    out += ("trailer\n<< /Size %d /Root 1 0 R >>\nstartxref\n%d\n%%%%EOF\n"
            % (max(objects) + 1, xref_pos)).encode()
    return bytes(out)


def build_pdf(pages, compress=True, encrypt=False, filter_mode=None, version="1.5"):
    """pages: list of list-of-strings. Returns PDF bytes."""
    if filter_mode is None:
        filter_mode = "flate" if compress else "none"
    objects = {}
    n_pages = len(pages)
    font_obj = 3 + 2 * n_pages
    kids = " ".join("%d 0 R" % (3 + 2 * i) for i in range(n_pages))

    objects[1] = b"<< /Type /Catalog /Pages 2 0 R >>"
    objects[2] = ("<< /Type /Pages /Kids [%s] /Count %d >>" % (kids, n_pages)).encode()

    for i, lines in enumerate(pages):
        page_obj = 3 + 2 * i
        cont_obj = page_obj + 1
        objects[page_obj] = (
            "<< /Type /Page /Parent 2 0 R /MediaBox [0 0 595 842] "
            "/Resources << /Font << /F1 %d 0 R >> >> /Contents %d 0 R >>"
            % (font_obj, cont_obj)
        ).encode()
        raw = content_stream(lines)
        data, filt = apply_filter(raw, filter_mode)
        objects[cont_obj] = (
            ("<< /Length %d%s >>\nstream\n" % (len(data), filt)).encode()
            + data
            + b"\nendstream"
        )

    objects[font_obj] = (
        b"<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica /Encoding /WinAnsiEncoding >>"
    )

    enc_obj = font_obj + 1
    if encrypt:
        objects[enc_obj] = (
            b"<< /Filter /Standard /V 2 /R 3 /Length 128 /P -3904 "
            b"/O <0102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F20> "
            b"/U <202122232425262728292A2B2C2D2E2F303132333435363738393A3B3C3D3E3F40> >>"
        )

    out = bytearray(("%%PDF-%s\n" % version).encode() + b"%\xe2\xe3\xcf\xd3\n")
    offsets = {}
    for num in sorted(objects):
        offsets[num] = len(out)
        out += ("%d 0 obj\n" % num).encode() + objects[num] + b"\nendobj\n"

    xref_pos = len(out)
    max_obj = max(objects) + 1
    out += ("xref\n0 %d\n" % max_obj).encode()
    out += b"0000000000 65535 f \n"
    for num in range(1, max_obj):
        if num in offsets:
            out += ("%010d 00000 n \n" % offsets[num]).encode()
        else:
            out += b"0000000000 65535 f \n"
    trailer = "<< /Size %d /Root 1 0 R" % max_obj
    if encrypt:
        trailer += " /Encrypt %d 0 R /ID [<AABB> <AABB>]" % enc_obj
    trailer += " >>"
    out += ("trailer\n%s\nstartxref\n%d\n%%%%EOF\n" % (trailer, xref_pos)).encode()
    return bytes(out)


INVOICE = [
    "ACME SUPPLIES LTD",
    "Unit 4, Trade Park, Manchester M1 2AB",
    "VAT Registration No: GB 123 4567 89",
    "",
    "TAX INVOICE",
    "Invoice Number: INV-2026-00841",
    "Invoice Date: 12/01/2026",
    "Purchase Order No: PO-778812",
    "",
    "Bill To: Global Care Operations Ltd",
    "",
    "Description            Qty      Unit Price      Amount",
    "Consumables pack        10           45.00      450.00",
    "Delivery                 1           25.00       25.00",
    "",
    "Sub Total                                       475.00",
    "VAT @ 20%                                        95.00",
    "Gross Total                                     570.00",
    "Amount Due                                      570.00",
    "Payment Terms: 30 days",
    "Page 1 of 1",
]

ZERO_INVOICE = [
    "ACME SUPPLIES LTD",
    "TAX INVOICE",
    "Invoice Number: INV-2026-00999",
    "Invoice Date: 14/01/2026",
    "Purchase Order No: PO-778813",
    "Bill To: Global Care Operations Ltd",
    "Goodwill replacement - no charge",
    "Sub Total                                         0.00",
    "VAT @ 20%                                         0.00",
    "Gross Total                                       0.00",
    "Amount Due                                        0.00",
]

PHARMACY_INVOICE = [
    "MEDIDOSE PHARMA DISTRIBUTION",
    "TAX INVOICE",
    "Invoice Number: INV-2026-01204",
    "Invoice Date: 20/01/2026",
    "Purchase Order Number: PH-4471200",
    "Bill To: Global Care Operations Ltd",
    "Dispensing items                              1,204.55",
    "Gross Total                                   1,445.46",
    "Amount Due                                    1,445.46",
]

STATEMENT = [
    "ACME SUPPLIES LTD",
    "STATEMENT OF ACCOUNT",
    "Statement Date: 31/01/2026",
    "Account: GCO-0042",
    "Opening Balance                               2,410.00",
    "Invoices in period                            5,600.00",
    "Payments received                            -4,000.00",
    "Current Balance                               4,010.00",
]

DELIVERY_NOTE = [
    "ACME SUPPLIES LTD",
    "DELIVERY NOTE",
    "Despatch Date: 18/01/2026",
    "Deliver To: Global Care Operations Ltd",
    "Purchase Order No: PO-778812",
    "Consumables pack                    10 units",
    "Goods Received Note to be signed on delivery",
]

MULTI_A = [
    "ACME SUPPLIES LTD",
    "TAX INVOICE",
    "Invoice Number: INV-2026-00841",
    "Invoice Date: 12/01/2026",
    "Gross Total                                     570.00",
    "Page 1 of 1",
]
MULTI_B = [
    "ACME SUPPLIES LTD",
    "TAX INVOICE",
    "Invoice Number: INV-2026-00842",
    "Invoice Date: 13/01/2026",
    "Gross Total                                     930.00",
    "Page 1 of 1",
]

LONG_INVOICE_PAGE_2 = [
    "ACME SUPPLIES LTD - continued",
    "Invoice Number: INV-2026-00841",
    "Further line items",
    "Gross Total                                     570.00",
    "Page 2 of 2",
]


def write(name, data):
    path = os.path.join(OUT, name)
    with open(path, "wb") as fh:
        fh.write(data)
    print("%-34s %6d bytes" % (name, len(data)))


def main():
    os.makedirs(OUT, exist_ok=True)

    write("valid_invoice.pdf", build_pdf([INVOICE]))
    write("valid_invoice_uncompressed.pdf", build_pdf([INVOICE], compress=False))
    write("zero_value_invoice.pdf", build_pdf([ZERO_INVOICE]))
    write("pharmacy_invoice.pdf", build_pdf([PHARMACY_INVOICE]))
    write("statement.pdf", build_pdf([STATEMENT]))
    write("delivery_note.pdf", build_pdf([DELIVERY_NOTE]))
    write("multi_invoice.pdf", build_pdf([MULTI_A, MULTI_B]))
    write("two_page_single_invoice.pdf", build_pdf([INVOICE, LONG_INVOICE_PAGE_2]))
    write("encrypted_invoice.pdf", build_pdf([INVOICE], encrypt=True))

    # PDF 1.1 producers cannot use FlateDecode - Flate arrived in PDF 1.2
    write("lzw_invoice_v11.pdf",
          build_pdf([INVOICE], filter_mode="lzw", version="1.1"))
    write("a85_lzw_invoice.pdf",
          build_pdf([INVOICE], filter_mode="a85lzw", version="1.2"))
    write("runlength_invoice.pdf",
          build_pdf([INVOICE], filter_mode="rle", version="1.2"))
    write("scanned_image_only.pdf", build_image_only_pdf())

    # a PDF with no text layer at all (page with no content text)
    write("scanned_no_text.pdf", build_pdf([[]]))

    # not a PDF
    write("not_a_pdf.docx", b"PK\x03\x04this is definitely not a pdf" * 20)

    # truncated PDF: valid header, no %%EOF
    good = build_pdf([INVOICE])
    write("truncated.pdf", good[: len(good) // 2])

    write("empty.pdf", b"")


if __name__ == "__main__":
    main()
