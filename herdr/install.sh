#!/bin/sh
#
# install.sh - Herdr を別環境でセットアップする
#
#   ./herdr/install.sh           Herdr.app が無ければ公式インストーラーで入れ、設定をリンクする
#   ./herdr/install.sh --no-app  設定のリンクだけ行う
#
# macOS 専用 (Linux では ../install.sh が Herdr core の設定をリンクする)。
# 何度実行しても同じ結果になる。既存の通常ファイルは *.bak-<日時> に退避してからリンクする。
#
set -eu

DOTFILES_HERDR=$(cd "$(dirname "$0")" && pwd)
APP_HOME="$HOME/.config/herdr-app"
CORE_HOME="$HOME/.config/herdr-core"
INSTALLER_URL="https://releases.herdr.dev/app/install.sh"
STAMP=$(date +%Y%m%d%H%M%S)

say() { printf '%s\n' "$*"; }

install_app=true
for arg in "$@"; do
  case $arg in
    --no-app) install_app=false ;;
    -h | --help) sed -n '3,10p' "$0"; exit 0 ;;
    *) say "unknown option: $arg" >&2; exit 1 ;;
  esac
done

if [ "$(uname -s)" != Darwin ]; then
  say "herdr/install.sh は macOS 専用。Linux では ../install.sh が Herdr core の設定をリンクする" >&2
  exit 1
fi

# src を dest へリンクする。正しいリンクが既にあれば何もしない
link() {
  src=$1
  dest=$2
  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    say "ok      $dest"
    return
  fi
  mkdir -p "$(dirname "$dest")"
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    mv "$dest" "$dest.bak-$STAMP"
    say "backup  $dest -> $dest.bak-$STAMP"
  fi
  ln -s "$src" "$dest"
  say "link    $dest -> $src"
}

### アプリ本体
if [ "$install_app" = true ]; then
  if [ -d /Applications/Herdr.app ] || [ -d "$HOME/Applications/Herdr.app" ]; then
    say "Herdr.app is already installed"
  else
    say "Installing Herdr.app ($INSTALLER_URL)"
    curl -fsSL "$INSTALLER_URL" | sh
  fi
fi

### 設定のリンク
link "$DOTFILES_HERDR/settings.json" "$APP_HOME/settings.json"
link "$DOTFILES_HERDR/keys.json" "$APP_HOME/keys.json"
link "$DOTFILES_HERDR/core-config.toml" "$CORE_HOME/config.toml"
for mod in "$DOTFILES_HERDR"/mods/*/; do
  [ -d "$mod" ] || continue
  mod=${mod%/}
  link "$mod" "$APP_HOME/mods/$(basename "$mod")"
done

### 依存コマンドの確認
[ -x /opt/homebrew/bin/fish ] || say "warning: /opt/homebrew/bin/fish がありません (core-config.toml のシェル)"
[ -x /opt/homebrew/bin/nvim ] || say "warning: /opt/homebrew/bin/nvim がありません (ctrl-t [ のコピーモード)"

say ""
say "done. Herdr を起動 (または再起動) すると設定が反映されます"
