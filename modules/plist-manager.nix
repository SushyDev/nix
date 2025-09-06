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
				appearance = "Dark";
				accentColor = "Pink";
				sidebarIconSize = "Medium";
				allowWallpaperTintingInWindows = false;
				showScrollBars = "Automatically based on mouse or trackpad";
				clickInTheScrollBarTo = "Jump to the next page";
			};
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
					positionOnScreen = "Bottom";
					minimizeWindowsUsing = "Genie Effect";
					doubleClickAWindowsTitleBarTo = "Fill";
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
						{ app = "/Applications/Nix Apps/Ghostty.app"; }
						{ app = "/Applications/Nix Apps/Spotify.app"; }
						{ app = "/Applications/Nix Apps/Vivaldi.app"; }
						# { app = "/Users/sushy/Applications/Home Manager Apps/Discord.app"; }
					];
					persistentOthers = [ ];
				};
				desktopAndStageManager = {
					showItems = {
						onDesktop = false;
						inStageManager = false;
					};
					clickWallpaperToRevealDesktop = "Only in Stage Manager";
					stageManager = false;
					showRecentAppsInStageManager = false;
					showWindowsFromAnApplication = "One at a Time";
				};
				widgets = {
					showWidgets = {
						onDesktop = false;
						inStageManager = false;
					};
					widgetStyle = "Automatic";
					useIphoneWidgets = false;
				};
				windows = {
					preferTabsWhenOpeningDocuments = "Never";
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
					topLeft = "-";
					topRight = "-";
					bottomLeft = "-";
					bottomRight = "-";
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
					showPreviews = "When Unlocked";
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
				keyboardNavigation = true;
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
		applications = {
			finder = {
				settings = {
					general = {
						showTheseItemsOnTheDesktop = {
							hardDisks = true;
							externalDisks = true;
							cdsDvdsAndiPods = true;
							connectedServers = true;
						};
						openFoldersInTabsInsteadOfNewWindows = true;
					};
					sidebar = {
						recentTags = false;
					};
					advanced = {
						showAllFilenameExtensions = true;
						showWarningBeforeChangingAnExtension = true;
						showWarningBeforeEmptyingTheTrash = true;
						showWarningBeforeRemovingFromiCloudDrive = true;
						removeItemsFromTheTrashAfter30Days = true;
						keepFoldersOnTop = {
							inWindowsWhenSortingByName = true;
							onDesktop = true;
						};
						whenPerformingASearch = "Search the Current Folder";
					};
				};
				menuBar = {
					view = {
						showTabBar = true;
						showSidebar = true;
						showPathBar = true;
						showStatusBar = true;
					};
				};
			};
		};
	};
}
