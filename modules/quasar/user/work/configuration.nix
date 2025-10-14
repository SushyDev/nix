{ pkgs, inputs, ... }: 
{
	imports = [
		inputs.nix-plist-manager.homeManagerModules.default
		inputs.dotfiles.homeManagerModules.default
		../shared/nix-plist-manager.nix
	];

	dotfiles.enable = true;

	home.packages = [ 
		pkgs.slack
		pkgs.phpstorm
		pkgs.glab
	];

	# The state version is required and should stay at the version you
	# originally installed.
	home.stateVersion = "25.05";
}
