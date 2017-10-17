set fish_greeting

set -x LANG ja_JP.UTF-8
set -x LC_MESSAGES ja_JP.UTF-8
set -x LC_CTYPE ja_JP.UTF-8
set -x OUTPUT_CHARSET ja_JP.UTF-8
set -x LESSCHARSET UTF-8
set -x JLESSCHARSET japanese
set -x LC_ALL ja_JP.UTF-8

# TERM's
set -x TERM xterm-256color
set -x TERMCAP "xterm-256color:Co#256:pa#256:AF=\E[38;5;%dm:AB=\E[48;5;%dm:tc=xterm-xfree86:"

# WORD
set -x WORDCHARS '*?_.[]~-=&;!#$%^(){}<>'

# gpg
if test (pgrep gpg-agent) != ""
  set -x GPG_AGENT_INFO /Users/amasho/.gnupg/S.gpg-agent:600:1
  set -x GPG_AGENT_INFO
else
# eval (gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
  eval (gpg-agent --daemon)
end

# z
set -U Z_CMD "j"

set -x HOMEBREW_GITHUB_API_TOKEN (cat $HOME/.homebrew_token)

# Aliases
alias ll 'ls -l'
alias la 'ls -la'
alias ls 'ls -vF'
alias h 'history'
alias less 'less -r'
alias which '/usr/bin/which'
alias ql 'qlmanage -p'
alias javac 'javac -J-Dfile.encoding=UTF8'
alias exa 'exa --git'
alias vim 'nvim'
alias vi 'vim'
alias v 'vim'

# Only Mac
alias op 'open .'

# Git
alias g 'git'
alias gd 'git diff --color'
alias gst 'git status -s -b'
alias gco 'git checkout'
set -x GIT_EDITOR vim

# Docker Machine
alias dm 'docker-machine'
alias dml 'docker-machine ls'

# Docker
alias d 'docker'
alias dp 'docker ps'
alias di 'docker images'

if test (uname) = "Darwin"
    stty erase  -ixon
    set -x __CF_USER_TEXT_ENCODING "0x1F5:0x08000100:14"
else
    stty erase  -ixon
end

# TMUX
alias tmux 'tmux -2'

# nvim
set -x XDG_CONFIG_HOME $HOME/.config

# MySQL Prompt
set -x MYSQL_PS1 "mysql[\d]# "

# ndenv
set -x NDENV_ROOT $HOME/.ndenv
set -x PATH $NDENV_ROOT/bin $PATH
set -x PATH $NDENV_ROOT/shims $PATH
ndenv rehash

# rbenv
set -x RBENV_ROOT $HOME/.rbenv
set -x PATH $RBENV_ROOT/bin $PATH
set -x PATH $RBENV_ROOT/shims $PATH
rbenv rehash

# pyenv
set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/bin $PATH
set -x PATH $PYENV_ROOT/shims $PATH
pyenv rehash

# goenv
set -x GOENV_ROOT $HOME/.goenv
set -x PATH $GOENV_ROOT/bin $PATH
set -x PATH $GOENV_ROOT/shims $PATH
goenv rehash

# phpenv
set -x PHPENV_ROOT $HOME/.phpenv
set -x PATH $GOENV_ROOT/bin $PATH
set -x PATH $GOENV_ROOT/shims $PATH
goenv rehash

# Android SDK
set -x ANDROID_HOME $HOME/Library/Android/sdk
set -x ANDROID_SDK_HOME $HOME/Library/Android/sdk
set -x JAVA_HOME /Library/Java/JavaVirtualMachines/jdk-9.jdk/Contents/Home
set -x PATH $PATH $JAVA_HOME/bin $ANDROID_SDK_HOME/tools $ANDROID_SDK_HOME/platform-tools

# PATH
set -x PATH $PATH /usr/local/bin /usr/local/sbin /usr/bin /bin /usr/sbin /sbin
# set -x PATH $HOME/.local/bin $PATH
