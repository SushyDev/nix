{ pkgs, ... }:
{
	environment.systemPackages = [
		# pkgs.opencode
		pkgs.qemu
		pkgs.ntfs3g
		pkgs.ghostty
		pkgs.vivaldi
		pkgs.discord
		pkgs.spotify
	];

	fonts.packages = [
		pkgs.fira-code
	];
}
