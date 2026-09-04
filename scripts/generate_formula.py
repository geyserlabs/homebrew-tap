#!/usr/bin/env python3
"""Generate the checksum-pinned Geyser formula from one release."""

from __future__ import annotations

import argparse
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
FORMULA = ROOT / "Formula" / "geyser.rb"
VERSION = re.compile(r"^[0-9]+\.[0-9]+\.[0-9]+(?:b[0-9]+)?$")
DIGEST = re.compile(r"^[0-9a-f]{64}$")


def render(version: str, darwin: str, linux: str) -> str:
    if not VERSION.fullmatch(version):
        raise ValueError("version must be a release version such as 0.1.0b1")
    if not all(DIGEST.fullmatch(value) for value in (darwin, linux)):
        raise ValueError("artifact hashes must be lowercase SHA-256 digests")
    base = f"https://github.com/geyserlabs/geyser-open/releases/download/v{version}"
    return f'''class Geyser < Formula
  desc "Framework-neutral CLI for governed durable Geyser agents"
  homepage "https://geyserlabs.ai/developers"
  license "MIT"

  on_macos do
    url "{base}/geyser-open-{version}-darwin-arm64.tar.gz"
    sha256 "{darwin}"
  end

  on_linux do
    url "{base}/geyser-open-{version}-linux-amd64.tar.gz"
    sha256 "{linux}"
  end

  def install
    odie "Geyser Open supports Apple-Silicon macOS only" if OS.mac? && !Hardware::CPU.arm?
    odie "Geyser Open supports AMD64 Linux only" if OS.linux? && !Hardware::CPU.intel?
    bin.install "geyser"
  end

  test do
    assert_match '"geyser_open":"{version}"', shell_output("#{{bin}}/geyser --json version")
  end
end
'''


def validate_existing() -> None:
    if not FORMULA.is_file():
        return
    content = FORMULA.read_text(encoding="utf-8")
    for sentinel in (
        "github.com/geyserlabs/geyser-open/releases/download/",
        'on_macos do', 'on_linux do', 'sha256 "', 'bin.install "geyser"',
    ):
        if sentinel not in content:
            raise ValueError(f"formula is missing {sentinel!r}")


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--version")
    parser.add_argument("--darwin-sha256")
    parser.add_argument("--linux-sha256")
    parser.add_argument("--output", type=Path, default=FORMULA)
    parser.add_argument("--validate-if-present", action="store_true")
    args = parser.parse_args()
    try:
        if args.validate_if_present:
            validate_existing()
            print("formula validation passed" if FORMULA.exists() else "formula not published yet")
            return 0
        values = (args.version, args.darwin_sha256, args.linux_sha256)
        if any(value is None for value in values):
            parser.error("version and both platform hashes are required")
        args.output.write_text(render(*values), encoding="utf-8")  # type: ignore[arg-type]
        validate_existing()
        print(f"wrote {args.output}")
    except (OSError, ValueError) as exc:
        raise SystemExit(f"formula generation failed: {exc}") from exc
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
