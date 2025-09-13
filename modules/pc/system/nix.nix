{ pkgs, ... }:
{
	nix = {
		gc = {
			automatic = true;
			dates = "daily";
			options = "--delete-older-than 3d";
		};
		settings = {
			experimental-features = [ "nix-command" "flakes" ];
		};
	};

	programs.nix-ld.enable = true;
	programs.nix-ld.libraries = [ pkgs.fnm ];
}
