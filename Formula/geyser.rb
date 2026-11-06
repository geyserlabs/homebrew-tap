class Geyser < Formula
  desc "Framework-neutral CLI for governed durable Geyser agents"
  homepage "https://geyserlabs.ai/developers"
  license "MIT"

  on_macos do
    url "https://github.com/geyserlabs/geyser-open/releases/download/v0.3.4/geyser-open-0.3.4-darwin-arm64.tar.gz"
    sha256 "69beb773d9710d270f8924cd0b2a4ebfed8d7b2f05c73109545456d66a6ce196"
  end

  on_linux do
    url "https://github.com/geyserlabs/geyser-open/releases/download/v0.3.4/geyser-open-0.3.4-linux-amd64.tar.gz"
    sha256 "4681487d3d540e5ad3eef5908456af11cef4184734046437bc17a645f114143e"
  end

  def install
    odie "Geyser Open supports Apple-Silicon macOS only" if OS.mac? && !Hardware::CPU.arm?
    odie "Geyser Open supports AMD64 Linux only" if OS.linux? && !Hardware::CPU.intel?
    bin.install "geyser"
  end

  test do
    assert_match '"geyser_open":"0.3.4"', shell_output("#{bin}/geyser --json version")
  end
end
