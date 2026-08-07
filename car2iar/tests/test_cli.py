from __future__ import annotations

from pathlib import Path

import pytest

from car2iar.cli import main


def test_convert_command_writes_files(sample_car: Path, tmp_path: Path, capsys):
    code = main(["convert", str(sample_car), "-o", str(tmp_path / "out")])
    assert code == 0
    assert len(list((tmp_path / "out").glob("*.iar"))) == 2


def test_inspect_command_lists_integrations(sample_car: Path, capsys):
    assert main(["inspect", str(sample_car)]) == 0
    out = capsys.readouterr().out
    assert "2 integration(s) detected" in out
    assert "ORDER_SYNC_01.00.0000.iar" in out


def test_inspect_tree_dumps_every_entry(sample_car: Path, capsys):
    main(["inspect", str(sample_car), "--tree"])
    out = capsys.readouterr().out
    assert "lookups/COUNTRY_MAP.csv" in out


def test_inspect_reports_when_nothing_detected(tmp_path: Path, capsys):
    import zipfile

    car = tmp_path / "empty.car"
    with zipfile.ZipFile(car, "w") as zf:
        zf.writestr("project.json", "{}")
    assert main(["inspect", str(car)]) == 1
    assert "No integrations detected" in capsys.readouterr().out


def test_errors_exit_non_zero(tmp_path: Path, capsys):
    assert main(["convert", str(tmp_path / "ghost.car")]) == 1
    assert "error:" in capsys.readouterr().err


def test_missing_subcommand_is_a_usage_error(capsys):
    with pytest.raises(SystemExit):
        main([])
