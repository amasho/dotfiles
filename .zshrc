#
# .zshrc
#

# Emacs keybind
bindkey -e

# Lang
export LANG=ja_JP.UTF-8
export LC_MESSAGES=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
export OUTPUT_CHARSET=ja_JP.UTF-8
export LESSCHARSET=UTF-8
export JLESSCHARSET=japanese
export LC_ALL=ja_JP.UTF-8

# Path
export PATH=/usr/local/bin:/usr/local/sbin:/usr/share/pear/bin:$HOME/local/bin:$PATH

# Screen session
export SCREENDIR=${HOME}/.screen

# Ignore case
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select=1
autoload -U compinit; compinit -u

autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

# Options
setopt PROMPT_SUBST
setopt CORRECT_ALL
setopt AUTO_CD
setopt AUTO_PUSHD
setopt NO_FLOW_CONTROL
setopt NO_BEEP
setopt AUTO_LIST
setopt HIST_EXPAND
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
setopt NO_HUP

# Use prompt color
autoload -U colors; colors

# Prompt Setting
function rprompt-git-current-branch {
	local name st color gitdir action
	if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
		return
	fi
	name=`git rev-parse --abbrev-ref=loose HEAD 2> /dev/null`
	if [[ -z $name ]]; then
		return
	fi

	gitdir=`git rev-parse --git-dir 2> /dev/null`
	action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

	st=`git status 2> /dev/null`
	if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
		color=%F{green}
	elif [[ -n `echo "$st" | grep "^no changes added"` ]]; then
		color=%F{yellow}
	elif [[ -n `echo "$st" | grep "^# Changes to be committed"` ]]; then
		color=%B%F{red}
	else
		color=%F{red}
	fi

	echo "$color$name$action%f%b: "
}
local DEFAULT=$'%{\e[1;m%}'
local GREEN=$'%{\e[1;32m%}'
local YELLOW=$'%{\e[1;33m%}'
local BLUE=$'%{\e[1;34m%}'
local CYAN=$'%{\e[1;36m%}'
local WHITE=$'%{\e[1;37m%}'
PROMPT=$CYAN"[%n@%m${WINDOW:+[$WINDOW]}]$ "$WHITE
RPROMPT='[`rprompt-git-current-branch`%~]'
PROMPT2="%_%% "

# Command history configuration
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

alias screen=${HOME}/local/bin/screen

# Aliases
alias l='ls -v'
alias ls='ls -vF'
alias ll='ls -l'
alias la='ls -la'
alias v='vim'
alias e='emacs -nw'
alias h='history'
alias less='less -r'
alias which='/usr/bin/which'
alias javac="javac -J-Dfile.encoding=UTF8"

alias s='screen -D -RR -q'
alias tmux='tmux -2'

if [ `uname` = "Darwin" ]; then
	stty erase  -ixon
	export __CF_USER_TEXT_ENCODING="0x1F5:0x08000100:14"
else
	stty erase  -ixon
fi

# z.sh
if [ -f ~/z/z.sh ]; then
	_Z_CMD=j
	source ~/z/z.sh
	precmd() { _z --add "$(pwd -P)" }
fi

# auto-fu.zsh
if [ -f ~/.zsh/auto-fu.zsh ]; then
	source ~/.zsh/auto-fu.zsh
	function zle-line-init () {
		auto-fu-init
	}
	zle -N zle-line-init
	zstyle ':completion:*' completer _oldlist _complete
fi

# command line stack
show_buffer_stack() {
	POSTDISPLAY="stack: $LBUFFER"
	zle push-line-or-edit
}
zle -N show_buffer_stack
setopt noflowcontrol
bindkey 'M-q' show_buffer_stack''

# nodebrew
if [[ -f $HOME/.nodebrew/nodebrew ]]; then
	export NODE_PATH=$HOME/.nodebrew/current/lib/node_modules
	export PATH=$HOME/.nodebrew/current/bin:$PATH
	nodebrew use v0.8.4 > /dev/null
	alias nb='nodebrew'
fi

# Git
alias g='git'
alias gst='git status -s -b'
export GIT_EDITOR=vim

# Termcap
export TERM=xterm-256color
export TERMCAP="xterm-256color:Co#256:pa#256:AF=\E[38;5;%dm:AB=\E[48;5;%dm:tc=xterm-xfree86:"

function chpwd() { ls }

# RVM
#if [[ -s ${HOME}/.rvm/scripts/rvm ]] ; then source ${HOME}/.rvm/scripts/rvm ; fi
#PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# rbenv
if [[ -s ${HOME}/.rbenv/bin ]]; then
	PATH=$PATH:$HOME/.rbenv/bin;
	eval "$(rbenv init -)";
fi

