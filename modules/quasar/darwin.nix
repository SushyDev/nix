{ self, lib, pkgs, setup, ... }:
{
	users.groups."${setup.nixGroupName}" = {
		name = setup.nixGroupName;
		gid = setup.nixGroupId;
		members = setup.managedUsers;
	};

	users.knownGroups = [ setup.nixGroupName ];

	users.users.sushy = {
		home = "/Users/sushy";
		createHome = true;
		isHidden = false;
		uid = 502;
		shell = pkgs.zsh;
	};

	users.users.work = {
		home = "/Users/work";
		createHome = true;
		isHidden = false;
		uid = 501;
		shell = pkgs.zsh;
	};

	users.knownUsers = setup.managedUsers ++ [];

	system.activationScripts.extraActivation.text = lib.mkAfter ''
		mkdir -p ${setup.systemFlakePath}
		chown -R root:nix ${setup.systemFlakePath}
		chmod -R g+rwX ${setup.systemFlakePath}
	'';

	environment.shellAliases = {
		darwin-switch = "sudo ${lib.getExe pkgs.nix} run nix-darwin/master#darwin-rebuild -- switch --flake ${setup.systemFlakePath}";
		darwin-update = "sudo ${lib.getExe pkgs.nix} flake update --flake ${setup.systemFlakePath}";
		darwin-edit = "${lib.getExe pkgs.neovim} ${setup.systemFlakePath}";
	};

	security.sudo.extraConfig = ''
		%nix ALL=(ALL) NOPASSWD: ${lib.getExe pkgs.nix} run nix-darwin/master\#darwin-rebuild -- switch --flake ${setup.systemFlakePath}
		%nix ALL=(ALL) NOPASSWD: ${lib.getExe pkgs.nix} flake update --flake ${setup.systemFlakePath}
	'';

	environment.pathsToLink = [ 
		"/share/zsh"
	];

	time.timeZone = "Europe/Amsterdam";

	system.primaryUser = lib.head setup.managedUsers;
	system.stateVersion = 6;
	system.startup.chime = false;

	# Used for backwards compatibility, please read the changelog before changing.
	# $ darwin-rebuild changelog
}
