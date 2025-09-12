{ pkgs, inputs, ... }:
{
	imports = [
		inputs.nix-plist-manager.homeManagerModules.default
		../../../shared/users/shared/dotfiles.nix
	];

	home.packages = [ 
		pkgs.go
		pkgs.utm
		pkgs.discord
		pkgs.blender
		pkgs.ollama
	];

 	programs.git = {
 		userEmail = "mail@sushy.dev";
 		userName = "SushyDev";
 		signing.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIImyhNk+raDf5TXHFWOyWIKw8IQapkhwJ5e+iLQydSFR";
 	};

	programs.nix-plist-manager = {
		enable = true;

		options.systemSettings = {
			controlCenter = {
				wifi = false;
				bluetooth = false;
				airdrop = false;
				focusModes = "never";
				stageManager = false;
				screenMirroring = "active";
				display = "never";
				sound = "never";
				nowPlaying = "never";
				accessibilityShortcuts = {
					showInMenuBar = false;
					showInControlCenter = false;
				};
				battery = {
					showInMenuBar = true;
					showInControlCenter = false;
				};
				batteryShowPercentage = true;
				musicRecognition = {
					showInMenuBar = false;
					showInControlCenter = false;
				};
				hearing = {
					showInMenuBar = false;
					showInControlCenter = false;
				};
				fastUserSwitching = {
					showInMenuBar = false;
					showInControlCenter = true;
				};
				keyboardBrightness = {
					showInMenuBar = false;
					showInControlCenter = false;
				};
				# menuBarOnly = {
				# 	spotlight = false;
				# 	siri = false;
				# };
				# automaticallyHideAndShowTheMenuBar = "In Full Screen Only";
			};

			appearance = {
				appearance = "Dark";
			};
		};
	};

	# The state version is required and should stay at the version you
	# originally installed.
	home.stateVersion = "25.05";
}
