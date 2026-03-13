#!/bin/sh
set -x
cp ~/Library/Application\ Support/steam/steamapps/common/Slay\ the\ Spire\ 2/SlayTheSpire2.app/Contents/Resources/data_sts2_macos_arm64/sts2.dll .
/Applications/Godot_mono.app/Contents/MacOS/Godot --build-solutions --quit --headless
rm -rf dist
mkdir -p dist
cp ./.godot/mono/temp/bin/Debug/FirstMod.dll dist/
/Applications/Godot_mono.app/Contents/MacOS/Godot --export-pack "Windows Desktop" dist/FirstMod.pck --headless
cp mod_manifest.json dist/FirstMod.json
