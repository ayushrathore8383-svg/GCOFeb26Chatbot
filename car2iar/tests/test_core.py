from __future__ import annotations

import json
import zipfile
from pathlib import Path

import pytest

from car2iar.core import CarError, convert, find_integrations, list_entries

from .conftest import integration_files, make_car


def names_in(iar: Path) -> set[str]:
    with zipfile.ZipFile(iar) as zf:
        return {n for n in zf.namelist() if not n.endswith("/")}


def test_detects_every_integration(sample_car: Path):
    found = find_integrations(sample_car)
    assert {i.filename() for i in found} == {"ORDER_SYNC_01.00.0000.iar", "INVOICE_PUSH_01.00.0000.iar"}


def test_convert_writes_one_iar_per_integration(sample_car: Path, tmp_path: Path):
    written = convert(sample_car, tmp_path / "out")
    assert sorted(p.name for p in written) == [
        "INVOICE_PUSH_01.00.0000.iar",
        "ORDER_SYNC_01.00.0000.iar",
    ]


def test_iar_contents_are_rooted_at_the_integration(sample_car: Path, tmp_path: Path):
    written = convert(sample_car, tmp_path / "out")
    order = next(p for p in written if p.name.startswith("ORDER_SYNC"))
    assert names_in(order) == {
        "ics.json",
        "PROJECT-INF/project.xml",
        "icspackage/project/ORDER_SYNC_01.00.0000/ORDER_SYNC.xml",
        "icspackage/project/ORDER_SYNC_01.00.0000/resources/req.xsd",
        "pom.xml",
    }


def test_project_level_artifacts_are_excluded(sample_car: Path, tmp_path: Path):
    written = convert(sample_car, tmp_path / "out")
    for iar in written:
        assert not any(n.startswith(("connections/", "lookups/", "libraries/")) for n in names_in(iar))


def test_file_bytes_survive_the_round_trip(sample_car: Path, tmp_path: Path):
    written = convert(sample_car, tmp_path / "out")
    order = next(p for p in written if p.name.startswith("ORDER_SYNC"))
    with zipfile.ZipFile(order) as zf:
        assert json.loads(zf.read("ics.json"))["code"] == "ORDER_SYNC"


def test_falls_back_to_folder_names_without_a_descriptor(tmp_path: Path):
    car = make_car(
        tmp_path / "nodesc.car",
        {
            "integrations/LEGACY_FLOW/icspackage/project/LEGACY_FLOW/flow.xml": "<x/>",
            "integrations/LEGACY_FLOW/pom.xml": "<project/>",
        },
    )
    assert [i.filename() for i in find_integrations(car)] == ["LEGACY_FLOW.iar"]


def test_flat_integrations_dir_without_markers(tmp_path: Path):
    car = make_car(
        tmp_path / "flat.car",
        {
            "integrations/FLOW_A/manifest.txt": "a",
            "integrations/FLOW_B/manifest.txt": "b",
        },
    )
    assert sorted(i.filename() for i in find_integrations(car)) == ["FLOW_A.iar", "FLOW_B.iar"]


def test_embedded_iar_files_are_copied_verbatim(tmp_path: Path):
    inner = tmp_path / "inner.iar"
    make_car(inner, {"ics.json": json.dumps({"code": "PRE_BUILT"})})
    car = make_car(
        tmp_path / "embedded.car",
        {"integrations/PRE_BUILT.iar": inner.read_bytes(), "project.json": "{}"},
    )
    written = convert(car, tmp_path / "out")
    assert [p.name for p in written] == ["PRE_BUILT.iar"]
    assert written[0].read_bytes() == inner.read_bytes()


def test_car_that_is_itself_one_integration(tmp_path: Path):
    entries = {k.split("/", 1)[1]: v for k, v in integration_files("root", "SOLO").items()}
    car = make_car(tmp_path / "solo.car", entries)
    written = convert(car, tmp_path / "out")
    assert [p.name for p in written] == ["SOLO_01.00.0000.iar"]
    assert "ics.json" in names_in(written[0])


def test_nested_roots_collapse_to_one_integration(tmp_path: Path):
    """ics.json and PROJECT-INF both mark the same root; it must not be emitted twice."""
    car = make_car(tmp_path / "nested.car", integration_files("integrations/DUP", "DUP"))
    assert len(find_integrations(car)) == 1


def test_duplicate_names_get_a_suffix(tmp_path: Path):
    entries = {}
    entries.update(integration_files("envA/integrations/SAME", "SAME"))
    entries.update(integration_files("envB/integrations/SAME", "SAME"))
    car = make_car(tmp_path / "dupes.car", entries)
    written = convert(car, tmp_path / "out")
    assert sorted(p.name for p in written) == ["SAME_01.00.0000.iar", "SAME_01.00.0000_2.iar"]


def test_only_filter_selects_a_single_integration(sample_car: Path, tmp_path: Path):
    written = convert(sample_car, tmp_path / "out", only=["ORDER_SYNC_01.00.0000"])
    assert [p.name for p in written] == ["ORDER_SYNC_01.00.0000.iar"]


def test_only_filter_rejects_unknown_names(sample_car: Path, tmp_path: Path):
    with pytest.raises(CarError, match="none of the requested"):
        convert(sample_car, tmp_path / "out", only=["NOPE"])


def test_existing_output_is_protected_unless_overwrite(sample_car: Path, tmp_path: Path):
    out = tmp_path / "out"
    convert(sample_car, out)
    with pytest.raises(CarError, match="already exists"):
        convert(sample_car, out)
    convert(sample_car, out, overwrite=True)


def test_deterministic_mode_is_byte_stable(sample_car: Path, tmp_path: Path):
    first = convert(sample_car, tmp_path / "a", deterministic=True)
    second = convert(sample_car, tmp_path / "b", deterministic=True)
    assert [p.read_bytes() for p in sorted(first)] == [p.read_bytes() for p in sorted(second)]


def test_traversal_entries_are_dropped(tmp_path: Path):
    entries = dict(integration_files("integrations/SAFE", "SAFE"))
    car = tmp_path / "evil.car"
    with zipfile.ZipFile(car, "w") as zf:
        for name, content in entries.items():
            zf.writestr(name, content)
        zf.writestr("integrations/SAFE/../../escape.txt", "nope")
    written = convert(car, tmp_path / "out")
    assert all(".." not in n for n in names_in(written[0]))


def test_empty_archive_reports_no_integrations(tmp_path: Path):
    car = make_car(tmp_path / "empty.car", {"project.json": "{}"})
    assert find_integrations(car) == []
    with pytest.raises(CarError, match="no integrations found"):
        convert(car, tmp_path / "out")


def test_non_zip_input_is_rejected(tmp_path: Path):
    bogus = tmp_path / "bogus.car"
    bogus.write_text("not a zip")
    with pytest.raises(CarError, match="not a readable zip"):
        find_integrations(bogus)


def test_missing_file_is_rejected(tmp_path: Path):
    with pytest.raises(CarError, match="not a file"):
        find_integrations(tmp_path / "ghost.car")


def test_list_entries_normalises_separators(tmp_path: Path):
    car = tmp_path / "win.car"
    with zipfile.ZipFile(car, "w") as zf:
        zf.writestr("integrations\\WIN\\ics.json", json.dumps({"code": "WIN"}))
    assert list_entries(car) == ["integrations/WIN/ics.json"]
    assert [i.filename() for i in find_integrations(car)] == ["WIN.iar"]
