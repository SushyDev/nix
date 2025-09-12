{ config, lib, pkgs, ... }:
{
	imports = [
		./system/default.nix
	];

	environment.systemPackages = [
		pkgs.git
			pkgs.tmux
			pkgs.fnm
			pkgs.neovim
			pkgs.fzf
			pkgs.opencode
			pkgs.qemu
			pkgs.difftastic
			pkgs.gnumake

			pkgs.ntfs3g
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
}
