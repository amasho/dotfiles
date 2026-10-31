#!/usr/bin/env bash
#
# install.sh - dotfiles セットアップ (macOS / Ubuntu / WSL2)
#
#   ./install.sh            全手順 (apt, locale-gen, chsh で sudo のパスワードを聞かれる)
#   ./install.sh --no-sudo  sudo 不要な手順のみ (リンク, TPM, ghq, win32yank, Windows Terminal 設定, フォント)
#
# 何度実行しても同じ結果になる (冪等)。既存の実体ファイルは *.bak.<日時> に退避する。
#
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS="$(uname -s)"
IS_WSL=false
if [ "$OS" = Linux ] && grep -qi microsoft /proc/version 2>/dev/null; then
  IS_WSL=true
fi
WITH_SUDO=true

for arg in "$@"; do
  case "$arg" in
    --no-sudo) WITH_SUDO=false ;;
    -h | --help)
      sed -n '2,10p' "$0" | sed 's/^# \{0,1\}//'
      exit 0
      ;;
    *)
      echo "unknown option: $arg" >&2
      exit 1
      ;;
  esac
done

info() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
skip() { printf '    \033[2mskip\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33mwarn\033[0m %s\n' "$*" >&2; }

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

# unzip が無い環境 (apt 前) でも展開できるように python3 にフォールバック
unzip_to() {
  local zip="$1" dir="$2"
  mkdir -p "$dir"
  if command -v unzip >/dev/null; then
    unzip -q -o "$zip" -d "$dir"
  else
    python3 -I -m zipfile -e "$zip" "$dir"
  fi
}

### シンボリックリンク ######################################################
# link <リポジトリ内の相対パス> <リンク先>
link() {
  local src="$DOTFILES/$1" dst="$2"
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    skip "$dst"
    return
  fi
  mkdir -p "$(dirname "$dst")"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    local bak="$dst.bak.$(date +%Y%m%d%H%M%S)"
    mv "$dst" "$bak"
    info "backup: $dst -> $bak"
  fi
  ln -sfn "$src" "$dst"
  info "link: $dst -> $src"
}

setup_links() {
  info "シンボリックリンク"
  link fish "$HOME/.config/fish"
  link neovim "$HOME/.config/nvim"
  link starship/starship.toml "$HOME/.config/starship.toml"
  link .tmux.conf "$HOME/.tmux.conf"
  link .tigrc "$HOME/.tigrc"
  link .asdfrc "$HOME/.asdfrc"
  link .irbrc "$HOME/.irbrc"
  link .ctags "$HOME/.ctags"
  link claude/statusline.sh "$HOME/.claude/statusline.sh"
  if [ "$OS" = Darwin ]; then
    link ghostty/config "$HOME/.config/ghostty/config"
    link alacritty/alacritty.toml "$HOME/.config/alacritty/alacritty.toml"
  fi
}

