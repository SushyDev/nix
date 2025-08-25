{ config, lib }:
let
	users = config.nix-plist-manager.users;

	mappings = user: {
		"/Library/Preferences" = {
		};
		"~${user}/Library/Preferences" = {
		};
		"~${user}/Library/Preferences/ByHost" = {
			"com.apple.controlcenter" = {
				"WiFi" = config.nix-plist-manager.systemSettings.controlCenter.WiFi;
			};
		};
	};
in
{
	system.activationScripts.defaults.text =
		let
			defaultsWrite = domain: key: value: 
				let
					stringifyValue = value: if lib.typeOf value == "bool" then lib.boolToString value else builtins.toString value;

					valueType = lib.typeOf value;
					valueStr = lib.escapeShellArg (stringifyValue value);
				in
				"defaults write ${domain} ${key} -${valueType} ${valueStr}";

			defaultsWriteAsUser = user: domain: key: value: 
				let
					runAsUser = user: cmd: ''launchctl asuser "$(id -u -- ${user})" sudo --user=${user} -- ${cmd}'';
				in
				runAsUser user (defaultsWrite domain key value);

			generateCommand = user: path: domainName: settingName: settingValue:
				let
					domain = "${path}/${domainName}";
				in
				if domainName == "/Library/Preferences"
					then (defaultsWrite domain settingName settingValue)
					else (defaultsWriteAsUser user domain settingName settingValue);

			isNotNull = attrs:
				lib.filterAttrs (name: value: !builtins.isNull value) attrs;

			forEachSettings = user: path: domainName: settings:
				lib.mapAttrsToList (settingName: settingValue: generateCommand user path domainName settingName settingValue) (isNotNull settings);

			forEachPath = user: path: domains:
				lib.mapAttrsToList (domainName: settings: forEachSettings user path domainName settings) (isNotNull domains);

			forEachMapping = user: mapping:
				lib.mapAttrsToList (path: domains: forEachPath user path domains) (isNotNull mapping);

			forEachUser = users:
				lib.map (user: forEachMapping user (mappings user)) users;

			commands = lib.flatten (forEachUser users);
		in
		''
			echo '${lib.concatStringsSep "\n" commands}' > /Users/sushy/plist-manager-log.txt
			${lib.concatStringsSep "\n" commands}

			killall Finder "System Settings" Dock SystemUIServer
		'';
}
