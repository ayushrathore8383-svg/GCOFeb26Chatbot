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


def build_pdf(pages, compress=True, encrypt=False):
    """pages: list of list-of-strings. Returns PDF bytes."""
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
        if compress:
            data = zlib.compress(raw, 9)
            filt = " /Filter /FlateDecode"
        else:
            data = raw
            filt = ""
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

    out = bytearray(b"%PDF-1.5\n%\xe2\xe3\xcf\xd3\n")
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
