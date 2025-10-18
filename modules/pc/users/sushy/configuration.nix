{ inputs, setup, lib, pkgs, ... }:
{
	imports = [
		inputs.dotfiles.homeManagerModules.default
	];

	dotfiles = {
		enable = true;
		systemFlakePath = setup.systemFlakePath;
		git = {
			sshSignPackage = lib.getExe' pkgs._1password-gui "op-ssh-sign";
		};
	};

	programs.git = {
		userEmail = "mail@sushy.dev";
		userName = "SushyDev";
		signing.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIImyhNk+raDf5TXHFWOyWIKw8IQapkhwJ5e+iLQydSFR";
	};

	programs.ssh = {
		enable = true;
		extraConfig = 
			let
				onePassPath = "~/.1password/agent.sock";
			in
			"
				Host *
					IdentityAgent ${onePassPath}
			";
	};

	home.packages = [];

	# The state version is required and should stay at the version you
	# originally installed
	home.stateVersion = "25.05";
}
