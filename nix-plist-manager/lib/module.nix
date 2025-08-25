{ moduleName, constants, lib, customLib }:
let
	getModuleName = name: "${moduleName} > ${name}";

	mapBoolModuleValue = value: if builtins.isNull value then null else if value then 18 else 24;
	mapEnumModuleValue = value: if builtins.isNull value then null else constants.modules.${value};

	mkBoolModule = displayName: lib.mkOption {
		description = getModuleName displayName;
		apply = mapBoolModuleValue;
		type = lib.types.nullOr lib.types.bool;
		default = null;
	};

	mkEnumModule = displayName: lib.mkOption {
		description = getModuleName displayName;
		apply = mapEnumModuleValue;
		type = lib.types.nullOr (lib.types.enum (lib.attrNames constants.modules));
		default = null;
	};

	mkBitmapModule = module: lib.mkOption {
		description = getModuleName module.name;
		apply = value: (customLib.calculateBitmaskValue value module.mapping);
		type = lib.types.nullOr (lib.types.submodule {
			options = lib.mapAttrs (name: options: lib.mkOption {
				# TODO loop over paths to build this automatically
				description = "${moduleName} > ${module.name} > ${name}";
				type = lib.types.nullOr lib.types.bool;
				default = null;
			}) module.mapping;
		});
		default = null;
	};
in
{
	inherit mkBoolModule mkEnumModule mkBitmapModule;
}
