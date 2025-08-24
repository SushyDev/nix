{
	description = "A very basic flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

		nix-darwin = {
			url = "github:nix-darwin/nix-darwin/master";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs@{ self, nixpkgs, nix-darwin, ... }: 
		{
			# Rename default to hostname later
			darwinConfigurations."quasar" = nix-darwin.lib.darwinSystem {
				specialArgs = { 
					inherit inputs; 
					setup = rec {
						primaryUser = "sushy";
						managedUsers = [ primaryUser ];
						managedUsersAndRoot = [ "root" ] ++ managedUsers;
						nixGroupName = "nix";
						nixGroupId = 503;
						systemFlakePath = "/etc/nixdarwin";
					};
				};
				system = "aarch64-darwin";
				modules = [ 
					./configuration.nix
					./modules/darwin.nix
					./modules/oxidation.nix
					# home-manager.darwinModules.home-manager
					# {
					# 	home-manager.useGlobalPkgs = true;
					# 	home-manager.useUserPackages = true;
					# 	home-manager.users.sushy = import ./home.nix;
					# }
				];
			};

		};
}
