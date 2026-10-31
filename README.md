# dotfiles

macOS (Ghostty) と Windows (WSL2 + Windows Terminal) で共通の開発環境。
配色は Dracula で統一している。

| ディレクトリ / ファイル | 内容 | リンク先 |
| --- | --- | --- |
| `fish/` | fish シェル設定 | `~/.config/fish` |
| `neovim/` | Neovim (Lua + lazy.nvim) | `~/.config/nvim` |
| `starship/starship.toml` | プロンプト | `~/.config/starship.toml` |
| `.tmux.conf` | tmux (TPM + dracula/tmux) | `~/.tmux.conf` |
| `.tigrc` `.asdfrc` `.irbrc` `.ctags` | 各ツール | `~/` 直下 |
| `claude/` | Claude Code の statusline ([詳細](claude/README.md)) | `~/.claude/statusline.sh` |
| `ghostty/` `alacritty/` `cmux/` | macOS のターミナル | `~/.config/{ghostty,alacritty}` |
| `windows/` | Windows (WSL2) 用の追加設定: Windows Terminal の fragment、IME 切替スクリプト ([詳細](windows/README.md)) | Windows 側へコピー |
| `.zshrc` | zsh (macOS のみ、fish 移行前の設定) | 手動 |

## セットアップ

```bash
ghq get git@github.com:amasho/dotfiles.git   # ghq が無ければ git clone
cd ~/ghq/github.com/amasho/dotfiles
./install.sh
```

`install.sh` は何度実行しても同じ結果になる。行うこと:

- 上記のシンボリックリンク作成 (既存ファイルは `*.bak.<日時>` に退避)
- Ubuntu / WSL: apt で `fish tmux neovim starship fzf zoxide eza bat fd-find ripgrep tig jq unzip build-essential tree-sitter-cli golang-go` を導入し、`ja_JP.UTF-8` ロケールを生成
- TPM を clone して tmux プラグイン (dracula) を導入
- Linux: `ghq` を GitHub Releases から `~/.local/bin` に配置
- WSL: `win32yank.exe` (クリップボード連携)、Windows Terminal の Dracula fragment、HackGen Console NF フォント、IME 切替スクリプトを導入
- ログインシェルを fish に変更 (`chsh`)

sudo を使う手順 (apt / locale-gen / chsh) を飛ばすには `./install.sh --no-sudo`。

### Windows (WSL2) の補足

Windows Terminal・フォント・IME 切替など Windows 側の設定は [windows/README.md](windows/README.md) にまとめている。
fish の `op` は `explorer.exe .` でカレントディレクトリをエクスプローラで開く。

### macOS の補足

ツール自体は Homebrew で入れる (`brew install fish tmux neovim starship fzf zoxide eza bat fd ripgrep tig ghq jq tree-sitter`)。
`install.sh` はリンクと TPM の導入のみ行う。

## 初回起動

- **Neovim**: 初回起動時に lazy.nvim がプラグインを、Mason が LSP サーバを自動導入する。treesitter のパーサは `tree-sitter` CLI がある時だけ入る
- **tmux**: プレフィックスは `Ctrl+t`。設定変更後は `Ctrl+t` → `Ctrl+r` で再読み込み、プラグイン追加後は `Ctrl+t` → `I`
- **fish**: ja_JP ロケールが無い環境では自動で `C.UTF-8` にフォールバックする
