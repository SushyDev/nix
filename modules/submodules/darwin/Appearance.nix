{ self, lib, pkgs, cfg, config, ... }:
{
	system.defaults = {
		NSGlobalDomain = {
			# Appearance
			# Dark
			AppleInterfaceStyle = "Dark";

			# Show scroll bars
			# Automatically based on mouse or trackpad
			AppleShowScrollBars = "Automatic";

			# Click in the scroll bar to
			# Jump to the next page
			AppleScrollerPagingBehavior = false;

			# Sidebar icon size
			# Medium
			NSTableViewDefaultSizeMode = 2;
		};

		CustomUserPreferences = {
			"~${config.system.primaryUser}/Library/Preferences/ByHost/.GlobalPreferences" = {
				# Accent color
				# Pink
				"AppleAccentColor" = 6;

				# Allow wallpaper tinting in windows
				"AppleReduceDesktopTinting" = 1;
			};
		};
	}; 
}
