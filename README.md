# Meeting Recorder for Homebrew

```sh
brew install --cask akaike-akshay-t/mrec/meeting-recorder
```

Meeting Recorder records meetings on your Mac and turns them into transcripts and notes. It needs
macOS 14.4 or later on Apple silicon.

The cask installs `Meeting Recorder.app`, links the `mrec` command and registers the Chrome Meet
extension's native messaging host. After that the app updates itself: it checks hourly, downloads
and verifies new releases in the background, and installs them when you restart or quit it, never
during a recording.

Releases are not notarized. They are signed with the project's own certificate; the cask clears
the quarantine flag after Homebrew has checked the download's SHA-256, and the app installs only
updates signed with the same certificate.

- Uninstall: `brew uninstall --cask meeting-recorder` (your meetings in `~/.mrec` stay)
- Remove everything, meetings included: `brew uninstall --zap --cask meeting-recorder`

This repository holds the cask and the release downloads. The release workflow publishes both.
