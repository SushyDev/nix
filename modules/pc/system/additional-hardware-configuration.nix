{ pkgs, ... }:
{
	boot = {
		loader.systemd-boot.enable = true;
		loader.efi.canTouchEfiVariables = true;

		kernelParams = [ "pci=acpi"];
		blacklistedKernelModules = [ "nouveau" ];
		kernelPackages = pkgs.linuxPackages_latest;
	};

	hardware = {
		nvidia = {
			open = true;
			modesetting.enable = true;
		};
		graphics.enable = true;
	};

	nixpkgs.config.allowUnfree = true;
	services.xserver.videoDrivers = [ "nvidia" ];
}
