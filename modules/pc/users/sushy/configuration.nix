{ inputs, setup, lib, pkgs, ... }:
{
	imports = [
		inputs.dotfiles.homeManagerModules.default
	];

	dotfiles = {
		enable = true;
		systemFlakePath = setup.systemFlakePath;
	};

	programs.git = {
		userEmail = "mail@sushy.dev";
		userName = "SushyDev";
		signing.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIImyhNk+raDf5TXHFWOyWIKw8IQapkhwJ5e+iLQydSFR";
	};

	programs.direnv = {
		enable = true;
		nix-direnv.enable = true;
	};

	home.packages = [];

	# The state version is required and should stay at the version you
	# originally installed
	home.stateVersion = "25.05";
}
