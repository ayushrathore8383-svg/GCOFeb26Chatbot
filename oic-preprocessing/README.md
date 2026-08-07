# OIC invoice pre-processing libraries

Six standalone JavaScript libraries that run the pre-DU validation gate inside the OIC
integration. No JAR, no external service, no `require()`. Pure ECMAScript 5, which is
what the OIC JavaScript library runtime accepts.

Upload from `dist/`. Largest file is 24 KB, against the 10 MB library limit.

| # | Upload this file | Call this function | Rejection status |
|---|---|---|---|
| 1 | `validateFileFormat.js` | `validateFileFormat(fileName, base64Content)` | `NOT_PDF`, `EMPTY_FILE`, `CORRUPT_PDF` |
| 2 | `validatePasswordProtection.js` | `validatePasswordProtection(base64Content)` | `PASSWORD_PROTECTED` |
| 3 | `validateZeroValue.js` | `validateZeroValue(base64Content, textOverride, zeroToleranceStr)` | `ZERO_VALUE` |
| 4 | `classifyDocument.js` | `classifyDocument(base64Content, textOverride, invoiceFamilyStr)` | `NOT_INVOICE` |
| 5 | `validatePharmacyInvoice.js` | `validatePharmacyInvoice(base64Content, textOverride, pharmacyPrefixes)` | `PHARMACY_INVOICE` |
| 6 | `validateMultiInvoice.js` | `validateMultiInvoice(base64Content, textOverride)` | `MULTI_INVOICE` |

## Reading the result

Every function returns the same flat shape, so the OIC mapper sees a stable schema on
every path through the code:

```json
{
  "validation": "ZERO_VALUE",
  "passed": false,
  "passedFlag": "N",
  "status": "ZERO_VALUE",
  "reason": "Gross total is 0 (matched on \"GROSS_TOTAL\") - zero-value invoice.",
  "error": ""
}
```

Route on `status`, not on `passed`. `passed` collapses three different outcomes into one
boolean, and the middle one matters:

- `status === "PASSED"` — check ran, document is clean, continue.
- a rejection status — check ran, document fails, send to the APEX rejected queue and
  write `reason` into the queue record.
- `TOTAL_NOT_FOUND`, `UNCLASSIFIED`, `PO_NOT_FOUND`, `UNDETERMINED`, `CONFIG_MISSING` —
  the check could not run. These return `passed: true` so nothing is rejected on missing
  evidence, but they are not clean passes.
- `ERROR` — the library threw. `error` holds the message. Route to your fault handler.

Each function also returns evidence fields for the rejected-queue record: `grossTotal`
and `matchedLabel` on check 3, `documentType` and `confidence` on check 4, `poNumber` on
check 5, `invoiceNumbers` and `pageCount` on check 6.

## Wiring it into the integration

Read the object from Object Storage as base64 once, then chain the six calls.

**Stop the chain on a rejection status or on `ERROR`. Do not stop on a could-not-determine
status.** This distinction matters more than it looks. A statement with no recognisable
total returns `TOTAL_NOT_FOUND` at check 3; halting there skips check 4, which is the one
that identifies it as a statement and rejects it. A multi-invoice PDF with no PO line
returns `PO_NOT_FOUND` at check 5; halting there skips check 6, the check that catches it.
Testing the six checks against the fixture set, treating any non-`PASSED` status as a stop
let three of eleven documents through that should have been rejected.

Checks 3 to 6 all need the PDF text. Parsing it four times wastes the whole call. Each of
those four libraries exposes a text extractor (`zv_extractPdfText`, `dc_extractPdfText`,
`ph_extractPdfText`, `mi_extractPdfText` — same code, different prefix). Call one of them
after check 2, keep `.text` in a variable, and pass it as `textOverride` to checks 3, 4
and 5. Check 6 still needs `base64Content` as well, because it reads the page count from
the PDF object structure rather than the text.

```
fileName ─▶ 1 validateFileFormat(fileName, b64)
              └─ NOT_PDF / EMPTY_FILE / CORRUPT_PDF ─▶ APEX rejected queue
         ─▶ 2 validatePasswordProtection(b64)
              └─ PASSWORD_PROTECTED ─▶ APEX rejected, status "Password Protected"
         ─▶    zv_extractPdfText(b64) ──▶ pdfText
         ─▶ 3 validateZeroValue("", pdfText, "")
              ├─ ZERO_VALUE      ─▶ rejected, no DU call
              └─ TOTAL_NOT_FOUND ─▶ carry on to check 4
         ─▶ 4 classifyDocument("", pdfText, "INVOICE,CREDIT_NOTE")
              ├─ NOT_INVOICE   ─▶ excluded from the APEX processing queue
              └─ UNCLASSIFIED  ─▶ carry on to check 5
         ─▶ 5 validatePharmacyInvoice("", pdfText, "PH,PHM,RX")
              ├─ PHARMACY_INVOICE ─▶ APEX rejected, pharmacy handling
              └─ PO_NOT_FOUND     ─▶ carry on to check 6
         ─▶ 6 validateMultiInvoice(b64, pdfText)
              ├─ MULTI_INVOICE ─▶ rejected, logged to DB, manual AP handling
              └─ UNDETERMINED  ─▶ carry on
         ─▶ DU key-value extraction
```

