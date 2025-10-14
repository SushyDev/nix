{ self, config, pkgs, nixpkgs, sushy, base, inputs, system, ... }:
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
	imports = [
		./darwin.nix
		./plist-manager-v2.nix
		../shared/oxidation.nix
	];

	nixpkgs.overlays = [ inputs.nix-darwin-apps.overlays.default ];
	nixpkgs.config.allowUnfree = true;

	# List packages installed in system profile. To search by name, run:
	# $ nix-env -qaP | grep wget
	environment.systemPackages = [
		# pkgs.opencode
		# pkgs.qemu

		pkgs.openssh
		# pkgs.stow

		# My own overlay
		# # pkgs.cloudflare-warp-gui
		# # pkgs.google-chrome-canary
		pkgs.dbeaver
		pkgs.ghostty
		pkgs.orbstack
		pkgs.setapp
		pkgs.spotify
		pkgs.vivaldi

		# In nixpkgs
		pkgs._1password-gui-beta
		pkgs.raycast
		# pkgs.firefox
		pkgs.obsidian

		# sushypkgs.ddev
		pkgs.ddev

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
