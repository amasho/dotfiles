#
# config.fish
#

### 基本 ###################################################################
set -g fish_greeting

### ロケール ###############################################################
set -gx LANG ja_JP.UTF-8
set -gx LC_ALL ja_JP.UTF-8
set -gx LC_MESSAGES ja_JP.UTF-8
set -gx LC_CTYPE ja_JP.UTF-8
set -gx OUTPUT_CHARSET ja_JP.UTF-8
set -gx LESSCHARSET UTF-8
set -gx JLESSCHARSET japanese
set -gx COLORTERM truecolor
# TERM / TERMCAP は端末(Ghostty=xterm-ghostty)と tmux(tmux-256color)に任せ、上書きしない

if test (uname) = Darwin
    set -gx __CF_USER_TEXT_ENCODING 0x1F5:0x08000100:14
end

### 配色 (Dracula) #########################################################
# fish のバージョン移行で universal 変数(fish_variables)が飛ぶため global に固定する
set -g fish_color_normal normal
set -g fish_color_command F8F8F2
set -g fish_color_param FF79C6
set -g fish_color_quote F1FA8C
set -g fish_color_comment 6272A4
set -g fish_color_redirection 8BE9FD
set -g fish_color_end 50FA7B
set -g fish_color_error FFB86C
set -g fish_color_escape 00a6b2
set -g fish_color_operator 00a6b2
set -g fish_color_autosuggestion BD93F9
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_status red
set -g fish_color_user brgreen
set -g fish_color_host normal
set -g fish_color_host_remote yellow
set -g fish_color_valid_path --underline
set -g fish_color_cancel -r
set -g fish_color_history_current --bold
set -g fish_color_match --background=brblue
set -g fish_color_search_match bryellow --background=brblack
set -g fish_color_selection white --bold --background=brblack
set -g fish_pager_color_completion normal
set -g fish_pager_color_description B3A06D yellow
set -g fish_pager_color_prefix white --bold --underline
set -g fish_pager_color_progress brwhite --background=cyan
set -g fish_pager_color_selected_background -r

### PATH ###################################################################
# asdf 0.16+ は asdf.sh が廃止。shims を最優先で PATH に追加する
set -l asdf_dir $HOME/.asdf
set -q ASDF_DATA_DIR; and set asdf_dir $ASDF_DATA_DIR
fish_add_path -gp $asdf_dir/shims $HOME/.local/bin $HOME/local/bin \
    $HOME/.pub-cache/bin /opt/homebrew/bin /opt/homebrew/sbin
test -d $HOME/go/bin; and fish_add_path -ga $HOME/go/bin

### 環境変数 ###############################################################
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx EDITOR vim
set -gx GIT_EDITOR vim
set -gx MYSQL_PS1 "mysql[\d]# "

# openssl (ビルド用フラグ。起動ごとの brew --prefix 実行を避けて静的パスで解決)
set -l openssl_prefix /opt/homebrew/opt/openssl@3
if test -d $openssl_prefix
    fish_add_path -ga $openssl_prefix/bin
    set -gx LDFLAGS "-L$openssl_prefix/lib"
    set -gx CPPFLAGS "-I$openssl_prefix/include"
end

### alias ##################################################################
alias eza 'eza --git'
alias ls 'eza'
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
alias tmux 'tmux -2'
alias op 'open .'

# Git
alias g 'git'
alias gd 'git diff -u'
alias gst 'git status -s -b'
alias gco 'git checkout'
alias gsw 'git switch'

# Docker
alias d 'docker'
alias dp 'docker ps'
alias di 'docker images'

### 関数 ###################################################################
function ghq_fzf --description 'ghq のリポジトリを fzf で選んで cd する'
    set -l query (commandline)
    set -l selected (ghq list --full-path | fzf --reverse --query "$query")
    if test -n "$selected"
        cd $selected
        commandline -r ''
    end
    commandline -f repaint
end

### ツール初期化 ###########################################################
command -q direnv; and direnv hook fish | source

set -l gcloud_inc /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc
test -f $gcloud_inc; and source $gcloud_inc

if status is-interactive
    # 端末に繋がっていない対話セッション(CI や -c 実行)ではスキップ
    isatty stdin; and stty erase \x7f -ixon

    # プロンプト
    command -q starship; and starship init fish | source

    # fzf: Ctrl-R 履歴 / Ctrl-T ファイル / Alt-C ディレクトリ移動
    command -q fzf; and fzf --fish | source

    # ghq リポジトリ移動
    command -q ghq; and command -q fzf; and bind ctrl-g ghq_fzf
end
