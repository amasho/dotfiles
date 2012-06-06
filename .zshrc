#
# .zshrc
#

stty erase  -ixon

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
export PATH=/usr/local/bin:$PATH

# Screen session
export SCREENDIR=${HOME}/.screen

# Prompt Setting
local GREEN=$'%{\e[1;32m%}'
local YELLOW=$'%{\e[1;33m%}'
local BLUE=$'%{\e[1;34m%}'
local CYAN=$'%{\e[1;36m%}'
local DEFAULT=$'%{\e[1;m%}'
PROMPT=$CYAN"[%n@%m${WINDOW:+[$WINDOW]}]$ "$DEFAULT
PROMPT2="%_%% "
RPROMPT=$YELLOW"[%~]"$DEFAULT

# Use prompt color
autoload -U colors; colors

# Ignore case
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select=1
autoload -U compinit; compinit -u

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

# Command history configuration
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

alias screen=${HOME}/bin/screen

# Aliases
alias l='ls -v'
alias ls='ls -vF'
alias ll='ls -l'
alias la='ls -la'
alias v='vim'
alias e='emacs -nw'
alias h='history'
alias g='grep'
alias less='less -r'
alias which='/usr/bin/which'

alias s='screen -D -RR -q'

# Termcap
#export TERM=xterm-256color
export TERMCAP="xterm-256color:Co#256:pa#256:AF=\E[38;5;%dm:AB=\E[48;5;%dm:tc=xterm-xfree86:"

function chpwd() { ls }

# RVM
if [[ -s ${HOME}/.rvm/scripts/rvm ]] ; then source ${HOME}/.rvm/scripts/rvm ; fi

