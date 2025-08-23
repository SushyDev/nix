{ self, pkgs, ... }: {
	environment.shellAliases = {
		cat = "bat --paging=never --style=plain";
		ls = "eza";
	};

	environment.systemPackages = [
		pkgs.ripgrep
		pkgs.eza
		pkgs.bat
		pkgs.fd
	];
}
