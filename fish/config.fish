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

# z
set -U Z_CMD "j"

set -x HOMEBREW_GITHUB_API_TOKEN (cat $HOME/.homebrew_token)

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

# anyenv
set -x PATH $HOME/.anyenv/bin $PATH
set -x ENVS_PATH $HOME/.anyenv/envs

# ndenv
set -x NDENV_ROOT $ENVS_PATH/ndenv
set -x PATH $NDENV_ROOT/bin $PATH
set -x PATH $NDENV_ROOT/shims $PATH
ndenv rehash

# rbenv
set -x RBENV_ROOT $ENVS_PATH/rbenv
set -x PATH $RBENV_ROOT/bin $PATH
set -x PATH $RBENV_ROOT/shims $PATH
rbenv rehash

# pyenv
set -x PYENV_ROOT $ENVS_PATH/pyenv
set -x PATH $PYENV_ROOT/bin $PATH
set -x PATH $PYENV_ROOT/shims $PATH
pyenv rehash

# phpenv
set -x PHPENV_ROOT $ENVS_PATH/phpenv
set -x PATH $PHPENV_ROOT/bin $PATH
set -x PATH $PHPENV_ROOT/shims $PATH

# goenv
set -x GOENV_ROOT $ENVS_PATH/goenv
set -x PATH $GOENV_ROOT/bin $PATH
set -x PATH $GOENV_ROOT/shims $PATH
set -x GOROOT $HOME/go
set -x GOPATH $HOME/go
set -x PATH $GOPATH/bin $PATH
goenv rehash

# Android SDK
#set -x ANDROID_HOME $HOME/Library/Android/sdk
#set -x ANDROID_SDK_HOME $HOME/Library/Android/sdk
#set -x JAVA_HOME /Library/Java/JavaVirtualMachines/jdk-9.jdk/Contents/Home
#set -x PATH $PATH $JAVA_HOME/bin $ANDROID_SDK_HOME/tools $ANDROID_SDK_HOME/platform-tools

# PATH
set -x PATH $PATH /usr/local/bin /usr/local/sbin /usr/bin /bin /usr/sbin /sbin
set -x PATH $HOME/local/bin $PATH

# Aliases
alias l 'ls'
alias ll 'ls -l'
alias la 'ls -la'
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

function fish_user_key_bindings
  bind \cr peco_select_history
  bind \cg peco_select_ghq_repository
end


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/amasho/local/bin/google-cloud-sdk/path.fish.inc' ]; if type source > /dev/null; source '/Users/amasho/local/bin/google-cloud-sdk/path.fish.inc'; else; . '/Users/amasho/local/bin/google-cloud-sdk/path.fish.inc'; end; end
