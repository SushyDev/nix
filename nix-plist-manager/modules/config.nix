{ config, lib }:
let
	customLib = import ../lib { inherit lib; };
in
{
	system.activationScripts.defaults.text =
		let
			users = config.nix-plist-manager.users;

			commands = lib.flatten (lib.mapAttrsToList (type: domainSettings:
				let
					# Stringify value for `defaults write ... -{type} {value}`
					stringifyValue = value: if lib.typeOf value == "bool" then lib.boolToString value else builtins.toString value;

					# Defaults write command
					defaultsWrite = domain: key: value: ''defaults write ${domain} ${key} -${lib.typeOf value} ${lib.escapeShellArg (stringifyValue value)}'';

					# Run command as user
					runAsUser = user: cmd: ''launchctl asuser "$(id -u -- ${user})" sudo --user=${user} -- ${cmd}'';

					# Full command to write a value for a user
					defaultsWriteAsUser = user: domain: key: value: runAsUser user (defaultsWrite domain key value);

					getDomainPath = user: domain:
						if type == "system" then "/Library/Preferences/${domain}"
						else if type == "user" then "~${user}/Library/Preferences/${domain}"
						else if type == "userByHost" then "~${user}/Library/Preferences/ByHost/${domain}"
						else throw "Unknown defaults type: ${type}";

					generateDefaultsCommands = user: domain: settings:
						let
							nonNullSettings = lib.filterAttrs (name: value: !builtins.isNull value) settings;
							domainPath = getDomainPath user domain;
						in
						lib.mapAttrsToList (key: value: if type == "system" 
								then (defaultsWrite domainPath key value)
								else (defaultsWriteAsUser user domainPath key value)
						) nonNullSettings;

						defaultsCommands = lib.flatten (lib.mapAttrsToList (
							domain: settings: lib.map (user: generateDefaultsCommands user domain settings) users
						) domainSettings);
				in
				defaultsCommands
			) config.nix-plist-manager.defaults);
		in
		''
			echo '${lib.concatStringsSep "\n" commands}' > /Users/sushy/plist-manager-log.txt
			${lib.concatStringsSep "\n" commands}

			killall Finder "System Settings" Dock SystemUIServer
		'';
}
