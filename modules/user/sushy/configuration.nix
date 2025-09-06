{ config, pkgs, ... }: 
{
	imports = [
		../shared/dotfiles.nix
	];

	home.packages = [ 
		pkgs.go
		pkgs.utm
		pkgs.discord
		pkgs.blender
		pkgs.ollama
	];

	programs.git = {
		userEmail = "xsushy@hotmail.com";
		userName = "SushyDev";
		signing.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIImyhNk+raDf5TXHFWOyWIKw8IQapkhwJ5e+iLQydSFR";
	};

	# The state version is required and should stay at the version you
	# originally installed.
	home.stateVersion = "25.05";
}
