# Slay the spire 2 mod example

Example mod project made according to [STS2 Early Access Mod Guide by doctornoodlearms on r/slaythespire](https://www.reddit.com/r/slaythespire/comments/1rm5gvg/sts2_early_access_mod_guide/).

My process for building this mod on macOS Apple Silicon:

1. Install [Godot 4.5.1 .NET version](https://godotengine.org/download/archive/4.5.1-stable/), e.g., `Godot_v4.5.1-stable_mono_macos.universal.zip` for macOS, `Godot_v4.5.1-stable_mono_linux_x86_64.zip` for Linux
2. Install [.NET SDK](https://dotnet.microsoft.com/en-us/download), e.g., `dotnet-sdk-10.0.200-osx-arm64.pkg` for macOS, use nixpkgs for Linux
3. Open Godot, create a project, name it `FirstMod`
4. In the Script tab, click File -> New Script..., select .NET as the language, name it `NewScript.cs`, and fill in the following content:
    ```csharp
    using Godot;
    using MegaCrit.Sts2.Core.Modding;
    using MegaCrit.Sts2.Core.Logging;

    namespace FirstMod;

    [ModInitializer("ModLoaded")]
    public static class FirstMod {
        public static void ModLoaded() {
            Log.Warn("MOD FINISHED LOADING");
        }
    }
    ```

5. Copy the game's sts2.dll (e.g., `~/Library/Application\ Support/steam/steamapps/common/Slay\ the\ Spire\ 2/SlayTheSpire2.app/Contents/Resources/data_sts2_macos_arm64/sts2.dll` on macOS, `~/.steam/steam/steamapps/common/Slay\ the\ Spire\ 2/data_sts2_linuxbsd_x86_64/sts2.dll` on Linux) to the project root directory
6. Modify `FirstMod.csproj` as shown below, change the .NET version to 9.0, add a reference to sts2.dll, then click Build Project in Godot:

    ```xml
    <Project Sdk="Godot.NET.Sdk/4.5.1">
    <PropertyGroup>
        <TargetFramework>net9.0</TargetFramework>
        <EnableDynamicLoading>true</EnableDynamicLoading>
    </PropertyGroup>
    <ItemGroup>
        <Reference Include="sts2">
            <HintPath>sts2.dll</HintPath>
        </Reference>
    </ItemGroup>
    </Project>
    ```

7. Create `mod_manifest.json` in the project root directory:

    ```json
    {
        "id": "FirstMod",
        "name": "FirstMod",
        "author": "doctornoodlearms",
        "description": "",
        "version": "1.0.0",
        "has_pck": true,
        "has_dll": true,
        "dependencies": [],
        "affects_gameplay": true
    }
    ```

8. Prepare an image named `mod_image.png` in the `FirstMod` directory under project root directory for the mod's icon
9. Go to Project -> Export..., click Add..., and select Windows Desktop
10. Under the Resources section, select Export selected resources (and dependencies), tick `FirstMod/mod_image.png`, then click Export PCK/ZIP..., save as `FirstMod.pck`. You can also export via command line, e.g., `/Applications/Godot_mono.app/Contents/MacOS/Godot --export-pack "Windows Desktop" FirstMod.pck --headless`
11. Copy `mod_manifest.json` as `FirstMod.json`, `./.godot/mono/temp/bin/Debug/FirstMod.dll` and `FirstMod.pck` to the `FirstMod` directory under the game's `mods` directory, e.g., `~/Library/Application\ Support/Steam/steamapps/common/Slay\ the\ Spire\ 2/SlayTheSpire2.app/Contents/MacOS/mods/FirstMod` (macOS) or `~/.steam/steam/steamapps/common/Slay\ the\ Spire\ 2/mods/FirstMod` (Linux), create the directory if it doesn't exist
12. Launch the game

A build script is provided at `build.sh` to build the mod without GUI. An installation script is provided at `install.sh` to install the mod automatically.

Starting Godot's Debug Server:

1. In Godot, select Debug -> Keep Debug Server Open
2. In Steam, set the launch option `--remote-debug tcp://127.0.0.1:6007`
3. Launch the game

Tested to build & run in both macOS and Linux.
