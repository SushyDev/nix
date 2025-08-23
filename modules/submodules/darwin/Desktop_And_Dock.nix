{ self, lib, pkgs, cfg, config, ... }:
{
	system.defaults = {
		NSGlobalDomain = {
			# Windows > Prefer tabs when opening documents
			# In Full Screen
			AppleWindowTabbingMode = "fullscreen";
		};

		CustomUserPreferences = {
			"~${config.system.primaryUser}/Library/Preferences/ByHost/.GlobalPreferences" = {
				# Double-click a window's title bar to
				"AppleActionOnDoubleClick" = "Maximize"; # Zoom
			};
		};
	
		# Desktop & Stage Manager
		# Stage Manager - Off
		WindowManager.GloballyEnabled = false;

		# Desktop & Stage Manager
		# Click wallpaper to reveal desktop - Only in Stage Manager
		WindowManager.EnableStandardClickToShowDesktop = false;

		dock = {
			# ???
			autohide-delay = 0.0;
			autohide-time-modifier = 1.0;
			persistent-apps = [];
			persistent-others = [];

			# Size
			tilesize = 48;

			# Magnification
			magnification = false;

			# Automatically hide and show the Dock - On
			autohide = true;

			# Animate opening applications - On
			launchanim = true;

			# Minimize window using - Genie Effect
			mineffect = "genie";

			# Minimize windows into application icon - On
			minimize-to-application = true;

			# Position on screen - Bottom
			orientation = "bottom";

			# Show indicators for open applications - On
			show-process-indicators = true;

			# Show suggested and recent apps in Dock - Off
			show-recents = false;

			# Mission Control
			# Automatically rearrange Spaces based on most recent use - Off
			mru-spaces = false;

			# Hot Corners...
			wvous-tl-corner = 1;
			wvous-bl-corner = 1;
			wvous-tr-corner = 1;
			wvous-br-corner = 1;
		};
	}; 
}
