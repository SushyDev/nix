{ setup, nix-plist-manager, ... }:
{
	nix-plist-manager = {
		enable = true;
		users = setup.managedUsers;

		systemSettings = {
			general = {
				softwareUpdate = {
					automaticallyDownloadNewUpdatesWhenAvailable = true;
					automaticallyInstallMacOSUpdates = true;
					automaticallyInstallApplicationUpdatesFromTheAppStore = true;
					automaticallyInstallSecurityResponseAndSystemFiles = true;

				};
				dateAndTime = {
					"24HourTime" = true;
				};
			};
			appearance = {
				appearance = "dark";
				accentColor = "pink";
				sidebarIconSize = "medium";
				allowWallpaperTintingInWindows = false;
				showScrollBars = "automatic";
				clickInTheScrollBarTo = "jumpToTheNextPage";
			};
			controlCenter = {
				WiFi = false;
				Bluetooth = false;
				AirDrop = false;
				FocusModes = "never";
				StageManager = false;
				ScreenMirroring = "active";
				Display = "never";
				Sound = "never";
				NowPlaying = "never";
				AccessibilityShortcuts = {
					showInMenuBar = false;
					showInControlCenter = false;
				};
				Battery = {
					showInMenuBar = true;
					showInControlCenter = false;
				};
				BatteryShowPercentage = true;
				MusicRecognition = {
					showInMenuBar = false;
					showInControlCenter = false;
				};
				Hearing = {
					showInMenuBar = false;
					showInControlCenter = false;
				};
				FastUserSwitching = {
					showInMenuBar = false;
					showInControlCenter = true;
				};
				KeyboardBrightness = {
					showInMenuBar = false;
					showInControlCenter = false;
				};
				menuBarOnly = {
					spotlight = false;
					siri = false;
				};
				automaticallyHideAndShowTheMenuBar = "In Full Screen Only";
			};
			desktopAndDock = {
				dock = {
					size = 48;
					magnification = {
						enabled = false;
						size = 30;
					};
					positionOnScreen = "bottom";
					minimizeWindowsUsing = "genie";
					doubleClickAWindowsTitleBarTo = "fill";
					minimizeWindowsIntoApplicationIcon = true;
					automaticallyHideAndShowTheDock = {
						enabled = true;
						delay = 0.0;
						duration = 0.0;
					};
					animateOpeningApplications = true;
					showIndicatorsForOpenApplications = true;
					showSuggestedAndRecentAppsInDock = false;
					persistentApps = [
						{ app = "/Applications/Ghostty.app"; }
						{ app = "/Applications/Spotify.app"; }
						{ app = "/Applications/Vivaldi.app"; }
						{ app = "/Users/sushy/Applications/Discord.app"; }
					];
					persistentOthers = [];
				};
				desktopAndStageManager = {
					showItems = {
						onDesktop = false;
						inStageManager = false;
					};
					clickWallpaperToRevealDesktop = "onlyInStageManager";
					stageManager = false;
					showRecentAppsInStageManager = false;
					showWindowsFromAnApplication = "oneAtATime";
				};
				widgets = {
					showWidgets = {
						onDesktop = false;
						inStageManager = false;
					};
					widgetStyle = "automatic";
					useIphoneWidgets = false;
				};
				windows = {
					preferTabsWhenOpeningDocuments = "never";
					askToKeepChangesWhenClosingDocuments = false;
					closeWindowsWhenQuittingAnApplication = false;
					dragWindowsToScreenEdgesToTile = false;
					dragWindowsToMenuBarToFillScreen = false;
					holdOptionKeyWhileDraggingWindowsToTile = false;
					tiledWindowsHaveMargin = false;
				};
				missionControl = {
					automaticallyRearrangeSpacesBasedOnMostRecentUse = false;
					whenSwitchingToAnApplicationSwitchToAspaceWithOpenWindowsForTheApplication = false;
					groupWindowsByApplication = false;
					displaysHaveSeparateSpaces = false;
					dragWindowsToTopOfScreenToEnterMissionControl = false;
				};
				hotCorners = {
					topLeft = "disabled";
					topRight = "disabled";
					bottomLeft = "disabled";
					bottomRight = "disabled";
				};
			};
			# TODO Displays
			# TODO Screen Saver
			spotlight = {
				searchResults = {
					applications = true;
					calculator = true;
					contacts = true;
					conversion = true;
					definition = true;
					developer = true;
					documents = true;
					eventsAndReminders = true;
					folders = true;
					fonts = true;
					images = true;
					mailAndMessages = true;
					movies = true;
					music = true;
					other = true;
					pdfDocuments = true;
					presentations = true;
					siriSuggestions = true;
					spreadsheets = true;
					systemSettings = true;
					tips = true;
					websites = true;
				};
				helpAppleImproveSearch = false;
			};
			notifications = {
				notificationCenter = {
					showPreviews = "whenUnlocked";
					summarizeNotifications = true;
				};
			};
			sound = {
				soundEffects = {
					alertSound = "Sonar";
					alertVolume = 0.5;
					playUserInterfaceSoundEffects = false;
					playFeedbackWhenVolumeIsChanged = false;
				};
			};
			keyboard = {
				keyRepeatRate = 7;
				keyRepeatDelay = 5;
				adjustKeyboardBrightnessInLowLight = false;
				keyboardBrightness = 1.0;
				turnKeyboardBacklightOffAfterInactivity = "After 5 Minutes";
				pressGlobeKeyTo = "Do Nothing";
				keyboardNavigation = false;
				keyboardShortcuts = {
					functionKeys = {
						useF1F2EtcAsStandardFunctionKeys = true;
					};
				};
				dictation = {
					enabled = false;
				};
			};
			trackpad = {
				trackingSpeed = 4;
				click = "Medium";
				forceClickAndHapticFeedback = false;
				tapToClick = false;
			};
		};
		finder = {
			removeItemsFromTheTrashAfter30Days = true;
		};
	};
}
