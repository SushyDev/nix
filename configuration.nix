{ self, pkgs, nixpkgs, sushy, base, inputs, system, ... }:
let
	sushypkgs = 
		let
			ddevOverride = self: super: oldAttrs: {
				nativeBuildInputs = oldAttrs.nativeBuildInputs or [] ++ [ super.makeWrapper ];

				postInstall = ''
					${oldAttrs.postInstall or ""}
					wrapProgram $out/bin/ddev \
					--set MUTAGEN_DATA_DIRECTORY $HOME/.ddev/mutagen_data
				'';
			};

			ddevOverlay = self: super: {
				ddev = super.ddev.override super.ddev.overrideAttrs (oldAttrs: ddevOverride self super oldAttrs);
			};
		in
		import inputs.sushypkgs {
			system = "aarch64-darwin";
			config = {
				allowUnfree = true;
			};
			overlays = [ ddevOverlay ];
		};

in
{
	nixpkgs.overlays = [ inputs.nix-darwin-apps.overlays.default ];
	nixpkgs.config.allowUnfree = true;

	# List packages installed in system profile. To search by name, run:
	# $ nix-env -qaP | grep wget
	environment.systemPackages = [
		pkgs.git
		pkgs.tmux
		pkgs.fnm
		pkgs.neovim
		pkgs.fzf
		pkgs.glab
		pkgs.opencode
		pkgs.qemu
		pkgs.difftastic

		pkgs.openssh
		pkgs.stow

		# My own overlay
		pkgs.vivaldi
		pkgs.ghostty
		pkgs.spotify
		pkgs.setapp
		pkgs.orbstack
		pkgs.google-chrome-canary
		# pkgs.cloudflare-warp-gui

		# In nixpkgs
		pkgs._1password-gui-beta
		pkgs.raycast
		pkgs.firefox

		# sushypkgs.ddev

		# inputs.nix-darwin-apps.packages.${system}.vivaldi
	];

	# NOT SURE IF THIS IS ACTIVE NO DS NIX
	# Necessary for using flakes on this system.
	nix = {
		enable = false;
		package = pkgs.nixVersions.stable;
		settings.experimental-features = "nix-command flakes";
		settings.trusted-users = base.managedUsersAndRoot;
	};
}
