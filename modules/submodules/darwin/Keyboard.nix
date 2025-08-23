{ self, lib, pkgs, cfg, config, ... }:
{
	system.defaults = {
		NSGlobalDomain = {
			KeyRepeat = 2;
			InitialKeyRepeat = 30;

			# Keyboard Shortcuts... > Function Keys
			# Use F1, F2, etc. keys as standard function keys - On
			"com.apple.keyboard.fnState" = true;
		};
	}; 
}
