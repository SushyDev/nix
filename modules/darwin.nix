{ self, lib, pkgs, config, ... }:
let
	nixGroupName = "nix";
	primaryUser = "sushy";
	managedUsers = [ primaryUser ];
in
{
	users.knownGroups = [ nixGroupName ];

	users.groups."${nixGroupName}" = {
		name = nixGroupName;
		gid = 503;
		members = managedUsers;
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

	# System settings config
	system.primaryUser = primaryUser;

	imports = [
		./submodules/darwin/Appearance.nix
		./submodules/darwin/Control_Center.nix
		./submodules/darwin/Desktop_And_Dock.nix
		./submodules/darwin/General.nix
		./submodules/darwin/Keyboard.nix
		./submodules/darwin/Trackpad.nix
	];
}
