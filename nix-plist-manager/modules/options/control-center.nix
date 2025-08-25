lib: customLib:
let
	moduleName = "Control Center";
	constants = {
		modules = {
			always = 18;
			active = 0;
			never = 24;
		};
	};

	moduleBuilder = import ../../lib/module.nix {
		moduleName = moduleName;
		constants = constants;
		inherit lib customLib;
	};

	boolModules = {
		WiFi = "Wi-Fi";
		Bluetooth = "Bluetooth";
		AirDrop = "AirDrop";
		StageManager = "Stage Manager";
	};

	enumModules = {
		FocusModes = "Focus";
		ScreenMirroring = "Screen Mirroring";
		Display = "Display";
		Sound = "Sound";
		NowPlaying = "Now Playing";
	};

	bitmapModules = {
		AccessibilityShortcuts = {
			name = "Accessibility Shortcuts";
			mapping = {
				"Show in Menu Bar" = 2;
				"Show in Control Center" = 1;
			};
		};
		MusicRecognition = {
			name = "Music Recognition";
			mapping = {
				"Show in Menu Bar" = 2;
				"Show in Control Center" = 1;
			};
		};
		Hearing = {
			name = "Hearing";
			mapping = {
				"Show in Menu Bar" = 2;
				"Show in Control Center" = 1;
			};
		};
		KeyboardBrightness = {
			name = "Keyboard Brightness";
			mapping = {
				"Show in Menu Bar" = 2;
				"Show in Control Center" = 1;
			};
		};
	};

	optionBattery = lib.mkOption {
		description = ''
			Control Center > Other Modules > Battery
			- Show in Menu Bar
			- Show in Control Center
		'';
		apply = customLib.mapBatteryValue;
		type = lib.types.nullOr (lib.types.submodule {
			options = {
				"Show in Menu Bar" = lib.mkOption {
					description = "Control Center > Other Modules > Battery";
					type = lib.types.nullOr lib.types.bool;
					default = null;
				};
				"Show in Control Center" = lib.mkOption {
					description = "Control Center > Other Modules > Battery";
					type = lib.types.nullOr lib.types.bool;
					default = null;
				};
			};
		});
		default = {};
	};

	optionBatteryShowPercentage = lib.mkOption {
		description = "Control Center > Other Modules > Battery > Show Percentage";
		apply = (value: if builtins.isNull value then null else if value then 1 else 0);
		type = lib.types.nullOr lib.types.bool;
		default = null;
	};

	optionFastUserSwitching = lib.mkOption {
		description = ''
			Control Center > Other Modules > Fast User Switching
			- Show in Menu Bar
			- Show in Control Center
		'';
		apply = (value: (customLib.calculateBitmaskValue value {
			"Show in Menu Bar" = 2;
			"Show in Control Center" = 1;
		}));
		type = lib.types.nullOr (lib.types.submodule {
			options = {
				"Show in Menu Bar" = lib.mkOption {
					description = "Control Center > Other Modules > Fast User Switching";
					type = lib.types.nullOr lib.types.bool;
					default = null;
				};
				"Show in Control Center" = lib.mkOption {
					description = "Control Center > Other Modules > Fast User Switching";
					type = lib.types.nullOr lib.types.bool;
					default = null;
				};
			};
		});
		default = null;
	};
in
(lib.mapAttrs (name: displayName: moduleBuilder.mkBoolModule displayName) boolModules) //
(lib.mapAttrs (name: displayName: moduleBuilder.mkEnumModule displayName) enumModules) //
(lib.mapAttrs (name: options: moduleBuilder.mkBitmapModule options) bitmapModules) //
{
	"Battery" = optionBattery;
	"BatteryShowPercentage" = optionBatteryShowPercentage;
	"FastUserSwitching" = optionFastUserSwitching;
}
