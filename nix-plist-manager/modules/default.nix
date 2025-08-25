{ config, lib, ... }:
{
	options.nix-plist-manager = import ./options.nix { inherit lib; inherit config; };
	config = lib.mkIf config.nix-plist-manager.enable (import ./config-by-mapping.nix { inherit config lib; });
}
