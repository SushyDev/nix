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
		../shared/1password.nix
	];

	dotfiles = {
		enable = true;
		systemFlakePath = setup.systemFlakePath;
		git = {
			sshSignPackage = "${lib.getBin pkgs._1password-gui}/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
		};
		ssh = {
			identityAgentPath = "\"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock\"";
		};
	};

	home.packages = [ 
		pkgs.slack
		pkgs.phpstorm
		pkgs.glab
	];

	# The state version is required and should stay at the version you
	# originally installed.
	home.stateVersion = "25.05";
}
