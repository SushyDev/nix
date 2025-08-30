{
	description = "A very basic flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
		sushypkgs.url = "github:SushyDev/nixpkgs?ref=master";

		nix-darwin = {
			url = "github:nix-darwin/nix-darwin/master";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# Include your custom flake locally
		nix-plist-manager = {
			url = "git+file:///Users/sushy/Documents/Projects/nix-plist-manager";
			inputs.nixpkgs.follows = "nixpkgs";
			# For remote flakes, you would use:
			# url = "github:your-username/your-repo";
		};
	};

	outputs = inputs@{ self, nixpkgs, sushypkgs, nix-darwin, nix-plist-manager, ... }: 
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
					nix-plist-manager.darwinModules.default
					./configuration.nix
					./modules/darwin.nix
					./modules/plist-manager.nix
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
