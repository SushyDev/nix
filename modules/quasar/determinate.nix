{ self, nixpkgs, determinate-nix, setup, ... }:
{
	nix.enable = false;

	determinate-nix.customSettings = {
		# flake-registry = "/etc/nix/flake-registry.json";
		experimental-features = "nix-command flakes external-builders";
		trusted-users = setup.managedUsersAndRoot;
		lazy-trees = true;
		# settings.external-builders = [{"systems":["aarch64-linux","x86_64-linux"],"program":"/usr/local/bin/determinate-nixd","args":["builder"]}];
		# external-builders = [
		# 	{
		# 		systems = [ "x86_64-darwin" "aarch64-darwin" ];
		# 		program = "/usr/local/bin/darwin-nixd";
		# 		args = [ "builder" ];
		# 	}
		# ];
	};
}
