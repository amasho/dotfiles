#
# .zshrc
#

# Emacs keybind
bindkey -e

# fpath
fpath=($HOME/.zsh/** /usr/local/share/zsh-completions $fpath)

# Lang
export LANG=ja_JP.UTF-8
export LC_MESSAGES=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
export OUTPUT_CHARSET=ja_JP.UTF-8
export LESSCHARSET=UTF-8
export JLESSCHARSET=japanese
export LC_ALL=ja_JP.UTF-8

# Completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # Ignore case
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' format '%B%d%b'
autoload -U compinit; compinit -u
setopt auto_param_slash
setopt mark_dirs
setopt list_types
setopt auto_menu
setopt auto_param_keys
setopt interactive_comments
setopt magic_equal_subst
setopt complete_in_word
setopt always_last_prompt
setopt print_eight_bit
setopt extended_glob
setopt globdots

autoload predict-on

autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

autoload -Uz add-zsh-hook
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook

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

# prompt preset
autoload -U promptinit && promptinit

# Command history configuration
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

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

# Docker Machine
alias dm='docker-machine'
alias dml='docker-machine ls'

# Docker
alias d='docker'
alias dp='docker ps'
alias di='docker images'

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

# auto-fu.zsh
# if [ -f ${HOME}/.zsh/auto-fu/auto-fu.zsh ]; then
#     source ${HOME}/.zsh/auto-fu/auto-fu.zsh
#     function zle-line-init () {auto-fu-init}
#     zle -N zle-line-init
#     zstyle ':completion:*' completer _oldlist _complete
# fi

# pure.zsh
if [ -f ${HOME}/.zsh/pure/pure.zsh ]; then
    PURE_PROMPT_SYMBOL="[%n@%m]❯"
    prompt pure
fi

# peco
function peco-history-select() {
    if which tac > /dev/null; then
        TAC="tac"
    else
        TAC="tail -r"
    fi

    BUFFER=`history -n 1 | eval ${TAC} | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle && {zle clear-screen}
}
zle -N peco-history-select
bindkey '^R' peco-history-select

# command line stack
function show_buffer_stack() {
    POSTDISPLAY="stack: $LBUFFER"
    zle && {zle push-line-or-edit}
}
zle -N show_buffer_stack
bindkey 'M-q' show_buffer_stack

# Termcap
export TERM=xterm-256color
export TERMCAP="xterm-256color:Co#256:pa#256:AF=\E[38;5;%dm:AB=\E[48;5;%dm:tc=xterm-xfree86:"

function chpwd() { ls }

# gvm
[[ -d ${HOME}/.gvm ]] && source ${HOME}/.gvm/scripts/gvm

# pyenv
if [[ -d ${HOME}/.pyenv ]]; then
    export PYENV_ROOT=${HOME}/.pyenv
    eval "$(${PYENV_ROOT}/bin/pyenv init -)"
fi

#rbenv
if [[ -d ${HOME}/.rbenv ]]; then
    export RBENV_ROOT=${HOME}/.rbenv
    eval "$(${RBENV_ROOT}/bin/rbenv init -)"
fi

# perlbrew
if [[ -d ${HOME}/.perlbrew ]]; then
    source $HOME/.perlbrew/etc/bashrc
    export PERLBREW_ROOT=${HOME}/.perlbrew
    alias pb='perlbrew'
fi

# nodebrew
# if [[ -f ${HOME}/.nodebrew/nodebrew ]]; then
    export NODEBREW_ROOT=${HOME}/.nodebrew
    export NODE_PATH=${NODEBREW_ROOT}/current/lib/node_modules
    export PATH=${PATH}:
    alias nb='nodebrew'
# fi

# MySQL Prompt
export MYSQL_PS1="mysql[\d]# "

# PATH
export PATH=${PYENV_ROOT}/bin:${PERLBREW_ROOT}/bin:${PERLBREW_ROOT}/perls/perl-${CURRENT_PERL_VERSION}/bin:${RBENV_ROOT}/shims
export PATH=${PATH}:${GOROOT}/bin:${GOPATH}/bin:${NODEBREW_ROOT}/current/bin:/Library/Java/JavaVirtualMachines/jdk1.7.0_40.jdk/Contents/Home/bin
export PATH=${PATH}:/usr/local/opt/coreutils/libexec/gnubin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/sbin:/opt/X11/bin:/usr/share/pear/bin


