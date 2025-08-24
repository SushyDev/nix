{ self, lib, setup, ... }:
{
	system.defaults = {
		SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;

		NSGlobalDomain = {
			AppleSpacesSwitchOnActivate = true;
			NSNavPanelExpandedStateForSaveMode = true;
			NSNavPanelExpandedStateForSaveMode2 = true;
			AppleICUForce24HourTime = true;
			AppleShowAllExtensions = true;
			ApplePressAndHoldEnabled = false;
			"com.apple.springing.delay" = 0.5;
			"com.apple.springing.enabled" = true;
		};

		CustomUserPreferences = lib.attrsets.mergeAttrsList (lib.map (user: {
			"~${user}/Library/Preferences/ByHost/.GlobalPreferences" = {
				"AppleMiniaturizeOnDoubleClick" = 0;
			};
			"~${user}/Library/Preferences/ByHost/com.apple.assistant.support" = {
				# Spotlight
				# Help Apple Improve Search - Off
				"Search Queries Data Sharing Status" = 2;

				# I assume this turns off Siri Data collection just like with Spotlight above
				"Siri Data Sharing Opt-In Status" = 2;
			};
		}) setup.managedUsers);
	};
}
