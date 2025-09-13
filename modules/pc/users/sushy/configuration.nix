{ pkgs, inputs, ... }:
{
	imports = [
		inputs.dotfiles.homeManagerModules.default
	];

	dotfiles.enable = true;

 	programs.git = {
 		userEmail = "mail@sushy.dev";
 		userName = "SushyDev";
 	};

	home.packages = [];

	# The state version is required and should stay at the version you
	# originally installed.
	home.stateVersion = "25.05";
}