### Ubuntu パッケージ #######################################################
install_apt_packages() {
  info "apt パッケージ"
  local pkgs=(
    fish tmux neovim starship fzf zoxide eza bat fd-find ripgrep tig
    jq unzip curl git build-essential tree-sitter-cli golang-go
  )
  local missing=()
  for p in "${pkgs[@]}"; do
    dpkg -s "$p" >/dev/null 2>&1 || missing+=("$p")
  done
  if [ ${#missing[@]} -eq 0 ]; then
    skip "すべて導入済み"
    return
  fi
  sudo apt-get update
  sudo apt-get install -y "${missing[@]}"
}

setup_locale() {
  info "ロケール (ja_JP.UTF-8)"
  if locale -a 2>/dev/null | grep -qi '^ja_JP\.utf-\?8$'; then
    skip "生成済み"
    return
  fi
  if grep -q '^# *ja_JP.UTF-8 UTF-8' /etc/locale.gen; then
    sudo sed -i 's/^# *ja_JP.UTF-8 UTF-8/ja_JP.UTF-8 UTF-8/' /etc/locale.gen
  elif ! grep -q '^ja_JP.UTF-8 UTF-8' /etc/locale.gen; then
    echo 'ja_JP.UTF-8 UTF-8' | sudo tee -a /etc/locale.gen >/dev/null
  fi
  sudo locale-gen
}

### tmux プラグイン (TPM + dracula) #########################################
setup_tpm() {
  info "tmux プラグイン (TPM)"
  if ! command -v tmux >/dev/null; then
    warn "tmux が無いためスキップ"
    return
  fi
  local tpm="$HOME/.tmux/plugins/tpm"
  if [ ! -d "$tpm" ]; then
    git clone --depth 1 https://github.com/tmux-plugins/tpm "$tpm"
  else
    skip "$tpm"
  fi
  if [ ! -d "$HOME/.tmux/plugins/tmux" ]; then
    "$tpm/bin/install_plugins"
  else
    skip "dracula/tmux"
  fi
}

### ghq (apt に無いので GitHub Releases から) ################################
install_ghq() {
  info "ghq"
  # ~/.local/bin が PATH に無いシェルから実行されても二重導入しないよう実体も見る
  if [ -x "$HOME/.local/bin/ghq" ] || command -v ghq >/dev/null; then
    skip "ghq"
    return
  fi
  local arch
  case "$(uname -m)" in
    x86_64) arch=amd64 ;;
    aarch64 | arm64) arch=arm64 ;;
    *)
      warn "未対応アーキテクチャ: $(uname -m)"
      return
      ;;
  esac
  curl -fsSL -o "$TMP/ghq.zip" \
    "https://github.com/x-motemen/ghq/releases/latest/download/ghq_linux_${arch}.zip"
  unzip_to "$TMP/ghq.zip" "$TMP/ghq"
  install -Dm755 "$TMP/ghq/ghq_linux_${arch}/ghq" "$HOME/.local/bin/ghq"
  info "installed: $HOME/.local/bin/ghq"
}

### WSL: クリップボード / Windows Terminal / フォント ########################
win_localappdata() {
  # %LOCALAPPDATA% を Linux パスで返す (cmd.exe は WSL 上の cwd だと警告を出すので /mnt/c で実行)
  local p
  p="$(cd /mnt/c && cmd.exe /c 'echo %LOCALAPPDATA%' 2>/dev/null | tr -d '\r')"
  wslpath -u "$p"
}

install_win32yank() {
  info "win32yank (tmux / Neovim のクリップボード連携)"
  local dst="$HOME/.local/bin/win32yank.exe"
  if [ -x "$dst" ]; then
    skip "$dst"
    return
  fi
  curl -fsSL -o "$TMP/win32yank.zip" \
    "https://github.com/equalsraf/win32yank/releases/download/v0.1.1/win32yank-x64.zip"
  unzip_to "$TMP/win32yank.zip" "$TMP/win32yank"
  install -Dm755 "$TMP/win32yank/win32yank.exe" "$dst"
  info "installed: $dst"
}

install_wt_fragment() {
  info "Windows Terminal (Dracula 配色 / フォント)"
  local src="$DOTFILES/windows/windows-terminal/dracula.json"
  local dst
  dst="$(win_localappdata)/Microsoft/Windows Terminal/Fragments/dotfiles/dracula.json"
  if [ -f "$dst" ] && cmp -s "$src" "$dst"; then
    skip "$dst"
    return
  fi
  mkdir -p "$(dirname "$dst")"
  cp "$src" "$dst"
  info "installed: $dst (Windows Terminal を再起動すると反映される)"
}

