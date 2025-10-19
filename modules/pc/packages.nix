{ nixpkgs, pkgs, ... }:
{
	# nixpkgs.overlays = [
	# 	(final: prev: {
	# 		php83-optimized = prev.php83.overrideAttrs (oldAttrs: {
	# 			configureFlags = oldAttrs.configureFlags ++ [
	# 				"--enable-opcache"
	# 				"--with-pic"
	# 			];
	#
	# 			NIX_CFLAGS_COMPILE = (oldAttrs.NIX_CFLAGS_COMPILE or "") + " " + builtins.concatStringsSep " " [
	# 				"-O3"
	# 				"-march=x86-64-v3"
	# 				"-fno-semantic-interposition"
	# 			];
	#
	# 			NIX_LDFLAGS = (oldAttrs.NIX_LDFLAGS or "");
	# 		});
	# 	})
	# ];

	environment.systemPackages = [
		# pkgs.opencode
		# pkgs.qemu
		# pkgs.ntfs3g
		pkgs.ghostty
		pkgs.vivaldi
		pkgs.discord
		pkgs.spotify
		# pkgs.php83-optimized
	];

	fonts.packages = [
		pkgs.fira-code
	];
}
