class Brewbar < Formula
  desc "Native macOS menubar app for managing Homebrew services"
  homepage "https://github.com/omkarkirpan/BrewBar"
  url "https://github.com/omkarkirpan/BrewBar/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "f14fc46542d81021fb89b760ea7fdfd6979678086cf900e0e8b0a357e8922e33"
  license "MIT"

  depends_on xcode: ["14.0", :build]
  depends_on macos: :ventura

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/BrewBar" => "brewbar"
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
    assert_predicate bin/"brewbar", :exist?
    assert_predicate bin/"brewbar", :executable?
  end
end
