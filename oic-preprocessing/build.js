/*
 * Assembles the six deployable OIC JavaScript library files from src/.
 *
 *   node build.js
 *
 * Each output file is self-contained (OIC libraries cannot import each other).
 * Shared helpers are given a per-file prefix so that all six files can also be
 * uploaded into a single OIC library without name collisions.
 */
var fs = require('fs');
var path = require('path');

var SRC = path.join(__dirname, 'src');
var DIST = path.join(__dirname, 'dist');

var TARGETS = [
    { body: '01-fileFormat.body.js', out: 'validateFileFormat.js', prefix: 'ff', core: ['A'] },
    { body: '02-passwordProtection.body.js', out: 'validatePasswordProtection.js', prefix: 'pp', core: ['A', 'B'] },
    { body: '03-zeroValue.body.js', out: 'validateZeroValue.js', prefix: 'zv', core: ['A', 'B'] },
    { body: '04-documentClassification.body.js', out: 'classifyDocument.js', prefix: 'dc', core: ['A', 'B'] },
    { body: '05-pharmacyInvoice.body.js', out: 'validatePharmacyInvoice.js', prefix: 'ph', core: ['A', 'B'] },
    { body: '06-multiInvoice.body.js', out: 'validateMultiInvoice.js', prefix: 'mi', core: ['A', 'B'] }
];

var coreA = fs.readFileSync(path.join(SRC, '_coreA.js'), 'utf8');
var coreB = fs.readFileSync(path.join(SRC, '_coreB.js'), 'utf8');

if (!fs.existsSync(DIST)) { fs.mkdirSync(DIST); }

TARGETS.forEach(function (t) {
    var body = fs.readFileSync(path.join(SRC, t.body), 'utf8');
    var parts = [
        '/*',
        ' * Oracle Integration Cloud - AP invoice pre-processing.',
        ' * Deployable JavaScript library: ' + t.out,
        ' *',
        ' * Generated from oic-preprocessing/src by build.js - edit the sources, not this file.',
        ' * Pure ECMAScript 5. No JAR, no require(), no browser or Node APIs.',
        ' */',
        ''
    ];
    if (t.core.indexOf('A') >= 0) { parts.push(coreA); }
    if (t.core.indexOf('B') >= 0) { parts.push(coreB); }
    parts.push(body);

    var src = parts.join('\n')
        .replace(/__P___/g, t.prefix + '_')
        .replace(/__P__/g, t.prefix + '_');
    fs.writeFileSync(path.join(DIST, t.out), src);
    console.log(t.out + '  ' + Math.round(src.length / 1024) + ' KB');
});
