{
	description = "A very basic flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
		determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/3.11.3";

		nix-darwin = {
			url = "github:nix-darwin/nix-darwin/master";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nix-plist-manager = {
			# url = "path:/Users/sushy/Documents/Projects/nix-plist-manager-v2";
			url = "github:sushydev/nix-plist-manager?ref=main";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nix-darwin-apps = {
			# url = "path:/Users/sushy/Documents/Projects/nix-darwin-apps";
			url = "github:sushydev/nix-darwin-apps?ref=main";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		dotfiles = {
			# url = "path:/Users/sushy/Documents/Projects/dotfiles";
			type = "git";
			url = "https://github.com/sushydev/dotfiles";
			submodules = true;
		};
	};

	outputs = inputs@{ self, nixpkgs, determinate, nix-darwin, home-manager, nix-plist-manager, ... }: 
		let
			systemPc = rec {
				system = "x86_64-linux";
				specialArgs = {
					inherit inputs;
					setup = rec {
						primaryUser = "sushy";
						managedUsers = [ primaryUser ];
						managedUsersAndRoot = [ "root" ] ++ managedUsers;
						nixGroupMembers = [ primaryUser ];
						nixGroupName = "nix";
						nixGroupId = 101;
						systemFlakePath = "/etc/nixos";	
					};
				};
				modules = [
					./modules/pc/configuration.nix

					home-manager.nixosModules.home-manager
					./modules/pc/home-manager.nix
				];
			};

			systemQuasar = rec {
				system = "aarch64-darwin";
				specialArgs = {
					inherit inputs system;
					setup = rec {
						primaryUser = "sushy";
						managedUsers = [ primaryUser "work" ];
						managedUsersAndRoot = [ "root" ] ++ managedUsers;
						nixGroupName = "nix";
						nixGroupId = 503;
						systemFlakePath = "/private/etc/nixdarwin";
					};
				};
				modules = [
					./modules/quasar/configuration.nix

					determinate.darwinModules.default
					./modules/quasar/determinate.nix

					nix-plist-manager.darwinModules.default
					./modules/quasar/plist-manager.nix

					home-manager.darwinModules.home-manager
					./modules/quasar/home-manager.nix
				];
			};
		in
		{
			nixosConfigurations.pc = nixpkgs.lib.nixosSystem systemPc;
			darwinConfigurations.quasar = nix-darwin.lib.darwinSystem systemQuasar;
		};
}
