#!/bin/sh
set -x
cp ~/Library/Application\ Support/steam/steamapps/common/Slay\ the\ Spire\ 2/SlayTheSpire2.app/Contents/Resources/data_sts2_macos_arm64/sts2.dll .
/Applications/Godot_mono.app/Contents/MacOS/Godot --build-solutions --quit --headless
mkdir -p FirstMod
rm -rf FirstMod/FirstMod.dll FirstMod/FirstMod.pck
cp ./.godot/mono/temp/bin/Debug/FirstMod.dll FirstMod/
/Applications/Godot_mono.app/Contents/MacOS/Godot --export-pack "Windows Desktop" FirstMod/FirstMod.pck --headless
