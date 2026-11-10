cask "mrec" do
  version "0.2.6"
  sha256 "5ed7796b4fc50dd57b00123ff6f9e302f96978be2239f61eafd844f213fee068"

  url "https://github.com/akaike-akshay-t/homebrew-mrec/releases/download/v#{version}/mrec_#{version}_aarch64.zip"
  name "mrec"
  desc "Local meeting recording, transcription and pi-powered notes"
  homepage "https://github.com/akaike-akshay-t/homebrew-mrec"

  # The app updates itself in place (signed updates from this tap's releases).
  auto_updates true
  # The app itself requires macOS 14.4 (Core Audio process taps); macOS refuses older versions.
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "mrec.app"
  binary "#{appdir}/mrec.app/Contents/MacOS/mrec"

  # Signed with the project's own certificate and not notarized, so Gatekeeper would refuse a
  # quarantined copy. Trust comes from this cask's checksum, and the in-app updater accepts only
  # updates signed with the project's updater key.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-d", "-r", "com.apple.quarantine", "{{appdir}}/mrec.app"],
        must_succeed: false
  end

  # User data and models are deliberately preserved on uninstall; no zap stanza.
end
