
if [ -f /usr/local/bin/brew ]; then
	if [ -f $(brew --prefix)/etc/bash_completion ]; then
	 . $(brew --prefix)/etc/bash_completion
	fi
fi

source ~/.bashrc

test -e ${HOME}/.iterm2_shell_integration.bash && source ${HOME}/.iterm2_shell_integration.bash
