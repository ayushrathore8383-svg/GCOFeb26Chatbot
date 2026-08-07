"""Split an Oracle Integration (OIC) project archive (.car) into per-integration .iar files.

A .car is a plain zip with one folder per artifact type. The ``integrations`` folder holds
exploded .iar contents, so conversion is a repackaging job: locate each integration root and
re-zip everything beneath it, preserving the internal layout byte for byte.
"""

from __future__ import annotations

import json
import posixpath
import re
import zipfile
from dataclasses import dataclass, field
from pathlib import Path
from typing import Iterable, Sequence

# Files/dirs that mark the root of an exploded integration inside a CAR.
ICS_DESCRIPTOR = "ics.json"
PROJECT_DESCRIPTOR = "PROJECT-INF/project.xml"
PACKAGE_MARKER = "icspackage/project/"
INTEGRATIONS_DIR = "integrations"

DETERMINISTIC_TIME = (1980, 1, 1, 0, 0, 0)

_CODE_KEYS = ("code", "integrationCode", "identifier", "id", "name")
_VERSION_KEYS = ("version", "integrationVersion", "projectVersion")
_UNSAFE = re.compile(r"[^A-Za-z0-9._-]+")


class CarError(Exception):
    """Raised when a CAR cannot be read or contains no integrations."""


@dataclass
class Integration:
    """One integration found inside a CAR."""

    root: str
    """Zip prefix of the exploded integration, ``""`` when the CAR itself is one integration."""

    entries: list[str] = field(default_factory=list)
    code: str | None = None
    version: str | None = None
    embedded_iar: str | None = None
    """Set when the CAR ships a ready-made .iar rather than an exploded folder."""

    @property
    def folder_name(self) -> str:
        return posixpath.basename(self.root) or "integration"

    @property
    def label(self) -> str:
        return self.embedded_iar or (self.root or "<archive root>")

    def filename(self) -> str:
        """Output file name, preferring the code/version recorded in ``ics.json``."""
        if self.embedded_iar:
            return _safe_name(posixpath.basename(self.embedded_iar)) + ".iar"
        if self.code:
            stem = self.code
            if self.version and self.version not in stem:
                stem = f"{stem}_{self.version}"
        else:
            stem = self.folder_name
        return _safe_name(stem) + ".iar"


def _safe_name(value: str) -> str:
    cleaned = _UNSAFE.sub("_", value.strip()).strip("._-")
    if cleaned.lower().endswith(".iar"):
        cleaned = cleaned[:-4]
    return cleaned or "integration"


def _norm(name: str) -> str:
    return name.replace("\\", "/")


def _is_traversal(name: str) -> bool:
    return name.startswith("/") or ".." in name.split("/")


def list_entries(car_path: Path | str) -> list[str]:
    """Every entry name in the CAR, normalised to forward slashes."""
    with _open_car(car_path) as zf:
        return [_norm(i.filename) for i in zf.infolist()]


def find_integrations(car_path: Path | str) -> list[Integration]:
    """Locate every integration in the CAR, exploded folders and embedded .iar files alike."""
    with _open_car(car_path) as zf:
        return _find(zf)


def convert(
    car_path: Path | str,
    out_dir: Path | str,
    *,
    deterministic: bool = False,
    overwrite: bool = False,
    only: Sequence[str] | None = None,
) -> list[Path]:
    """Write one .iar per integration into ``out_dir`` and return the paths written."""
    out = Path(out_dir)
    out.mkdir(parents=True, exist_ok=True)
    written: list[Path] = []

    with _open_car(car_path) as zf:
        integrations = _find(zf)
        if not integrations:
            raise CarError(f"no integrations found in {car_path}")
        if only:
            wanted = {o.lower() for o in only}
            integrations = [
                i
                for i in integrations
                if i.folder_name.lower() in wanted or i.filename().lower() in wanted
            ]
            if not integrations:
                raise CarError(f"none of the requested integrations matched: {', '.join(only)}")

        used: dict[str, int] = {}
        for integration in integrations:
            name = _dedupe(integration.filename(), used)
            target = out / name
            if target.exists() and not overwrite:
                raise CarError(f"{target} already exists (pass overwrite to replace)")
            _write_iar(zf, integration, target, deterministic)
            written.append(target)

    return written


def _dedupe(name: str, used: dict[str, int]) -> str:
    seen = used.get(name, 0)
    used[name] = seen + 1
    if seen == 0:
        return name
    return f"{name[:-4]}_{seen + 1}.iar"


def _open_car(car_path: Path | str) -> zipfile.ZipFile:
    path = Path(car_path)
    if not path.is_file():
        raise CarError(f"not a file: {path}")
    try:
        return zipfile.ZipFile(path)
    except zipfile.BadZipFile as exc:
        raise CarError(f"{path} is not a readable zip archive: {exc}") from exc


