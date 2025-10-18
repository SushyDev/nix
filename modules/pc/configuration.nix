{ config, lib, pkgs, ... }:
{
	imports = [
		./system/default.nix
		../shared/oxidation.nix
		# ./hardon.nix 
	];

	environment.systemPackages = [
		# pkgs.opencode
		pkgs.qemu
		pkgs.ntfs3g
		pkgs.cage
		pkgs.ghostty
	];

	services.openssh = {
		enable = true;
		ports = [22];
		extraConfig = "UsePrivilegeSeparation sandbox";
	};

	services.tlp.enable = false;
	services.printing.enable = false;
	services.blueman.enable = false;

	security.sudo.wheelNeedsPassword = false;

	nixpkgs.config.allowUnfree = true;

	virtualisation.docker.enable = true;
	virtualisation.docker.rootless = {
		enable = true;
		setSocketVariable = true;
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
