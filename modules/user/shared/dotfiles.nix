{ config, pkgs, ... }: 
let
	dotfiles = builtins.fetchGit {
		url = "https://github.com/sushydev/dotfiles";
		ref = "main";
		rev = "ef07453c7e7d8bd57ef350044d6df7bd52b8be6f";
		submodules = true;
	};
in
{
	home.activation.dotfiles = ''
	'';

	programs.zsh = {
		enable = true;
		dotDir = "${config.xdg.configHome}/zsh";
		profileExtra = ". ${dotfiles}/.config/zsh/.zshrc";
	};

	programs.git = {
		enable = true;
		includes = [
			{
				path = "${dotfiles}/.config/git/config";
			}
		];
	};
}
