{ config, lib }:
let
	customLib = import ../lib { inherit lib; };
in
{
	enable = lib.mkOption {
		type = lib.types.bool;
		default = false;
		description = "Enable the plist manager configuration.";
	};

	users = lib.mkOption {
		type = lib.types.listOf lib.types.str;
		default = null;
		description = "The users for whom the plist manager is configured.";
	};

	systemSettings = {
		appearance = import ./options/appearance.nix lib customLib;
		controlCenter = import ./options/control-center.nix lib customLib;
	};
	
	defaults = {
		system = {
			"com.apple.SoftwareUpdate" =
				let
				in
				{
					"AutomaticallyInstallMacOSUpdates" = lib.mkOption {
						description = "System > Software Update > Automatically keep my Mac up to date";
						type = lib.types.nullOr lib.types.bool;
						default = null;
					};
				};
		};
		user = {};
		userByHost = {
			".GlobalPreferences" = 
				let
					constants = {
						appleAccentColor = {
							graphite = -1;
							red = 0;
							orange = 1;
							yellow = 2;
							green = 3;
							blue = 4;
							purple = 5;
							pink = 6;
							multicolor = 7;
						};
						interfaceStyle = {
							light = null;
							dark = "Dark";
							auto = "Auto";
						};
					};

					moduleName = name: "Appearance > ${name}";

				in
				{
					"AppleAccentColor" = lib.mkOption {
						description = "Appearance > Accent Color";
						apply = mapEnumColorValue;
						type = lib.types.nullOr (lib.types.enum (lib.attrNames constants.colors));
						default = null;
					};
					"AppleReduceDesktopTinting" = lib.mkOption {
						description = "Appearance > Allow wallpaper tinting in windows";
						type = lib.types.nullOr lib.types.bool;
						default = null;
					};
					"AppleInterfaceStyle" = lib.mkOption {
						description = "Appearance > Appearance";
						apply = value: if builtins.isNull value then null else if value == "dark" then "Dark" else null;
						type = lib.types.nullOr (lib.types.enum [ "dark" ]);
						default = null;
					};
				};
			"com.apple.controlcenter" =
				let
					constants = {
						modules = {
							always = 18;
							active = 0;
							never = 24;
						};
					};

					moduleName = name: "Control Center > ${name}";

					mapBoolModuleValue = value: if builtins.isNull value then null else if value then 18 else 24;
					mapEnumModuleValue = value: if builtins.isNull value then null else constants.modules.${value};

					mkBoolModule = displayName: lib.mkOption {
						description = moduleName displayName;
						apply = mapBoolModuleValue;
						type = lib.types.nullOr lib.types.bool;
						default = null;
					};

					mkEnumModule = displayName: lib.mkOption {
						description = moduleName displayName;
						apply = mapEnumModuleValue;
						type = lib.types.nullOr (lib.types.enum (lib.attrNames constants.modules));
						default = null;
					};

					mkBitmapModule = module: lib.mkOption {
						description = moduleName module.name;
						apply = value: (customLib.calculateBitmaskValue value module.mapping);
						type = lib.types.nullOr (lib.types.submodule {
							options = lib.mapAttrs (name: options: lib.mkOption {
								description = "Control Center > ${module.name} > ${name}";
								type = lib.types.nullOr lib.types.bool;
								default = null;
							}) module.mapping;
						});
						default = null;
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
				in
				(lib.mapAttrs (name: displayName: mkBoolModule displayName) boolModules) //
				(lib.mapAttrs (name: displayName: mkEnumModule displayName) enumModules) //
				(lib.mapAttrs (name: options: mkBitmapModule options) bitmapModules) //
				{
					"Battery" = lib.mkOption {
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
					"BatteryShowPercentage" = lib.mkOption {
						description = "Control Center > Other Modules > Battery > Show Percentage";
						apply = (value: if builtins.isNull value then null else if value then 1 else 0);
						type = lib.types.nullOr lib.types.bool;
						default = null;
					};
					"FastUserSwitching" = lib.mkOption {
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
				};
		};
	};
}
