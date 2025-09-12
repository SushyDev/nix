{ pkgs, ... }:
{
	imports = [ 
		./nix.nix
		./networking.nix
		./users-and-groups.nix

		./hardware-configuration.nix
		./additional-hardware-configuration.nix
	];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.kernelPackages = pkgs.linuxPackages_latest;


	time.timeZone = "Europe/Amsterdam";

	programs.nano.enable = false;

	system.stateVersion = "25.05";
}
