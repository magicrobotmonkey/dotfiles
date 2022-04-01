export TZ=/usr/share/zoneinfo/US/Eastern
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=200000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias ssh='ssh -A'

alias tmls='tmux list-sessions'
alias tmat='tmux at -t'
function psgrep() { ps axuf | grep -v grep | grep "$@" -i --color=auto; }


alias dotup='cd ~/dotfiles && git pull && git submodule update --init && source ~/.bashrc && cd -'
alias soba='source ~/.bashrc'

alias cdgr='cd `git rev-parse --show-toplevel`'

source ~/.bash_git

pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1:${PATH:+"$PATH"}"
    fi
}
pathadd ~/bin

alias ssh='ssh -A'

#http://www.ukuug.org/events/linux2003/papers/bash_tips/
shopt -s cdspell
shopt -s histappend

export EDITOR=vim
#http://www.catonmat.net/blog/bash-vi-editing-mode-cheat-sheet/
set -o vi

#these need to be bound specifically to vi insert mode to work
bind -m vi-insert '"\e[A": history-search-backward'
bind -m vi-insert '"\e[B": history-search-forward'
#http://superuser.com/questions/18498/last-parameter-of-last-command-in-bash-in-vi-mode
bind -m vi-insert '"\e."':yank-last-arg

# tmux ssh-agent fix (byobu supposedly handles this, that is when it works with tmux)
if [[ ! -d /Library ]]; then 
	echo "fixhing ssh"
	if [ "$(id -u)" != "0" ]; then  # make sure its not a sudo
		ln -sf $(find /tmp/ssh-* -name agent.\* -uid $(id -u) 2>/dev/null | xargs ls -t | head -n 1) ~/.ssh/ssh_auth_sock
		export SSH_AUTH_SOCK="$HOME/.ssh/ssh_auth_sock"
	fi
fi

source ~/.bash_prompt
if [ -f ~/.bash_local ]; then
	source ~/.bash_local
fi

