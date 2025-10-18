{ config, lib, pkgs, ... }:
{
	imports = [
		./system/default.nix
		../shared/oxidation.nix
		./desktop-manager/kde.nix
		# ./hardon.nix
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

	# 1 Password

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

	# SSH

	services.openssh = {
		enable = true;
		ports = [ 22 ];
		extraConfig = "UsePrivilegeSeparation sandbox";
	};

	# Debloat and system configuration

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

	# Enable zram for better memory management
	zramSwap.enable = true;
	zramSwap.algorithm = "zstd";

	programs.fuse.userAllowOther = true;
	programs.nano.enable = false;
	programs.nix-index.enable = true;
	programs.zsh.enable = true;

	# Enable earlyoom for better memory management
	services.earlyoom.enable = true;

	# Enable fstrim for SSD optimization
	services.fstrim.enable = true;

	i18n.defaultLocale = "en_US.UTF-8";
	console.earlySetup = true;
	fonts.packages = [ pkgs.fira-code ];

	time.timeZone = "Europe/Amsterdam";

	system.stateVersion = "25.05";
}
