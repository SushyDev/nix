{
	description = "A very basic flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
		sushypkgs.url = "github:SushyDev/nixpkgs?ref=master";

		nix-darwin = {
			url = "github:nix-darwin/nix-darwin/master";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nix-plist-manager = {
			url = "path:/Users/sushy/Documents/Projects/nix-plist-manager-v2";
			# url = "github:sushydev/nix-plist-manager?ref=main";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nix-darwin-apps = {
			url = "path:/Users/sushy/Documents/Projects/nix-darwin-apps";
			# url = "github:sushydev/nix-darwin-apps?ref=main";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		dotfiles = {
			type = "git";
			url = "ssh://git@github.com/sushydev/dotfiles";
			submodules = true;
		};
	};

	outputs = inputs@{ self, nixpkgs, sushypkgs, nix-darwin, home-manager, nix-plist-manager, ... }: 
		{
			
			nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
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

			# Rename default to hostname later
			darwinConfigurations."quasar" = nix-darwin.lib.darwinSystem rec {
				system = "aarch64-darwin";
				specialArgs = {
					inherit inputs system;
					setup = rec {
						primaryUser = "sushy";
						managedUsers = [ primaryUser "work" ];
						managedUsersAndRoot = [ "root" ] ++ managedUsers;
						nixGroupName = "nix";
						nixGroupId = 503;
						systemFlakePath = "/etc/nixdarwin";
					};
				};
				modules = [
					./modules/quasar/configuration.nix
					./modules/quasar/darwin.nix

					nix-plist-manager.darwinModules.default
					./modules/quasar/plist-manager-v2.nix

					home-manager.darwinModules.home-manager
					./modules/quasar/home-manager.nix
				];
			};
		};
}