install_hackgen_font() {
  info "HackGen Console NF フォント (Windows ユーザーフォント)"
  local fontdir
  fontdir="$(win_localappdata)/Microsoft/Windows/Fonts"
  if ls "$fontdir"/HackGenConsoleNF-*.ttf >/dev/null 2>&1; then
    skip "$fontdir"
    return
  fi
  local url
  url="$(curl -fsSL https://api.github.com/repos/yuru7/HackGen/releases/latest |
    python3 -I -c 'import json,sys
for a in json.load(sys.stdin)["assets"]:
    if a["name"].startswith("HackGen_NF_"):
        print(a["browser_download_url"]); break')"
  if [ -z "$url" ]; then
    warn "HackGen_NF のリリースが見つからないためスキップ"
    return
  fi
  curl -fsSL -o "$TMP/hackgen.zip" "$url"
  unzip_to "$TMP/hackgen.zip" "$TMP/hackgen"
  mkdir -p "$fontdir"
  find "$TMP/hackgen" -name 'HackGenConsoleNF-*.ttf' -exec cp {} "$fontdir/" \;

  # HKCU のフォントキーへ登録し、現在のセッションにも読み込む (per-user フォント: Windows 10 1809+)
  local winfontdir
  winfontdir="$(wslpath -w "$fontdir")"
  powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "
    \$ErrorActionPreference = 'Stop'
    Add-Type -Namespace Win -Name Gdi -MemberDefinition '[DllImport(\"gdi32.dll\")] public static extern int AddFontResource(string p);'
    \$key = 'HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts'
    if (-not (Test-Path \$key)) { New-Item -Path \$key -Force | Out-Null }
    Get-ChildItem '$winfontdir\HackGenConsoleNF-*.ttf' | ForEach-Object {
      New-ItemProperty -Path \$key -Name (\$_.BaseName + ' (TrueType)') -Value \$_.FullName -PropertyType String -Force | Out-Null
      [Win.Gdi]::AddFontResource(\$_.FullName) | Out-Null
    }
  " 2>/dev/null | tr -d '\r'
  info "installed: $fontdir (反映されない場合は Windows に再サインイン)"
}

install_ime_toggle() {
  info "IME 切替 (AutoHotkey: Ctrl+Shift+E)"
  local appdata dst
  appdata="$(cd /mnt/c && cmd.exe /c 'echo %APPDATA%' 2>/dev/null | tr -d '\r')"
  dst="$(wslpath -u "$appdata")/dotfiles/ime-toggle.ahk"
  if [ -f "$dst" ] && cmp -s "$DOTFILES/windows/autohotkey/ime-toggle.ahk" "$dst"; then
    skip "$dst"
  else
    mkdir -p "$(dirname "$dst")"
    cp "$DOTFILES/windows/autohotkey/ime-toggle.ahk" "$dst"
    info "installed: $dst"
  fi
  if [ ! -x "$(win_localappdata)/Programs/AutoHotkey/v2/AutoHotkey64.exe" ]; then
    warn "AutoHotkey v2 が無い: winget install --id AutoHotkey.AutoHotkey --scope user"
  fi
}

### ログインシェル ##########################################################
setup_shell() {
  info "ログインシェルを fish に変更"
  local fish
  fish="$(command -v fish || true)"
  if [ -z "$fish" ]; then
    warn "fish が無いためスキップ"
    return
  fi
  if [ "${SHELL:-}" = "$fish" ]; then
    skip "$fish"
    return
  fi
  if ! grep -qx "$fish" /etc/shells; then
    echo "$fish" | sudo tee -a /etc/shells >/dev/null
  fi
  chsh -s "$fish"
  info "次回ログインから fish になる"
}

### main ####################################################################
main() {
  info "dotfiles: $DOTFILES (OS=$OS WSL=$IS_WSL sudo=$WITH_SUDO)"
  if [ "$OS" = Linux ] && $WITH_SUDO; then
    install_apt_packages
    setup_locale
  fi
  setup_links
  setup_tpm
  if [ "$OS" = Linux ]; then
    install_ghq
  fi
  if $IS_WSL; then
    install_win32yank
    install_wt_fragment
    install_hackgen_font
    install_ime_toggle
  fi
  if $WITH_SUDO; then
    setup_shell
  fi
  info "完了"
}

main
