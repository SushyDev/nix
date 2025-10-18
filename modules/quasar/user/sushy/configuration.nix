{ 
	config,
	inputs,
	lib,
	pkgs,
	setup,
	...
}:
{
	imports = [
		inputs.nix-plist-manager.homeManagerModules.default
		inputs.dotfiles.homeManagerModules.default
		../shared/nix-plist-manager.nix
	];

	dotfiles = {
		enable = true;
		systemFlakePath = setup.systemFlakePath;
		git = {
			sshSignPackage = "${lib.getBin pkgs._1password-gui}/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
		};
	};

	home.packages = [ 
		# pkgs.go
		pkgs.utm
		pkgs.discord
		pkgs.blender
		pkgs.ollama
	];

 	programs.git = {
 		userEmail = "mail@sushy.dev";
 		userName = "SushyDev";
 		signing.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIImyhNk+raDf5TXHFWOyWIKw8IQapkhwJ5e+iLQydSFR";
 	};

	programs.direnv = {
		enable = true;
		nix-direnv.enable = true;
	};

	# The state version is required and should stay at the version you
	# originally installed.
	home.stateVersion = "25.05";
}
