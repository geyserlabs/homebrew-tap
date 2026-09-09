class Geyser < Formula
  desc "Framework-neutral CLI for governed durable Geyser agents"
  homepage "https://geyserlabs.ai/developers"
  license "MIT"

  on_macos do
    url "https://github.com/geyserlabs/geyser-open/releases/download/v0.2.0/geyser-open-0.2.0-darwin-arm64.tar.gz"
    sha256 "859e3a41a88234de55b7cd9ca9cb375f2d3a6c69586f483bb1480d236c68cfb1"
  end

  on_linux do
    url "https://github.com/geyserlabs/geyser-open/releases/download/v0.2.0/geyser-open-0.2.0-linux-amd64.tar.gz"
    sha256 "5596e58a993233bf203ddfccbbc8e3f31722a1b6dd29ee4f734982338782f398"
  end

  def install
    odie "Geyser Open supports Apple-Silicon macOS only" if OS.mac? && !Hardware::CPU.arm?
    odie "Geyser Open supports AMD64 Linux only" if OS.linux? && !Hardware::CPU.intel?
    bin.install "geyser"
  end

  test do
    assert_match '"geyser_open":"0.2.0"', shell_output("#{bin}/geyser --json version")
  end
end
