class Brewbar < Formula
  desc "Native macOS menubar app for managing Homebrew services"
  homepage "https://github.com/omkarkirpan/BrewBar"
  url "https://github.com/omkarkirpan/BrewBar/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "16c7e96acf3eef745ea1a2095d9d7b4ab2a4a291fb09e474864b12c88598cd3e"
  license "MIT"

  depends_on xcode: ["14.0", :build]
  depends_on macos: :ventura

  def install
    # Build the .app bundle
    cd "BrewBar" do
      system "chmod", "+x", "scripts/build-app.sh"
      system "scripts/build-app.sh"
    end

    # Install .app bundle to prefix
    prefix.install "BrewBar/BrewBar.app"
  end

  def post_install
    # Create symlink in /Applications for easy access
    system "ln", "-sf", "#{prefix}/BrewBar.app", "/Applications/BrewBar.app"

    # Launch BrewBar after installation
    # The app will auto-enable launch at login on first run
    system "open", "/Applications/BrewBar.app"
  end

  def caveats
    <<~EOS
      BrewBar has been installed and launched!

      The app will appear in your menubar with a mug icon.
      Launch at login has been automatically enabled on first run.

      To disable launch at login, open Settings in the app.

      If you encounter Gatekeeper warnings, run:
        xattr -cr /Applications/BrewBar.app

      CLI commands are available:
        /Applications/BrewBar.app/Contents/MacOS/BrewBar --version
        /Applications/BrewBar.app/Contents/MacOS/BrewBar --help
    EOS
  end

  test do
    assert_predicate prefix/"BrewBar.app", :exist?
    assert_predicate prefix/"BrewBar.app/Contents/MacOS/BrewBar", :executable?
  end
end
