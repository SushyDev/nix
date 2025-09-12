{ pkgs, inputs, ... }:
{
	imports = [
		../../../shared/users/shared/dotfiles.nix
	];

	home.packages = [];

	# The state version is required and should stay at the version you
	# originally installed.
	home.stateVersion = "25.05";
}
