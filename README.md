# Geyser Labs Homebrew tap

This is the authoritative Homebrew distribution for the standalone
[Geyser Open](https://github.com/geyserlabs/geyser-open) developer CLI.

```console
brew tap geyserlabs/tap
brew install geyser
geyser --json version
```

Formula changes are generated from immutable Geyser Open GitHub Release assets.
Each platform URL and SHA-256 digest is pinned. The update workflow checks those
two downloads, runs `make check`, and opens a pull request. No attestation,
release manifest, provenance record, or separate evidence package is required.

The distributed targets are Apple-Silicon macOS and AMD64 Linux.
