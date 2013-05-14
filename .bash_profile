
if [ -f /usr/local/bin/brew ]; then
	if [ -f $(brew --prefix)/etc/bash_completion ]; then
	 . $(brew --prefix)/etc/bash_completion
	fi
fi

source ~/.bashrc

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
