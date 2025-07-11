#
# .zshrc
#

# Emacs keybind
bindkey -e

# fpath
fpath+=($HOME/.zsh/** /usr/local/share/zsh-completions)

# Lang
export LANG=ja_JP.UTF-8
export LC_MESSAGES=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
export OUTPUT_CHARSET=ja_JP.UTF-8
export LESSCHARSET=UTF-8
export JLESSCHARSET=japanese
export LC_ALL=ja_JP.UTF-8

# Word
export WORDCHARS='*?_.[]~-=&;!#$%^(){}<>'

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
alias eza='eza --git'
alias ls="eza"
alias l='ls'
alias ll='ls -l'
alias ltr='ll -r -m'
alias la='ls -la'
alias v='nvim'
alias vi='nvim'
alias h='history'
alias less='less -r'
alias ql='qlmanage -p'
alias tree='tre'

# Only Mac
alias op='open .'

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
alias -s py=python

# Git
alias g='git'
alias gd='git diff --color'
alias gst='git status -s -b'
alias gsw='git switch'
export EDITOR=vim
export GIT_EDITOR=vim

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

# zsh-autosuggestions
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# z.sh
if [ -f ${HOME}/.zsh/z/z.sh ]; then
    _Z_CMD=j
    source ${HOME}/.zsh/z/z.sh
    precmd() { _z --add "$(pwd -P)" }
fi

# zsh-autosuggestions
source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# spaceship
source "$(/opt/homebrew/bin/brew --prefix)/opt/spaceship/spaceship.zsh"

# fzf
function fzf-history-select() {
    BUFFER=$(history -n -r 1 | fzf --query "$LBUFFER" --reverse)
    CURSOR=$#BUFFER
    zle reset-prompt && {zle clear-screen}
}
zle -N fzf-history-select
bindkey '^R' fzf-history-select

function fzf-cdr() {
    local selected_dir=$(cdr -l | awk '{ print $2 }' | fzf --reverse)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N fzf-cdr
setopt noflowcontrol
bindkey '^q' fzf-cdr

function vs-fzf () {
  local base_dir=`ghq root`
  local selected_dir=`ghq list | fzf`
  if [ -n "$selected_dir" ]; then
    code "$base_dir/$selected_dir"
    zle accept-line
    zle reset-prompt
  fi
  zle clear-screen
}
zle -N vs-fzf
bindkey '^]^V' vs-fzf

function ghq-fzf () {
  local base_dir=`ghq root`
  local selected_dir=`ghq list | fzf`
  if [ -n "$selected_dir" ]; then
    cd "$base_dir/$selected_dir"
    zle accept-line
    zle reset-prompt
  fi
}
zle -N ghq-fzf
bindkey '^]^G' ghq-fzf

# command line stack
function show_buffer_stack() {
    POSTDISPLAY="stack: $LBUFFER"
    zle && {zle push-line-or-edit}
}
zle -N show_buffer_stack
bindkey '\M-q' show_buffer_stack

# Termcap
export TERM=xterm-256color
export TERMCAP="xterm-256color:Co#256:pa#256:AF=\E[38;5;%dm:AB=\E[48;5;%dm:tc=xterm-xfree86:"

function chpwd() { ls }

# nvim
export XDG_CONFIG_HOME=${HOME}/.config

# MySQL Prompt
export MYSQL_PS1="mysql[\d]# "

# gcloud
source "$(/opt/homebrew/bin/brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "$(/opt/homebrew/bin/brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

# PATH
export PATH=${PATH}:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/share/pear/bin:/opt/homebrew/bin:${HOME}/.local/bin

# direnv
eval "$(direnv hook zsh)"

. "$(/opt/homebrew/bin/brew --prefix)/opt/asdf/libexec/asdf.sh"
