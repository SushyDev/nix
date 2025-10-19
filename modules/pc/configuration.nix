{ setup, config, lib, inputs, pkgs, ... }:
{
	imports = [
		./packages.nix
		./programs.nix
		./security.nix
		./services.nix

		./system/default.nix
		../shared/oxidation.nix
		./desktop-manager/kde.nix
		# ./hardon.nix
	];

	nixpkgs.config.allowUnfree = true;
	i18n.defaultLocale = "en_US.UTF-8";
	console.earlySetup = true;
	time.timeZone = "Europe/Amsterdam";
	system.stateVersion = "25.05";
}
