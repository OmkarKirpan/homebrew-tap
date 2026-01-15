class Brewbar < Formula
  desc "Native macOS menubar app for managing Homebrew services"
  homepage "https://github.com/omkarkirpan/BrewBar"
  url "https://github.com/omkarkirpan/BrewBar/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "16c7e96acf3eef745ea1a2095d9d7b4ab2a4a291fb09e474864b12c88598cd3e"
  license "MIT"

  depends_on xcode: ["14.0", :build]
  depends_on macos: :ventura

  def install
    # Build release binary
    system "swift", "build", "-c", "release", "--disable-sandbox"

    # Get binary path
    bin_path = Utils.safe_popen_read("swift", "build", "--show-bin-path", "-c", "release").strip

    # Create .app bundle structure
    app_bundle = prefix/"BrewBar.app/Contents"
    (app_bundle/"MacOS").mkpath
    (app_bundle/"Resources").mkpath

    # Copy binary
    cp "#{bin_path}/BrewBar", app_bundle/"MacOS/BrewBar"

    # Create Info.plist
    (app_bundle/"Info.plist").write <<~XML
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
          <key>CFBundleDevelopmentRegion</key>
          <string>en</string>
          <key>CFBundleExecutable</key>
          <string>BrewBar</string>
          <key>CFBundleIdentifier</key>
          <string>com.brewbar.app</string>
          <key>CFBundleInfoDictionaryVersion</key>
          <string>6.0</string>
          <key>CFBundleName</key>
          <string>BrewBar</string>
          <key>CFBundlePackageType</key>
          <string>APPL</string>
          <key>CFBundleShortVersionString</key>
          <string>#{version}</string>
          <key>CFBundleVersion</key>
          <string>1</string>
          <key>LSApplicationCategoryType</key>
          <string>public.app-category.utilities</string>
          <key>LSMinimumSystemVersion</key>
          <string>13.0</string>
          <key>LSUIElement</key>
          <true/>
          <key>NSHighResolutionCapable</key>
          <true/>
          <key>NSPrincipalClass</key>
          <string>NSApplication</string>
      </dict>
      </plist>
    XML
  end

  def post_install
    # Create symlink in /Applications for easy access
    system "ln", "-sf", "#{prefix}/BrewBar.app", "/Applications/BrewBar.app"

    # Launch BrewBar after installation
    system "open", "/Applications/BrewBar.app"
  end

  def caveats
    <<~EOS
      BrewBar has been installed and launched!

      The app will appear in your menubar with a mug icon.
      Launch at login is automatically enabled on first run.

      To disable launch at login, open Settings in the app.

      If you encounter Gatekeeper warnings, run:
        xattr -cr /Applications/BrewBar.app

      CLI commands:
        /Applications/BrewBar.app/Contents/MacOS/BrewBar --version
        /Applications/BrewBar.app/Contents/MacOS/BrewBar --help
    EOS
  end

  test do
    assert_predicate prefix/"BrewBar.app", :exist?
    assert_predicate prefix/"BrewBar.app/Contents/MacOS/BrewBar", :executable?
  end
end
