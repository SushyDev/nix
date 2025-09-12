{ config, pkgs, ... }: 
let
	dotfiles = builtins.fetchGit {
		url = "ssh://git@github.com/SushyDev/dotfiles";
		rev = "28f88c282b3744adf27b2580b6b89d6f5f535a4f";
		ref = "main";
		submodules = true;
	};
in
{
	home.activation.dotfiles = ''
		readonly PATH="${pkgs.stow}/bin:$PATH";

		readonly STATE_FILE="${config.xdg.stateHome}/dotfiles/stow";

		mkdir -p $(dirname $STATE_FILE);
		mkdir -p ${config.xdg.configHome};

		if [ -f $STATE_FILE ]; then
			stow \
				--dir=$(cat $STATE_FILE) \
				--delete \
				--no-folding \
				--ignore='\.DS_Store' \
				--ignore='zsh' \
				--ignore='git' \
				--ignore='nvim/lazy-lock\.json' \
				.config -t ${config.xdg.configHome};

			rm $STATE_FILE;
		fi

		stow \
			--dir=${dotfiles} \
			--restow \
			--no-folding \
			--ignore='\.DS_Store' \
			--ignore='zsh' \
			--ignore='git' \
			--ignore='nvim/lazy-lock\.json' \
			.config -t ${config.xdg.configHome};

		echo ${dotfiles} > $STATE_FILE;
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
