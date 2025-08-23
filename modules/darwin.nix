{ self, pkgs, setup, ... }:
{
	users.knownGroups = [ setup.nixGroupName ];

	users.groups."${setup.nixGroupName}" = {
		name = setup.nixGroupName;
		gid = 503;
		members = setup.managedUsers;
	};

	system.activationScripts.setupNixDarwinDirectory = {
		enable = true;
		text = ''
			mkdir -p /etc/nixdarwin
			chown -R root:nix /etc/nixdarwin
			chmod -R g+rwX /etc/nixdarwin
		'';
	};

	environment.shellAliases = {
		darwin-rebuild = "sudo ${pkgs.nix}/bin/nix run nix-darwin/master#darwin-rebuild -- switch --flake /etc/nixdarwin";
		darwin-edit = "${pkgs.neovim}/bin/nvim /etc/nixdarwin";
	};

	security.sudo.extraConfig = ''
		%nix ALL=(ALL) NOPASSWD: ${pkgs.nix}/bin/nix run nix-darwin/master\#darwin-rebuild -- switch --flake /etc/nixdarwin
	'';

	time.timeZone = "Europe/Amsterdam";

	system.primaryUser = setup.primaryUser;

	# Used for backwards compatibility, please read the changelog before changing.
	# $ darwin-rebuild changelog
	system.stateVersion = 6;

	imports = [
		./submodules/darwin/Appearance.nix
		./submodules/darwin/Control_Center.nix
		./submodules/darwin/Desktop_And_Dock.nix
		./submodules/darwin/General.nix
		./submodules/darwin/Keyboard.nix
		./submodules/darwin/Trackpad.nix
	];
}
