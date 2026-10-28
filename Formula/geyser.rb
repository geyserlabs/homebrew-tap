class Geyser < Formula
  desc "Framework-neutral CLI for governed durable Geyser agents"
  homepage "https://geyserlabs.ai/developers"
  license "MIT"

  on_macos do
    url "https://github.com/geyserlabs/geyser-open/releases/download/v0.3.2/geyser-open-0.3.2-darwin-arm64.tar.gz"
    sha256 "bf538750eb98e8a67dd07189ad09395b9660843bdc0d858657cc75c9622a02c4"
  end

  on_linux do
    url "https://github.com/geyserlabs/geyser-open/releases/download/v0.3.2/geyser-open-0.3.2-linux-amd64.tar.gz"
    sha256 "ef3c8b77e01907fdbb8ef33408f85507ce99d98c2d2d8b2607f2869346072e79"
  end

  def install
    odie "Geyser Open supports Apple-Silicon macOS only" if OS.mac? && !Hardware::CPU.arm?
    odie "Geyser Open supports AMD64 Linux only" if OS.linux? && !Hardware::CPU.intel?
    bin.install "geyser"
  end

  test do
    assert_match '"geyser_open":"0.3.2"', shell_output("#{bin}/geyser --json version")
  end
end
