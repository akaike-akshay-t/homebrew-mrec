cask "meeting-recorder" do
  version "0.1.0"
  sha256 "178747d4a3b1222493073f7900011dd3b7cddb3f64485529a138d0bbea0f3fc3"

  url "https://github.com/akaike-akshay-t/homebrew-mrec/releases/download/v#{version}/Meeting-Recorder-#{version}-macos-arm64.tar.gz"
  name "Meeting Recorder"
  desc "Records meetings and turns them into transcripts and notes"
  homepage "https://github.com/akaike-akshay-t/homebrew-mrec"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app updates itself, verified against its own signing certificate.
  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Meeting Recorder.app"
  binary "#{appdir}/Meeting Recorder.app/Contents/MacOS/mrec"

  postflight_steps do
    # The release is not notarized. The tap's checksum vouches for this download, and the app
    # pins every later update to the certificate it was signed with. (Chrome's manifest for the
    # Meet extension is installed from the app's setup: install steps run with a temporary home.)
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/Meeting Recorder.app"]
  end

  uninstall_postflight_steps do
    remove "Library/Application Support/Google/Chrome/NativeMessagingHosts/dev.mrec.meet.json", base: :home
  end

  # The engine outlives the app's window: stop it (it refuses during a recording) before the app goes.
  uninstall quit:   "dev.mrec.MeetingRecorder",
            script: {
              executable:   "#{appdir}/Meeting Recorder.app/Contents/MacOS/mrec",
              args:         ["daemon", "stop"],
              must_succeed: false,
              print_stderr: false,
            }

  # Meetings, transcripts and notes live in ~/.mrec: only `brew uninstall --zap` removes them.
  zap trash: [
    "~/.mrec",
    "~/Library/Caches/dev.mrec.MeetingRecorder",
    "~/Library/Preferences/dev.mrec.MeetingRecorder.plist",
    "~/Library/Saved Application State/dev.mrec.MeetingRecorder.savedState",
  ]
end
