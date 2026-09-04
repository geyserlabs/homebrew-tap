class Geyser < Formula
  desc "Framework-neutral CLI for governed durable Geyser agents"
  homepage "https://geyserlabs.ai/developers"

  license "MIT"

  on_macos do
    url "https://github.com/geyserlabs/geyser-open/releases/download/v0.1.0/geyser-open-0.1.0-darwin-arm64.tar.gz"
    sha256 "c239a4704dca2e329875c2e0d0761ef1c5057475f7e97e3e22e3abea2319a1f4"
  end

  on_linux do
    url "https://github.com/geyserlabs/geyser-open/releases/download/v0.1.0/geyser-open-0.1.0-linux-amd64.tar.gz"
    sha256 "d3b7b85ee1af33087fca7df6566a0480dec0f0f10665e3c587fe8b8620cd9930"
  end

  def install
    odie "Geyser Open supports Apple-Silicon macOS only" if OS.mac? && !Hardware::CPU.arm?
    odie "Geyser Open supports AMD64 Linux only" if OS.linux? && !Hardware::CPU.intel?
    bin.install "geyser"
  end

  test do
    assert_match '"geyser_open":"0.1.0"', shell_output("#{bin}/geyser --json version")
  end
end
