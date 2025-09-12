{ pkgs, inputs, ... }: 
{
	imports = [
		inputs.nix-plist-manager.homeManagerModules.default
		../../../shared/users/shared/dotfiles.nix
	];

	home.packages = [ 
		pkgs.slack
		pkgs.phpstorm
		pkgs.orbstack
		pkgs.glab
	];

	programs.nix-plist-manager = {
		enable = true;

		options.systemSettings = {
			controlCenter = {
				wifi = false;
			};

			appearance = {
				appearance = "Dark";
			};
		};
	};

	# The state version is required and should stay at the version you
	# originally installed.
	home.stateVersion = "25.05";
}