def _find(zf: zipfile.ZipFile) -> list[Integration]:
    names = [_norm(i.filename) for i in zf.infolist()]
    files = [n for n in names if not n.endswith("/") and not _is_traversal(n)]

    embedded = sorted(n for n in files if n.lower().endswith(".iar"))
    roots = _detect_roots(files) or _roots_from_integrations_dir(files)
    roots = _drop_nested(roots)

    found: list[Integration] = [
        Integration(root="", entries=[], embedded_iar=name) for name in embedded
    ]
    for root in sorted(roots):
        entries = _entries_under(files, root)
        entries = [e for e in entries if not e.lower().endswith(".iar")]
        if not entries:
            continue
        code, version = _read_descriptor(zf, root)
        found.append(Integration(root=root, entries=entries, code=code, version=version))
    return found


def _detect_roots(files: Iterable[str]) -> set[str]:
    roots: set[str] = set()
    for name in files:
        if posixpath.basename(name) == ICS_DESCRIPTOR:
            roots.add(posixpath.dirname(name))
        elif name.endswith(PROJECT_DESCRIPTOR):
            roots.add(name[: -len(PROJECT_DESCRIPTOR)].rstrip("/"))
        else:
            marker = name.find(PACKAGE_MARKER)
            if marker >= 0:
                roots.add(name[:marker].rstrip("/"))
    return roots


def _roots_from_integrations_dir(files: Iterable[str]) -> set[str]:
    """Fallback: treat each child folder of an ``integrations`` directory as an integration."""
    roots: set[str] = set()
    for name in files:
        parts = name.split("/")
        for idx, part in enumerate(parts[:-2]):
            if part.lower() == INTEGRATIONS_DIR:
                roots.add("/".join(parts[: idx + 2]))
                break
    return roots


def _drop_nested(roots: set[str]) -> set[str]:
    """Keep only the shallowest root of any nested pair, so one integration is emitted once."""
    kept: list[str] = []
    for root in sorted(roots, key=lambda r: (r.count("/"), r)):
        if any(root == k or root.startswith(k + "/") for k in kept):
            continue
        if "" in kept:
            continue
        kept.append(root)
    return set(kept)


def _entries_under(files: Iterable[str], root: str) -> list[str]:
    if root == "":
        return list(files)
    prefix = root + "/"
    return [n for n in files if n.startswith(prefix)]


def _read_descriptor(zf: zipfile.ZipFile, root: str) -> tuple[str | None, str | None]:
    """Pull integration code and version out of ics.json when it is present and parseable."""
    path = posixpath.join(root, ICS_DESCRIPTOR) if root else ICS_DESCRIPTOR
    try:
        raw = zf.read(path)
    except KeyError:
        return None, None
    try:
        data = json.loads(raw.decode("utf-8-sig"))
    except (UnicodeDecodeError, json.JSONDecodeError):
        return None, None
    if not isinstance(data, dict):
        return None, None

    scopes = [data]
    for key in ("integration", "metadata", "info"):
        nested = data.get(key)
        if isinstance(nested, dict):
            scopes.append(nested)

    code = _first_string(scopes, _CODE_KEYS)
    version = _first_string(scopes, _VERSION_KEYS)
    return code, version


def _first_string(scopes: Sequence[dict], keys: Sequence[str]) -> str | None:
    for scope in scopes:
        for key in keys:
            value = scope.get(key)
            if isinstance(value, str) and value.strip():
                return value.strip()
    return None


def _write_iar(
    zf: zipfile.ZipFile,
    integration: Integration,
    target: Path,
    deterministic: bool,
) -> None:
    if integration.embedded_iar is not None:
        target.write_bytes(zf.read(integration.embedded_iar))
        return

    prefix = integration.root + "/" if integration.root else ""
    with zipfile.ZipFile(target, "w", zipfile.ZIP_DEFLATED) as out:
        for info in zf.infolist():
            name = _norm(info.filename)
            if _is_traversal(name) or not name.startswith(prefix):
                continue
            rel = name[len(prefix) :]
            if not rel or rel.lower().endswith(".iar"):
                continue
            copied = zipfile.ZipInfo(rel)
            copied.date_time = DETERMINISTIC_TIME if deterministic else info.date_time
            copied.external_attr = info.external_attr
            copied.create_system = info.create_system
            if name.endswith("/"):
                copied.compress_type = zipfile.ZIP_STORED
                out.writestr(copied, b"")
            else:
                copied.compress_type = zipfile.ZIP_DEFLATED
                out.writestr(copied, zf.read(info))
