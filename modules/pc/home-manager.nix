{ config, inputs, pkgs, setup, ... }:
{
	programs.zsh.enable = true;

	system.activationScripts.setupSystemFlake = {
		text = ''
			mkdir -p ${setup.systemFlakePath}
			chown -R root:nix ${setup.systemFlakePath}
			chmod -R g+rwX ${setup.systemFlakePath}
		'';
	};

	home-manager.useGlobalPkgs = true;
	home-manager.useUserPackages = true;
	home-manager.extraSpecialArgs = {
		inherit inputs;
	};
	home-manager.users.sushy = import ./users/sushy/configuration.nix;
}
