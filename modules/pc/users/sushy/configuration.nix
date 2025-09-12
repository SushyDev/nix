{ pkgs, inputs, ... }:
{
	imports = [
		../../../shared/users/shared/dotfiles.nix
	];

 	programs.git = {
 		userEmail = "xsushy@hotmail.com";
 		userName = "SushyDev";
 	};

	home.packages = [];

	# The state version is required and should stay at the version you
	# originally installed.
	home.stateVersion = "25.05";
}
