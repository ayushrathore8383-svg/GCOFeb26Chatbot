"""Local drag-and-drop page for car2iar. Binds to localhost and makes no outbound calls."""

from __future__ import annotations

import io
import tempfile
import zipfile
from pathlib import Path

from flask import Flask, Response, render_template_string, request

from .core import CarError, _safe_name, convert, find_integrations

MAX_UPLOAD_BYTES = 512 * 1024 * 1024

PAGE = """<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>car2iar</title>
<style>
  :root { color-scheme: light dark; }
  body { font-family: system-ui, sans-serif; max-width: 46rem; margin: 3rem auto; padding: 0 1rem; }
  h1 { font-size: 1.4rem; margin-bottom: .25rem; }
  p.sub { color: #666; margin-top: 0; }
  label.drop { display: block; border: 2px dashed #999; border-radius: 8px; padding: 2.5rem 1rem;
               text-align: center; cursor: pointer; }
  label.drop.over { border-color: #2b7; background: rgba(34,187,119,.08); }
  .row { margin-top: 1rem; display: flex; gap: .75rem; align-items: center; flex-wrap: wrap; }
  button { padding: .5rem 1rem; font-size: 1rem; cursor: pointer; }
  .err { color: #c33; }
  ul { line-height: 1.6; }
  code { background: rgba(127,127,127,.15); padding: .1rem .3rem; border-radius: 3px; }
</style>
</head>
<body>
<h1>car2iar</h1>
<p class="sub">Drop an OIC project archive (.car). Get one .iar per integration. Nothing leaves this machine.</p>

{% if error %}<p class="err">{{ error }}</p>{% endif %}

<form method="post" enctype="multipart/form-data">
  <label class="drop" id="drop">
    <span id="label">Click or drop a .car file here</span>
    <input type="file" name="car" accept=".car,.zip" id="file" hidden required>
  </label>
  <div class="row">
    <button type="submit" name="action" value="convert">Convert to .iar</button>
    <button type="submit" name="action" value="inspect">Inspect only</button>
    <label><input type="checkbox" name="deterministic" value="1"> deterministic timestamps</label>
  </div>
</form>

{% if listing %}
<h2>{{ listing|length }} integration(s) detected</h2>
<ul>
  {% for item in listing %}<li><code>{{ item.name }}</code> &larr; {{ item.source }}</li>{% endfor %}
</ul>
{% endif %}

<script>
  const drop = document.getElementById('drop');
  const file = document.getElementById('file');
  const label = document.getElementById('label');
  file.addEventListener('change', () => { if (file.files[0]) label.textContent = file.files[0].name; });
  ['dragenter', 'dragover'].forEach(e => drop.addEventListener(e, ev => {
    ev.preventDefault(); drop.classList.add('over');
  }));
  ['dragleave', 'drop'].forEach(e => drop.addEventListener(e, ev => {
    ev.preventDefault(); drop.classList.remove('over');
  }));
  drop.addEventListener('drop', ev => {
    file.files = ev.dataTransfer.files;
    if (file.files[0]) label.textContent = file.files[0].name;
  });
</script>
</body>
</html>
"""


def create_app() -> Flask:
    app = Flask(__name__)
    app.config["MAX_CONTENT_LENGTH"] = MAX_UPLOAD_BYTES

    @app.route("/", methods=["GET", "POST"])
    def index():
        if request.method == "GET":
            return render_template_string(PAGE, error=None, listing=None)

        upload = request.files.get("car")
        if upload is None or not upload.filename:
            return render_template_string(PAGE, error="Choose a .car file first.", listing=None)

        with tempfile.TemporaryDirectory() as tmp:
            car_path = Path(tmp) / "upload.car"
            upload.save(car_path)

            try:
                if request.form.get("action") == "inspect":
                    listing = [
                        {"name": i.filename(), "source": i.label} for i in find_integrations(car_path)
                    ]
                    error = None if listing else "No integrations detected in this archive."
                    return render_template_string(PAGE, error=error, listing=listing)

                out_dir = Path(tmp) / "out"
                written = convert(
                    car_path,
                    out_dir,
                    deterministic=bool(request.form.get("deterministic")),
                    overwrite=True,
                )
            except CarError as exc:
                return render_template_string(PAGE, error=str(exc), listing=None)

            bundle = io.BytesIO()
            with zipfile.ZipFile(bundle, "w", zipfile.ZIP_STORED) as zf:
                for path in written:
                    zf.write(path, path.name)
            payload = bundle.getvalue()

        stem = _safe_name(Path(upload.filename).stem or "project")
        return Response(
            payload,
            mimetype="application/zip",
            headers={"Content-Disposition": f'attachment; filename="{stem}_iars.zip"'},
        )

    return app


def serve(host: str = "127.0.0.1", port: int = 5000) -> None:
    print(f"car2iar UI on http://{host}:{port}  (Ctrl+C to stop)")
    create_app().run(host=host, port=port, debug=False)
