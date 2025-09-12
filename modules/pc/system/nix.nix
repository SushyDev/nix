{ pkgs, ... }:
{
	nix = {
		settings = {
			experimental-features = [
				"nix-command"
				"flakes"
			];
		};
	};

	programs.nix-ld.enable = true;
	programs.nix-ld.libraries = [
		pkgs.fnm
	];
}
