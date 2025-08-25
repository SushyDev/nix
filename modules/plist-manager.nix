{ self, lib, setup, config, nix-plist-manager, ... }:
{
	nix-plist-manager.enable = true;
	nix-plist-manager.users = [ "sushy" ];
	nix-plist-manager.defaults = {
		system = {
			"com.apple.SoftwareUpdate" = {
				"AutomaticallyInstallMacOSUpdates" = true;
			};
		};
		userByHost = {
			".GlobalPreferences" = {
				"AppleAccentColor" = "pink";
				"AppleReduceDesktopTinting" = true;
			};
			"com.apple.controlcenter" = {
				"WiFi" = false;
				"Bluetooth" = false;
				"AirDrop" = false;
				"FocusModes" = "never";
				"StageManager" = false;
				"ScreenMirroring" = "active";
				"Display" = "never";
				"Sound" = "never";
				"NowPlaying" = "never";
				"AccessibilityShortcuts" = {
					"Show in Menu Bar" = false;
					"Show in Control Center" = false;
				};
				"Battery" = {
					"Show in Menu Bar" = true;
					"Show in Control Center" = false;
				};
				"BatteryShowPercentage" = true;
				"MusicRecognition" = {
					"Show in Menu Bar" = false;
					"Show in Control Center" = false;
				};
				"Hearing" = {
					"Show in Menu Bar" = false;
					"Show in Control Center" = false;
				};
				"KeyboardBrightness" = {
					"Show in Menu Bar" = false;
					"Show in Control Center" = false;
				};
			};
		};
	};

	nix-plist-manager.systemSettings.controlCenter.WiFi = true;

	system.primaryUser = lib.head config.nix-plist-manager.users;
	system.stateVersion = 6;
}
