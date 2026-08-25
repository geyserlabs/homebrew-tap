class Geyser < Formula
  desc "Framework-neutral CLI for governed durable Geyser agents"
  homepage "https://geyserlabs.ai/developers"

  # Source: b105031a2de27633a183d82729b375168b138fcf
  # Provenance: https://github.com/geyserlabs/geyser-open/actions/runs/32854732268
  url "https://github.com/geyserlabs/geyser-open/releases/download/v0.1.0b4/geyser-contracts-0.1.0b4.tar.gz"
  sha256 "dabfea6ee6646cdb3b824d1def38f7dbbd62e16b953504b07b8c67388969021d"
  license "MIT"

  resource "geyser-cli" do
    on_macos do
      url "https://github.com/geyserlabs/geyser-open/releases/download/v0.1.0b4/geyser-open-0.1.0b4-darwin-arm64.tar.gz"
      sha256 "271cf51f14fa872e9cbe51274082046b946b76eebd6a55f3c5cc4406ee8a634a"
    end

    on_linux do
      url "https://github.com/geyserlabs/geyser-open/releases/download/v0.1.0b4/geyser-open-0.1.0b4-linux-amd64.tar.gz"
      sha256 "ed5e43d98281ae903206b49b92088fd88c43f3e1f471605c98615de2ee16eb67"
    end
  end

  def install
    if OS.mac? && !Hardware::CPU.arm?
      odie "Geyser Open supports Apple-Silicon macOS only"
    end
    if OS.linux? && !Hardware::CPU.intel?
      odie "Geyser Open supports AMD64 Linux only"
    end
    resource("geyser-cli").stage do
      bin.install "geyser"
    end
  end

  test do
    assert_match '"geyser_open":"0.1.0b4"', shell_output("#{bin}/geyser --json version")
  end
end
