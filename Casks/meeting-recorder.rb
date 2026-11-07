cask "meeting-recorder" do
  version "0.2.0"
  sha256 "02d417980d00ae92c9df46e75da7b4237076dfa08cd0064ab71ab8ce5c1686ba"

  url "https://github.com/akaike-akshay-t/homebrew-mrec/releases/download/v#{version}/Meeting-Recorder_#{version}_aarch64.zip"
  name "Meeting Recorder"
  desc "Local meeting recording, transcription and pi-powered notes"
  homepage "https://github.com/akaike-akshay-t/homebrew-mrec"

  # The app updates itself in place (signed updates from this tap's releases).
  auto_updates true
  # The app itself requires macOS 14.4 (Core Audio process taps); macOS refuses older versions.
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Meeting Recorder.app"
  binary "#{appdir}/Meeting Recorder.app/Contents/MacOS/mrec"

  # Signed with the project's own certificate and not notarized, so Gatekeeper would refuse a
  # quarantined copy. Trust comes from this cask's checksum, and the in-app updater accepts only
  # updates signed with the project's updater key.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-d", "-r", "com.apple.quarantine", "{{appdir}}/Meeting Recorder.app"],
        must_succeed: false
  end

  # User data and models are deliberately preserved on uninstall; no zap stanza.
end
