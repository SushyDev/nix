{
	services.nix-plist-manager = {
		enable = true;

		options = {
			systemSettings = {
				general = {
					softwareUpdate = {
						automaticallyDownloadNewUpdatesWhenAvailable = true;
					};
				};
			};
		};
	};
}
