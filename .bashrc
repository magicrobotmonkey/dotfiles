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
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


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
alias fixvenv='pip install -i "https://pypi.python.org/simple" packaging appdirs cryptography==1.7.2 ndg-httpsclient pip==8.1.1'
function psgrep() { ps axuf | grep -v grep | grep "$@" -i --color=auto; }

function busterIlo() { sudo ssh -L 443:${1}:443 -L 80:${1}:80 -L 17990:${1}:17990 -L 17988:${1}:17988 root@172.16.5.151; }



alias dotup='cd ~/dotfiles && git pull && git submodule update --init && source ~/.bashrc && cd -'
alias soba='source ~/.bashrc'
alias pyserv='python -m SimpleHTTPServer 8008'

alias cdgr='cd `git rev-parse --show-toplevel`'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

pathadd() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}
pathadd /usr/local/sbin
pathadd ~/bin
pathadd /usr/local/share/python

export PYTHONPATH=$PYTHONPATH:${HOME}/code/powerline:${HOME}/.config/powerline/custom_segments

alias ssh='ssh -A'
alias fixssh='export SSH_AUTH_SOCK="$HOME/.ssh/ssh_auth_sock"'
#~/bin/grabssh

WRAPPER=/usr/local/bin/virtualenvwrapper.sh
if [ -f $WRAPPER ]; then
	source $WRAPPER
fi

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

[ -s $HOME/.nvm/nvm.sh ] && . $HOME/.nvm/nvm.sh # This loads NVM
