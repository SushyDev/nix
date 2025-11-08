{ systemConfig, pkgs, lib, ... }:
# Provide DDEV command autocompletions for artisan and magento commands
# If DDEV is installed in the system packages, add the autocompletion scripts to the user's home directory
lib.mkIf (builtins.elem pkgs.ddev systemConfig.environment.systemPackages)
{
	home.file.".ddev/commands/web/autocomplete/artisan" = {
		source = ./ddev/artisan.sh;
		executable = true;
	};
	home.file.".ddev/commands/web/autocomplete/magento" = {
		source = ./ddev/magento.sh;
		executable = true;
	};
}
