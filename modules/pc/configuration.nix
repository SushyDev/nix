{ config, lib, pkgs, ... }:
{
	imports = [
		./system/default.nix
		../shared/oxidation.nix
		# ./hardon.nix
		./system/kde.nix
	];

	environment.systemPackages = [
		# pkgs.opencode
		pkgs.qemu
		pkgs.ntfs3g
		pkgs.ghostty
		pkgs.vivaldi
		pkgs.discord
		pkgs.spotify
	];

	
	programs._1password.enable = true;
	programs._1password-gui = {
		enable = true;
		# Certain features, including CLI integration and system authentication support,
		# require enabling PolKit integration on some desktop environments (e.g. Plasma).
		polkitPolicyOwners = [ "sushy" ];
	};

	environment.etc = {
		"1password/custom_allowed_browsers" = {
			text = ''
				vivaldi-bin
			'';
			mode = "0755";
		};
	};

	services.openssh = {
		enable = true;
		ports = [ 22 ];
		extraConfig = "UsePrivilegeSeparation sandbox";
	};

	services.tlp.enable = false;
	services.printing.enable = false;
	services.blueman.enable = false;

	security.sudo.wheelNeedsPassword = false;

	nixpkgs.config.allowUnfree = true;

	virtualisation.docker = {
		enable = true;
		rootless = {
			enable = true;
			setSocketVariable = true;
		};
	};

	systemd.services.systemd-udev-settle.enable = false;
	systemd.services.NetworkManager-wait-online.enable = false;
	virtualisation.docker.enableOnBoot = false;

	programs.fuse.userAllowOther = true;
	programs.zsh.enable = true;

	i18n.defaultLocale = "en_US.UTF-8";
	console.earlySetup = true;
	fonts.packages = [ pkgs.fira-code ];
}
