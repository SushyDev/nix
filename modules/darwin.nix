{ self, lib, pkgs, setup, ... }:
{
	users.knownGroups = [ setup.nixGroupName ];

	users.groups."${setup.nixGroupName}" = {
		name = setup.nixGroupName;
		gid = setup.nixGroupId;
		members = setup.managedUsers;
	};

	system.activationScripts.setupNixDarwinDirectory = {
		enable = true;
		text = ''
			mkdir -p ${setup.systemFlakePath}
			chown -R root:nix ${setup.systemFlakePath}
			chmod -R g+rwX ${setup.systemFlakePath}
		'';
	};

	environment.shellAliases = {
		darwin-switch = "sudo ${lib.getExe pkgs.nix} run nix-darwin/master#darwin-rebuild -- switch --flake ${setup.systemFlakePath}";
		darwin-edit = "${lib.getExe pkgs.neovim} ${setup.systemFlakePath}";
	};

	security.sudo.extraConfig = ''
		%nix ALL=(ALL) NOPASSWD: ${pkgs.nix}/bin/nix run nix-darwin/master\#darwin-rebuild -- switch --flake ${setup.systemFlakePath}
	'';

	time.timeZone = "Europe/Amsterdam";

	system.primaryUser = setup.primaryUser;

	# Used for backwards compatibility, please read the changelog before changing.
	# $ darwin-rebuild changelog

	# imports = [
	# 	./submodules/darwin/Appearance.nix
	# 	./submodules/darwin/Control_Center.nix
	# 	./submodules/darwin/Desktop_And_Dock.nix
	# 	./submodules/darwin/General.nix
	# 	./submodules/darwin/Keyboard.nix
	# 	./submodules/darwin/Trackpad.nix
	# ];
}
