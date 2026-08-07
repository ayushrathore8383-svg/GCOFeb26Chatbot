from __future__ import annotations

import io
import zipfile
from pathlib import Path

import pytest

flask = pytest.importorskip("flask")

from car2iar.web import create_app


@pytest.fixture
def client():
    app = create_app()
    app.config["TESTING"] = True
    return app.test_client()


def test_get_renders_the_upload_page(client):
    response = client.get("/")
    assert response.status_code == 200
    assert b"car2iar" in response.data


def test_convert_returns_a_zip_of_iars(client, sample_car: Path):
    response = client.post(
        "/",
        data={"car": (io.BytesIO(sample_car.read_bytes()), "demo.car"), "action": "convert"},
        content_type="multipart/form-data",
    )
    assert response.status_code == 200
    assert response.mimetype == "application/zip"
    with zipfile.ZipFile(io.BytesIO(response.data)) as zf:
        assert sorted(zf.namelist()) == [
            "INVOICE_PUSH_01.00.0000.iar",
            "ORDER_SYNC_01.00.0000.iar",
        ]


def test_inspect_lists_integrations_in_html(client, sample_car: Path):
    response = client.post(
        "/",
        data={"car": (io.BytesIO(sample_car.read_bytes()), "demo.car"), "action": "inspect"},
        content_type="multipart/form-data",
    )
    assert b"2 integration(s) detected" in response.data
    assert b"ORDER_SYNC_01.00.0000.iar" in response.data


def test_missing_upload_shows_an_error(client):
    response = client.post("/", data={"action": "convert"}, content_type="multipart/form-data")
    assert b"Choose a .car file first." in response.data


def test_bad_archive_shows_an_error(client):
    response = client.post(
        "/",
        data={"car": (io.BytesIO(b"not a zip"), "junk.car"), "action": "convert"},
        content_type="multipart/form-data",
    )
    assert b"not a readable zip archive" in response.data
