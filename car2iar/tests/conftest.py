from __future__ import annotations

import json
import zipfile
from pathlib import Path

import pytest


def make_car(path: Path, entries: dict[str, bytes | str]) -> Path:
    """Build a zip at ``path`` from a name -> content mapping. A trailing / makes a directory."""
    with zipfile.ZipFile(path, "w", zipfile.ZIP_DEFLATED) as zf:
        for name, content in entries.items():
            data = content.encode() if isinstance(content, str) else content
            zf.writestr(name, data)
    return path


def integration_files(root: str, code: str, version: str = "01.00.0000") -> dict[str, str]:
    """The file set OIC writes for one exploded integration inside a CAR."""
    descriptor = json.dumps({"code": code, "version": version, "name": code.title()})
    return {
        f"{root}/ics.json": descriptor,
        f"{root}/PROJECT-INF/project.xml": f"<project name='{code}'/>",
        f"{root}/icspackage/project/{code}_{version}/{code}.xml": "<integration/>",
        f"{root}/icspackage/project/{code}_{version}/resources/req.xsd": "<schema/>",
        f"{root}/pom.xml": "<project/>",
    }


@pytest.fixture
def sample_car(tmp_path: Path) -> Path:
    entries: dict[str, bytes | str] = {
        "project.json": json.dumps({"name": "DemoProject"}),
        "connections/ERP_REST.json": "{}",
        "lookups/COUNTRY_MAP.csv": "IN,India\n",
        "libraries/helpers.js": "function noop() {}\n",
    }
    entries.update(integration_files("integrations/ORDER_SYNC_01.00.0000", "ORDER_SYNC"))
    entries.update(integration_files("integrations/INVOICE_PUSH_01.00.0000", "INVOICE_PUSH"))
    return make_car(tmp_path / "demo.car", entries)
