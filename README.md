# Geyser Labs Homebrew tap

This is the authoritative Homebrew distribution for the standalone
[Geyser Open](https://github.com/geyserlabs/geyser-open) developer CLI.

```console
brew tap geyserlabs/tap
brew install geyser
geyser --json version
```

Formula changes are generated from immutable, signed Geyser Open GitHub
Release assets. Each URL and SHA-256 digest is pinned; the update workflow
verifies GitHub attestation and the retained release manifest before opening a
reviewed pull request. Packages are not mirrored through the marketing site.

Only Apple-Silicon macOS and AMD64 Linux are qualified in the Developer
Preview. See the [Geyser Open release policy](https://github.com/geyserlabs/geyser-open/blob/main/docs/releases.md)
for verification, rollback, and compromise response.
