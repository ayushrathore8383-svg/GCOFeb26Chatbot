"""Command line entry point for car2iar."""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

from .core import CarError, convert, find_integrations, list_entries


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        prog="car2iar",
        description="Split an OIC project archive (.car) into one .iar per integration. Runs offline.",
    )
    sub = parser.add_subparsers(dest="command", required=True)

    conv = sub.add_parser("convert", help="write one .iar per integration")
    conv.add_argument("car", type=Path, help="path to the .car file")
    conv.add_argument(
        "-o", "--out", type=Path, default=Path("iar_out"), help="output directory (default: iar_out)"
    )
    conv.add_argument("--overwrite", action="store_true", help="replace existing .iar files")
    conv.add_argument(
        "--deterministic",
        action="store_true",
        help="zero all timestamps so repeated runs produce identical bytes",
    )
    conv.add_argument(
        "--only",
        action="append",
        metavar="NAME",
        help="convert just this integration (folder or output name); repeatable",
    )

    insp = sub.add_parser("inspect", help="show the CAR tree and the integrations detected")
    insp.add_argument("car", type=Path, help="path to the .car file")
    insp.add_argument("--tree", action="store_true", help="also list every entry in the archive")

    web = sub.add_parser("web", help="serve the local drag-and-drop page")
    web.add_argument("--host", default="127.0.0.1", help="bind address (default: 127.0.0.1)")
    web.add_argument("--port", type=int, default=5000, help="port (default: 5000)")

    return parser


def main(argv: list[str] | None = None) -> int:
    args = build_parser().parse_args(argv)
    try:
        if args.command == "convert":
            return _convert(args)
        if args.command == "inspect":
            return _inspect(args)
        if args.command == "web":
            return _web(args)
    except CarError as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 1
    return 2


def _convert(args: argparse.Namespace) -> int:
    written = convert(
        args.car,
        args.out,
        deterministic=args.deterministic,
        overwrite=args.overwrite,
        only=args.only,
    )
    for path in written:
        print(path)
    print(f"\n{len(written)} .iar file(s) written to {args.out}", file=sys.stderr)
    return 0


def _inspect(args: argparse.Namespace) -> int:
    integrations = find_integrations(args.car)
    if args.tree:
        print("Archive entries:")
        for entry in list_entries(args.car):
            print(f"  {entry}")
        print()

    if not integrations:
        print("No integrations detected. Re-run with --tree and share the output so detection")
        print("can be tuned to this archive layout.")
        return 1

    print(f"{len(integrations)} integration(s) detected:")
    for integration in integrations:
        kind = "embedded .iar" if integration.embedded_iar else f"{len(integration.entries)} entries"
        print(f"  {integration.filename():<50} <- {integration.label}  ({kind})")
        if integration.code:
            version = integration.version or "?"
            print(f"      code={integration.code} version={version}")
    return 0


def _web(args: argparse.Namespace) -> int:
    try:
        from .web import serve
    except ImportError:
        print("error: the web UI needs Flask. Install it with: pip install flask", file=sys.stderr)
        return 1
    serve(host=args.host, port=args.port)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
