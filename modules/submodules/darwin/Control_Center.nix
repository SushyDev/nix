{ self, setup, ... }:
{
	system.defaults = {
		NSGlobalDomain = {
			# Automatically hide and show the menu bar - In Full Sreen Only
			_HIHideMenuBar = false;
		};

		CustomUserPreferences = {
			"~${setup.primaryUser}/Library/Preferences/ByHost/com.apple.controlcenter" = {
				# Other Modules > Accessibility Shortcuts
				# Show in Menu Bar = Off
				# Show in Control Center = Off
				"AccessibilityShortcuts" = 0;

				# Control Center Modules
				# Don't Show in Menu Bar
				"AirDrop" = 24;

				# Other Modules > Battery
				# Show in Menu Bar = On
				# Show in Control Center = Off
				"Battery" = 24; 

				# Other Modules > Battery
				# Show Percentage = On
				"BatteryShowPercentage" = 1;

				# Control Center Modules
				# Show When Active
				"Display" = 2;

				# Control Center Modules
				# Don't Show in Menu Bar
				"FocusModes" = 24;

				# Other Modules > Hearing
				# Show in Menu Bar = Off
				# Show in Control Center = Off
				"Hearing" = 0;

				# Other Modules > Keyboard Brightness
				# Show in Menu Bar = Off
				# Show in Control Center = On
				"KeyboardBrightness" = 1;

				# Other Modules > Music Recognition
				# Show in Menu Bar = Off
				# Show in Control Center = Off
				"MusicRecognition" = 0;

				# Control Center Modules
				# Don't Show in Menu Bar
				"NowPlaying" = 8;

				# Control Center Modules
				# Show When Active
				"ScreenMirroring" = 3;

				# Menu Bar Only > Siri
				# Don't Show in Menu Bar
				"Siri" = 8;

				# Control Center Modules
				# Don't Show in Menu Bar
				"Sound" = 8;

				# Other Modules > Fast User Switching
				# Show in Menu Bar = Don't Show
				# Show in Control Center = On
				"UserSwitcher" = 1;

				# ???
				"VoiceControl" = 8;

				# Control Center Modules
				# Don't Show in Menu Bar
				"WiFi" = 8;
			};
			"~${setup.primaryUser}/Library/Preferences/ByHost/com.apple.Spotlight" = {
				# Menu Bar Only > Spotlight
				# Don't Show in Menu Bar
				"MenuItemHidden" = 1;
			};
			"~${setup.primaryUser}/Library/Preferences/ByHost/com.apple.Siri" = {
				# Menu Bar Only > Siri
				# Don't Show in Menu Bar
				"StatusMenuVisible" = 0;
			};
		};
	}; 
}
