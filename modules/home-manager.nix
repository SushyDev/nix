{ config, pkgs, ... }:
{
	home-manager.useGlobalPkgs = true;
	home-manager.useUserPackages = true;
	home-manager.users.sushy = import ./modules/user/sushy/configuration.nix;
	home-manager.users.work = import ./modules/user/work/configuration.nix;
}
