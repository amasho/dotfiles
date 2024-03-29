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

# nodenv
set -x NODENV_ROOT $ENVS_PATH/nodenv
set -x PATH $NODENV_ROOT/bin $PATH
set -x PATH $NODENV_ROOT/shims $PATH
status --is-interactive
source (nodenv init -|psub)
nodenv rehash

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
set -x PATH $PATH /usr/local/opt/libxml2/bin /usr/local/opt/bzip2/bin /usr/local/opt/libiconv/bin
phpenv rehash

# goenv
set -x GOENV_ROOT $ENVS_PATH/goenv
set -x PATH $GOENV_ROOT/bin $PATH
set -x PATH $GOENV_ROOT/shims $PATH
set -x GOROOT $HOME/go
set -x GOPATH $HOME/go
set -x PATH $GOPATH/bin $HOME/go/1.13.0/bin $PATH
goenv rehash

# PATH
set -x PATH $PATH /usr/local/bin /usr/local/sbin /usr/bin /bin /usr/sbin /sbin
set -x PATH $HOME/local/bin $PATH

# Aliases
alias exa 'exa --git'
alias ls "exa"
alias l 'ls'
alias ll 'ls -l'
alias ltr 'll -r -m'
alias la 'ls -la'
alias h 'history'
alias less 'less -r'
alias which '/usr/bin/which'
alias ql 'qlmanage -p'
alias javac 'javac -J-Dfile.encoding=UTF8'
alias vim 'nvim'
alias vi 'vim'
alias v 'vim'
alias diff 'icdiff'

# Git
alias g 'git'
alias gd 'git diff -u'
alias gicd 'git-icdiff'
alias gst 'git status -s -b'
alias gco 'git checkout'
alias gsw 'git switch'
set -x GIT_EDITOR vim

# Docker
alias d 'docker'
alias dp 'docker ps'
alias di 'docker images'

### Change the prompt
set pure_color_blue \e\[34m
set pure_color_cyan \e\[36m
set pure_color_gray \e\[38\;2\;147\;161\;161m
set pure_color_green \e\[32m
set pure_color_normal \e\[30m\e\(B\e\[m
set pure_color_red \e\[31m
set pure_color_yellow \e\[33m

set pure_command_max_exec_time 5
set pure_host_color \e\[38\;2\;147\;161\;161m
set pure_root_color \e\[30m\e\(B\e\[m
set pure_symbol_git_dirty '*'
set pure_symbol_git_down_arrow "⇣"
set pure_symbol_git_up_arrow "⇡"
set pure_symbol_horizontal_bar "—"
set pure_symbol_prompt "❯"
set pure_user_host_location 0
set pure_username_color \e\[38\;2\;147\;161\;161m

function fish_prompt --description 'Write out the prompt'
    # pwd
    printf '\n%s%s' (set_color magenta) (prompt_pwd)
    set_color normal

    # normal
    set last_status $status
    printf '%s ' $pure_color_yellow(__fish_git_prompt)
    set_color normal

    # git branch
    printf '\n%s❯ ' $pure_color_green

end

function fish_user_key_bindings
  bind \cr peco_select_history
  bind \cg peco_select_ghq_repository
end
set -g fish_user_paths "/usr/local/opt/mysql@5.7/bin" $fish_user_paths

# The next line updates PATH for the Google Cloud SDK.
if [ -f '~/local/bin/google-cloud-sdk/path.fish.inc' ]; . '~/local/bin/google-cloud-sdk/path.fish.inc'; end

# for Bigsur
set -x PATH /opt/homebrew/bin $PATH

# for flutter
set -x PATH $HOME/.pub-cache/bin $PATH

# direnv
set -x EDITOR vim
eval (direnv hook fish)

# for openssl
set -x PATH (brew --prefix openssl)/bin $PATH
set -gx LDFLAGS "-L"(brew --prefix openssl)"/lib"
set -gx CPPFLAGS "-I"(brew --prefix openssl)"/include"

# 一度sdkコマンドを実行してgradleのpathを通す
sdk help > /dev/null
