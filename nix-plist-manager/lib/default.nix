{ lib }:
let
	/**
	 * Calculates the bitmask value based on the provided boolean options and their corresponding bit values.
	 *
	 * @param boolOptions An attribute set where keys are option names and values are booleans indicating whether the option is enabled.
	 * @param bitmaskMap An attribute set mapping option names to their respective bit values.
	 * @return The calculated bitmask value as an integer.
	 */
	calculateBitmaskValue = boolOptions: bitmaskMap:
		lib.foldl' builtins.bitOr 0 (lib.mapAttrsToList (name: value:
			if boolOptions.${name} or false then value else 0
		) bitmaskMap);

	/**
	 * Maps the battery settings to their corresponding bitmask value.
	 *
	 * @param value An attribute set with "Show in Menu Bar" and "Show in Control Center" boolean options.
	 * @return The calculated bitmask value for the battery settings.
	 */
	mapBatteryValue = value:
		if builtins.isNull value then null
		else (if value."Show in Menu Bar" then 0 else 8) + (if value."Show in Control Center" then 1 else 0);
in
{
	inherit calculateBitmaskValue mapBatteryValue;
}
