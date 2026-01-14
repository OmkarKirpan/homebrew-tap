class Brewbar < Formula
  desc "Native macOS menubar app for managing Homebrew services"
  homepage "https://github.com/omkarkirpan/BrewBar"
  url "https://github.com/omkarkirpan/BrewBar/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"
  license "MIT"

  depends_on :macos => :ventura
  depends_on xcode: ["14.0", :build]

  def install
    cd "BrewBar" do
      system "swift", "build", "-c", "release", "--disable-sandbox"
      bin.install ".build/release/BrewBar" => "brewbar"
    end
  end

  def caveats
    <<~EOS
      BrewBar has been installed as a command-line tool.

      To run: brewbar

      Note: This is the CLI version. For the .app bundle, build from source:
        git clone https://github.com/omkarkirpan/BrewBar.git
        cd BrewBar/BrewBar && ./scripts/build-app.sh
    EOS
  end

  test do
    assert_match "BrewBar", shell_output("#{bin}/brewbar --help 2>&1", 1)
  end
end
