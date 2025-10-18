{ pkgs, ... }:
{
	boot = {
		loader.systemd-boot.enable = true;
		loader.efi.canTouchEfiVariables = true;
		tmp.cleanOnBoot = true;

		kernelParams = [
			"pci=acpi"
			"quiet"
			"splash"
			"udev.log_level=3"
			"systemd.show_status=auto"
			"rd.udev.log_level=3"
		];
		blacklistedKernelModules = [ "nouveau" ];
		kernelPackages = pkgs.linuxPackages_latest;
	};

	hardware = {
		bluetooth.enable = true;

		nvidia = {
			open = true;
			modesetting.enable = true;
		};
		graphics.enable = true;
	};

	nixpkgs.config.allowUnfree = true;
	services.xserver.videoDrivers = [ "nvidia" ];
}
