lib: customLib:
let
	moduleName = "Appearance";
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

	moduleBuilder = import ../../lib/module.nix {
		moduleName = moduleName;
		constants = constants;
		inherit lib customLib;
	};

	mkEnumColorValue = name: lib.mkOption {
		description = moduleName name;
		apply = value: if builtins.isNull value then null else constants.colors.${value};
		type = lib.types.nullOr (lib.types.enum (lib.attrNames constants.colors));
		default = null;
	};

	mapEnumColorValue = value: if builtins.isNull value then null else constants.colors.${value};
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
}

