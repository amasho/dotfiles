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
#export PATH="/usr/local/bin:`/usr/local/bin/brew --prefix coreutils`/libexec/gnubin:${PATH}:/usr/local/sbin:/usr/share/pear/bin:${HOME}/local/bin"
export PATH="/usr/local/bin:${PATH}:/usr/local/sbin:/usr/share/pear/bin:${HOME}/local/bin"

# Screen session
export SCREENDIR=${HOME}/.screen

# Ignore case
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select=1
autoload -U compinit; compinit -u

autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

# Options
setopt PROMPT_SUBST
#setopt CORRECT_ALL
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
# see also
# for c in {000..255}; do echo -n "\e[38;5;${c}m $c" ; [ $(($c%16)) -eq 15 ] && echo;done;echo
P_COLOR=$((22 + RANDOM % (231 - 1 + 1)))
PROMPT=%F$'%{\e[38;5;'$P_COLOR'm%}'"[%n@%m${WINDOW:+[$WINDOW]}]$ "%f
RPROMPT='[`rprompt-git-current-branch`%~]'
PROMPT2="%_%% "

# push enter-key
function do_enter() {
    P_COLOR=$((22 + RANDOM % (231 - 1 + 1)))
    PROMPT=%F$'%{\e[38;5;'$P_COLOR'm%}'"[%n@%m${WINDOW:+[$WINDOW]}]$ "%f
    if [ -n "$BUFFER" ]; then
        zle accept-line
        return 0
    fi

    echo
    if [ `ls |wc -l` -gt 0 ]; then
        echo -e "\e[0;33m--- files ---\e[0m"
        ls
    fi

    if [ "$(git rev-parse --is-inside-work-tree 2> /dev/null)" = 'true' ]; then
        echo
        echo -e "\e[0;33m--- git status ---\e[0m"
        git status -s -b
    fi
#    zle reset-prompt
    return 0
}
zle -N do_enter
bindkey '^m' do_enter

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
alias ql='qlmanage -p'
alias javac="javac -J-Dfile.encoding=UTF8"

alias s='screen -D -RR -q'

# suffix
alias -s js=node
alias -s coffee=coffee
alias -s rb=ruby
alias -s pl=perl
alias -s lua=lua
alias -s java=javac
alias -s scala=scalac
alias -s {c,cpp}=g++
alias -s gradle=gradle

# Git
alias g='git'
alias gd='git diff --color'
alias gst='git status -s -b'
export GIT_EDITOR=vim

if [ `uname` = "Darwin" ]; then
	stty erase  -ixon
	export __CF_USER_TEXT_ENCODING="0x1F5:0x08000100:14"
else
	stty erase  -ixon
fi

# TMUX
alias tmux='tmux -2'

# z.sh
if [ -f ${HOME}/.zsh/z/z.sh ]; then
	_Z_CMD=j
	source ${HOME}/.zsh/z/z.sh
	precmd() { _z --add "$(pwd -P)" }
fi

# bd.zsh
if [ -f ${HOME}/.zsh/zsh-bd/bd.zsh ]; then
	source ${HOME}/.zsh/zsh-bd/bd.zsh
fi

# auto-fu.zsh
if [ -f ${HOME}/.zsh/auto-fu/auto-fu.zsh ]; then
	source ${HOME}/.zsh/auto-fu/auto-fu.zsh
	function zle-line-init () {auto-fu-init}
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

# Termcap
export TERM=xterm-256color
export TERMCAP="xterm-256color:Co#256:pa#256:AF=\E[38;5;%dm:AB=\E[48;5;%dm:tc=xterm-xfree86:"

function chpwd() { ls }

#rbenv
if [[ -d ${HOME}/.rbenv ]]; then
	export PATH=${PATH}:${HOME}/.rbenv/bin;
	eval "$(rbenv init -)";
fi

# perlbrew
if [[ -d ${HOME}/.perlbrew ]]; then
	source $HOME/.perlbrew/etc/bashrc
	export PATH=${PATH}:${HOME}/.perlbrew/bin
	export PERLBREW_ROOT=${HOME}/.perlbrew
	alias pb='perlbrew'
fi

# nodebrew
if [[ -f ${HOME}/.nodebrew/nodebrew ]]; then
	export NODE_PATH=${HOME}/.nodebrew/current/lib/node_modules
	export PATH=${PATH}:${HOME}/.nodebrew/current/bin
	nodebrew use v0.8.4 > /dev/null
	alias nb='nodebrew'
fi

PATH=/Users/CH0018/local/bin:/Users/CH0018/.perlbrew/bin:/Users/CH0018/.perlbrew/perls/perl-5.16.0/bin:/Users/CH0018/.rbenv/shims:/usr/local/opt/coreutils/libexec/gnubin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/Users/CH0018/.rbenv/shims:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/sbin:/usr/share/pear/bin:/Users/CH0018/local/bin:/Users/CH0018/.rbenv/bin:/Users/CH0018/.nodebrew/current/bin:/Library/Java/JavaVirtualMachines/jdk1.7.0_40.jdk/Contents/Home/bin:/usr/local/tomcat/bin:/usr/local/nginx/sbin:/usr/local/Cellar/scala/2.10.2/libexec/bin:/usr/local/hadoop/bin:/usr/local/hbase/bin:/usr/local/hive/bin:/usr/local/bin:/usr/local/sbin:/usr/share/pear/bin:/Users/CH0018/local/bin:/Users/CH0018/.rbenv/bin:/Users/CH0018/.perlbrew/bin:/Users/CH0018/.nodebrew/current/bin:/Library/Java/JavaVirtualMachines/jdk1.7.0_40.jdk/Contents/Home/bin:/usr/local/tomcat/bin:/usr/local/nginx/sbin:/usr/local/Cellar/scala/2.10.2/libexec/bin:/usr/local/nginx/sbin:/usr/local/hadoop/bin:/usr/local/hbase/bin:/usr/local/hive/bin
