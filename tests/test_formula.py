from __future__ import annotations

import importlib.util
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SPEC = importlib.util.spec_from_file_location("generate_formula", ROOT / "scripts/generate_formula.py")
assert SPEC is not None and SPEC.loader is not None
MODULE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MODULE)


class FormulaTests(unittest.TestCase):
    def test_render_pins_platform_assets(self) -> None:
        formula = MODULE.render(
            "0.1.0b1",
            "a" * 64,
            "b" * 64,
        )
        self.assertIn("geyser-open-0.1.0b1-darwin-arm64.tar.gz", formula)
        self.assertIn("geyser-open-0.1.0b1-linux-amd64.tar.gz", formula)
        self.assertNotIn("geyser-contracts", formula)
        self.assertNotIn("Provenance", formula)
        self.assertIn('sha256 "' + "a" * 64 + '"', formula)
        self.assertIn('sha256 "' + "b" * 64 + '"', formula)
        self.assertNotIn('version "0.1.0b1"', formula)
        self.assertNotIn("www.geyserlabs.ai/download", formula)

    def test_render_rejects_ambiguous_identity(self) -> None:
        with self.assertRaises(ValueError):
            MODULE.render(
                "latest",
                "a" * 64,
                "b" * 64,
            )


if __name__ == "__main__":
    unittest.main()
