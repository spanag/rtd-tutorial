#!/bin/bash
set -ex
snap install chromium
snap install firefox
env
if [ -z $READTHEDOCS ]; then
  # Install Google Chrome™ not Chromium, because most automation expects the branded, encumbered Google Chrome™
  # https://askubuntu.com/questions/79280/how-to-install-chrome-browser-properly-via-command-line
  # https://unix.stackexchange.com/questions/612981/install-older-versions-of-google-chrome-stable-on-ubuntu-14-10
  # https://www.ubuntuupdates.org/package/google_chrome/stable/main/base/google-chrome-stable
  CHROME_VERSION="120.0.6099.129-1"
  ARCH=$(dpkg --print-architecture)
  CHROME_DEB_FILEPATH=/tmp/chrome.deb
  wget --no-verbose -O "${CHROME_DEB_FILEPATH}" https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_${CHROME_VERSION}_${ARCH}.deb
  apt install -y "${CHROME_DEB_FILEPATH}"
  apt install -y -f # Now add Chrome's deps
  rm -f "${CHROME_DEB_FILEPATH}"
  google-chrome --version
fi
