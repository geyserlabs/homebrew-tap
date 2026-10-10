class Geyser < Formula
  desc "Framework-neutral CLI for governed durable Geyser agents"
  homepage "https://geyserlabs.ai/developers"
  license "MIT"

  on_macos do
    url "https://github.com/geyserlabs/geyser-open/releases/download/v0.3.1/geyser-open-0.3.1-darwin-arm64.tar.gz"
    sha256 "ffda5cd3320d9c67ccceea1daf27f15c4f501a67c44bf51eb68c5492b70995f4"
  end

  on_linux do
    url "https://github.com/geyserlabs/geyser-open/releases/download/v0.3.1/geyser-open-0.3.1-linux-amd64.tar.gz"
    sha256 "788fbb2a5d96ace80c0f68b986a1013b39c791aa5ce69b19c970769cc54abe88"
  end

  def install
    odie "Geyser Open supports Apple-Silicon macOS only" if OS.mac? && !Hardware::CPU.arm?
    odie "Geyser Open supports AMD64 Linux only" if OS.linux? && !Hardware::CPU.intel?
    bin.install "geyser"
  end

  test do
    assert_match '"geyser_open":"0.3.1"', shell_output("#{bin}/geyser --json version")
  end
end
