{ self, lib, pkgs, ... }: {

	# List packages installed in system profile. To search by name, run:
	# $ nix-env -qaP | grep wget
	environment.systemPackages = [
		pkgs.vim
		pkgs.tmux
		pkgs.git
		pkgs.fnm
		pkgs.neovim
		pkgs.fzf
		pkgs.glab
		pkgs.opencode
		pkgs.qemu
		pkgs.difftastic
		pkgs.go
		pkgs.utm
	];


	# Used for backwards compatibility, please read the changelog before changing.
	# $ darwin-rebuild changelog
	system.stateVersion = 6;

	# NOT SURE IF THIS IS ACTIVE NO DS NIX
	# Necessary for using flakes on this system.
	nix.enable = false;
	nix.package = pkgs.nixVersions.stable;
	nix.settings.experimental-features = "nix-command flakes";
	nix.settings.trusted-users = [ "sushy" "root" ];

	# The platform the configuration will be used on.
	# nixpkgs.hostPlatform = "aarch64-darwin";

	# Set Git commit hash for darwin-version.
	#system.configurationRevision = self.rev or self.dirtyRev or null;

	# Set Git commit hash for darwin-version.
	#system.configurationRevision = self.rev or self.dirtyRev or null;
}
