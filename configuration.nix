{ self, pkgs, base, ... }: {

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

	# NOT SURE IF THIS IS ACTIVE NO DS NIX
	# Necessary for using flakes on this system.
	nix.enable = false;
	nix.package = pkgs.nixVersions.stable;
	nix.settings.experimental-features = "nix-command flakes";
	nix.settings.trusted-users = base.managedUsers ++ [ "root" ];
}
