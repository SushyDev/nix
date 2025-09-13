{ setup, ... }:
{
	imports = [ 
		./nix.nix
		./networking.nix
		./users-and-groups.nix

		./hardware-configuration.nix
		./additional-hardware-configuration.nix
	];

	system.activationScripts.setupSystemFlake = {
		text = ''
			mkdir -p ${setup.systemFlakePath}
			chown -R root:nix ${setup.systemFlakePath}
			chmod -R g+rwX ${setup.systemFlakePath}
		'';
	};

	time.timeZone = "Europe/Amsterdam";

	programs.nano.enable = false;

	system.stateVersion = "25.05";
}
