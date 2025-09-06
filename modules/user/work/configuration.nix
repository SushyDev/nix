{ config, pkgs, ... }: 
{
	imports = [
		../shared/dotfiles.nix
	];

	home.packages = [ 
		pkgs.slack
		pkgs.phpstorm
	];

	# The state version is required and should stay at the version you
	# originally installed.
	home.stateVersion = "25.05";
}