Passing `""` as `textOverride` makes a function parse the PDF itself, so each library
also works standalone if you would rather not thread the text through.

The six files can go into six separate OIC libraries or all into one. Shared helpers
carry a per-file prefix (`ff_`, `pp_`, `zv_`, `dc_`, `ph_`, `mi_`) specifically so a
single library holding all six does not hit duplicate function names.

## Configuration you must supply

**Check 5 has no default prefix list.** Pass your real pharmacy PO prefixes as
`pharmacyPrefixes`, comma-separated. With an empty value the function returns
`CONFIG_MISSING` and passes everything through — the check silently does nothing. Route
`CONFIG_MISSING` to an alert so a mis-set connectivity property does not go unnoticed.

[EVIDENCE NEEDED: the actual pharmacy PO prefixes used by your AP setup. `PH,PHM,RX` is
placeholder text in the examples, not a researched value.]

Two optional settings:

- `invoiceFamilyStr` on check 4 defaults to `INVOICE,CREDIT_NOTE`. Use `INVOICE` alone to
  exclude credit notes, or add `PROFORMA` to accept pro formas.
- `zeroToleranceStr` on check 3 defaults to `0`, so only an exact zero rejects. Set
  `0.01` if you want sub-penny totals treated as zero.

## What this cannot do

**Scanned invoices have no text layer.** Checks 3, 4, 5 and 6 read the PDF text layer.
A photographed or scanned invoice contains an image and nothing else, so all four return
their could-not-determine status and the document goes to DU unchecked. Only checks 1 and
2 work on every PDF. Pure JavaScript cannot OCR, so if a large share of your intake is
scanned, four of these six checks will not fire on it. Measure that share before relying
on this gate — `hasTextLayer` is returned by every text-based check so you can count it.

**Check 2 cannot tell a user password from an owner password.** An `/Encrypt` dictionary
means the file is encrypted, which the library detects reliably. Deciding whether the
empty password opens it needs RC4 and AES, which is not implemented here. A
permissions-only PDF that Acrobat opens fine is therefore also reported as
`PASSWORD_PROTECTED`. Those files fail in DU as well, so rejecting them is defensible; if
you want them through, gate on the `ownerPasswordLikely` field, which is true when
content streams still decode.

**Checks 3 to 6 are heuristics over extracted text.** Check 3 matches total labels in
priority order, bottom-up. Check 4 scores keyword hits. Check 6 rejects when it finds more
than one distinct invoice number, or more than one "Page 1 of N" marker, so a covering
letter quoting a second invoice number will trip it. Each returns the evidence it matched
so the AP team can see why from the rejected queue.

Text extraction handles `FlateDecode` and uncompressed content streams. Custom-encoded
subset fonts without a WinAnsi-compatible encoding may extract as garbage.

## Testing before you touch OIC

Two runners, both driving the exact files you will upload.

**Browser** — no install needed. Open `tester.html`, drop PDFs on it. It loads the six
`dist/` files with plain `<script>` tags, runs the pipeline in order, and shows each
check's status, reason and raw result object, plus the extracted text layer. Everything
stays on your machine; nothing is uploaded. Use this if Node is not available, or to hand
the check to someone in AP without a toolchain.

**Command line** — for batches and regression runs.

```bash
node test/check.js invoice.pdf --prefixes PH,PHM,RX
node test/check.js invoice.pdf --text              # print the extracted text layer
node test/check.js invoice.pdf --all               # run all six, ignore the stop condition
node test/check.js ./real-invoices --prefixes PH --csv triage.csv
```

Point it at a folder and it processes every PDF inside, prints a summary and writes one
CSV row per file: outcome, all six statuses, `has_text_layer`, `text_chars`, gross total,
document type, PO number, page count and invoice numbers.

Run the folder mode over a representative sample of real intake before you wire any of
this in. The `no text layer (scanned)` count in the summary is the number that decides
whether this gate is worth having: those documents can only be checked by validations 1
and 2, and the CSV shows you the share directly.

To exercise the libraries against something other than a PDF file — a base64 string
straight out of an OIC activity, say — `test/run.js` shows the sandbox pattern: load a
`dist/` file into a bare `vm` context and call the function.

## Working on the code

`dist/` is generated. Edit `src/` and rebuild:

```bash
node build.js          # regenerate dist/
python3 test/make_fixtures.py
node test/run.js       # 55 assertions
```

`src/_coreA.js` holds base64 decoding, `src/_coreB.js` holds the DEFLATE decompressor and
the PDF text extractor, and `src/0*.body.js` holds one validation each. `build.js`
concatenates the core into each body and rewrites the `__P__` placeholder to the
per-file prefix.

The test harness loads each built file into a bare `vm` context with no Node globals, so
an accidental `require`, `Buffer` or `console` fails locally rather than in OIC. Fixtures
are generated as real PDFs with zlib-compressed content streams, which exercises the
DEFLATE path rather than stubbing it.
