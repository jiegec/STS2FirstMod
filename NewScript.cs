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
