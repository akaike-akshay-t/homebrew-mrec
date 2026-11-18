cask "mrec" do
  version "0.2.19"
  sha256 "3fbe407ee040e4b0979c06b936d6755eaed367dab12a15b08d2b86e5da33960b"

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
