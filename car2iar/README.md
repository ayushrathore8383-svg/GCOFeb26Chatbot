# car2iar

Splits an Oracle Integration (OIC) project archive (`.car`) into one `.iar` per integration. Runs entirely offline: no OIC instance, no credentials, no network calls.

## Why it works

A `.car` is a plain zip with one folder per artifact type. The `integrations` folder holds **exploded** `.iar` contents, alongside sibling folders for connections, lookups and libraries. Producing an `.iar` is therefore repackaging, not transformation: locate each integration root, re-zip everything beneath it, keep the internal layout unchanged.

Each `.iar` produced contains the integration's own files rooted at the archive top level (`ics.json`, `PROJECT-INF/project.xml`, `icspackage/project/<CODE_VERSION>/…`, `pom.xml`). Project-level artifacts are excluded.

## Install

```bash
cd car2iar
pip install -e .          # CLI only, zero dependencies
pip install -e ".[web]"   # adds Flask for the drag-and-drop page
```

The CLI needs only Python 3.9+ and the standard library. Without installing, run it in place with `python -m car2iar` from this directory.

## Usage

### Inspect first

```bash
car2iar inspect MyProject.car
car2iar inspect MyProject.car --tree    # every entry in the archive
```

Output names each integration it found and the folder it came from. Run this before converting an unfamiliar archive.

### Convert

```bash
car2iar convert MyProject.car -o ./iars
```

| Flag | Effect |
| --- | --- |
| `-o, --out DIR` | Output directory (default `iar_out`) |
| `--only NAME` | Convert one integration; repeat the flag for several |
| `--overwrite` | Replace existing `.iar` files instead of erroring |
| `--deterministic` | Zero all timestamps so repeated runs produce identical bytes |

Output files are named `<CODE>_<VERSION>.iar`, read from `ics.json`. When no descriptor is present the source folder name is used. Colliding names get a `_2`, `_3` suffix rather than overwriting each other.

### Web UI

```bash
car2iar web              # http://127.0.0.1:5000
car2iar web --port 8080
```

Drop a `.car` on the page and get a zip of the `.iar` files back, or press **Inspect only** to list what would be produced. Binds to `127.0.0.1` by default; the upload never leaves the machine. Upload cap is 512 MB.

### As a library

```python
from car2iar import convert, find_integrations

for integration in find_integrations("MyProject.car"):
    print(integration.filename(), "<-", integration.label)

paths = convert("MyProject.car", "./iars", deterministic=True)
```

## How integrations are detected

Detection runs in order and stops at the first rule that matches, so unusual archive layouts still resolve:

1. **Descriptor markers.** A folder containing `ics.json`, `PROJECT-INF/project.xml`, or an `icspackage/project/` subtree is an integration root.
2. **Fallback by path.** With no markers, each direct child folder of a directory named `integrations` is treated as an integration.
3. **Embedded archives.** Any `.iar` already sitting inside the `.car` is copied out byte for byte instead of being rebuilt.

Nested matches collapse to the shallowest root, so an integration matching two markers is emitted once. Entries containing `..` or absolute paths are dropped rather than written.

## Tests

```bash
pip install -e ".[dev]"
python -m pytest
```

31 tests cover detection across archive layouts, content fidelity, name collisions, deterministic output, path-traversal handling, malformed input, and both the CLI and web surfaces. Fixtures build synthetic `.car` files in `tests/conftest.py`.

## Validation status

Detection logic was built against the documented OIC Gen3 CAR layout and is exercised against synthetic archives, not yet against a production export.

[EVIDENCE NEEDED: `car2iar inspect --tree` output from a real OIC project export, to confirm folder naming and `ics.json` key names]

If `inspect` finds nothing or names files oddly on a real archive, the `--tree` output shows exactly what the detection rules have to work with.
