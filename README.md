# Meeting Recorder for Homebrew

```sh
brew tap akaike-akshay-t/mrec
brew trust akaike-akshay-t/mrec
brew install --cask meeting-recorder
```

Meeting Recorder records the calls you take on your Mac, transcribes them on your Mac with local
speech models, tells the speakers apart, and has [pi](https://github.com/badlogic/pi-mono) write the
notes with whatever model you use in pi. It needs Apple silicon and macOS 14.4 or later; notes and
Ask need pi.

The cask installs `Meeting Recorder.app` and links the `mrec` command. After that the app updates
itself: it checks this tap's releases at launch and every six hours, verifies each update's
signature, and installs it when you choose to, never during a recording.

Releases are signed with the project's own certificate, not notarized by Apple. The cask clears the
download quarantine so macOS opens the app. Trust comes from the cask's checksum, and the app only
accepts updates signed with the project's updater key.

## Upgrading from 0.1

0.2 is a rewrite, and 0.1's built-in updater does not install it. Quit Meeting Recorder, then run:

```sh
brew upgrade --cask --greedy meeting-recorder
```

On first launch 0.2 moves 0.1's data folder to `~/.mrec-legacy` and starts fresh. Nothing is
deleted.

## Uninstalling

`brew uninstall --cask meeting-recorder` removes the app and the `mrec` link. Your meetings, models
and settings stay in `~/.mrec`.
