# dotfiles

macOS (Ghostty) と Windows (WSL2 + Windows Terminal) で共通の開発環境。
Ubuntu の Linux VM (Lima) でも `install.sh` でセットアップできる。
配色は Dracula で統一している。

| ディレクトリ / ファイル | 内容 | リンク先 |
| --- | --- | --- |
| `fish/` | fish シェル設定 | `~/.config/fish` |
| `neovim/` | Neovim (Lua + lazy.nvim) | `~/.config/nvim` |
| `starship/starship.toml` | プロンプト | `~/.config/starship.toml` |
| `.tmux.conf` | tmux (TPM + dracula/tmux) | `~/.tmux.conf` |
| `.tigrc` `.asdfrc` `.irbrc` `.ctags` | 各ツール | `~/` 直下 |
| `hunk/config.toml` | hunk (diff ビューア) の配色 | `~/.config/hunk/config.toml` |
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
- Ubuntu / WSL: apt で `fish tmux neovim starship fzf zoxide eza bat fd-find ripgrep tig jq unzip build-essential tree-sitter-cli golang-go git-delta gh` を導入し、`ja_JP.UTF-8` ロケールを生成
- `~/.gitconfig` に `git/delta.gitconfig` と `git/hunk.gitconfig` を include (それぞれ delta / hunk がある場合のみ。未登録の場合のみ)
- Linux (非WSL): Herdr core の shell 設定 `herdr/core-config.linux.toml` をリンク
- TPM を clone して tmux プラグイン (dracula) を導入
- Linux: `ghq` を GitHub Releases から `~/.local/bin` に配置
- WSL: `win32yank.exe` (クリップボード連携)、Windows Terminal の Dracula fragment、HackGen Console NF フォント、IME 切替スクリプトを導入
- ログインシェルを fish に変更 (`chsh`)

sudo を使う手順 (apt / locale-gen / chsh) を飛ばすには `./install.sh --no-sudo`。

### Windows (WSL2) の補足

Windows Terminal・フォント・IME 切替など Windows 側の設定は [windows/README.md](windows/README.md) にまとめている。
fish の `op` は `explorer.exe .` でカレントディレクトリをエクスプローラで開く。

### Linux VM (Lima) の補足

`vm/lima/agent.yaml` から Ubuntu VM を作成し、VM 内で `install.sh` を実行する。

```bash
# Mac: VM から読み取り専用で見える唯一の共有フォルダ (VM 内では /Users/<user>/vm-inbox)
mkdir -p ~/vm-inbox
limactl create --name=agent vm/lima/agent.yaml && limactl start agent

# VM 内 (limactl shell agent): Mac の SSH 鍵・ssh-agent は渡さないので https で clone する
git clone https://github.com/amasho/dotfiles.git ~/ghq/github.com/amasho/dotfiles \
  && cd ~/ghq/github.com/amasho/dotfiles && ./install.sh

# Mac: Herdr に登録 (~/.ssh/config を書き換えずに済む)
hc machine add --via "ssh -F $HOME/.lima/agent/ssh.config lima-agent" --name agent
```

### macOS の補足

ツール自体は Homebrew で入れる (`brew install fish tmux neovim starship fzf zoxide eza bat fd ripgrep tig ghq jq tree-sitter git-delta gh`)。
`install.sh` はリンクと TPM の導入のみ行う。

## 初回起動

- **Neovim**: 初回起動時に lazy.nvim がプラグインを、Mason が LSP サーバを自動導入する。treesitter のパーサは `tree-sitter` CLI がある時だけ入る
- **tmux**: プレフィックスは `Ctrl+t`。設定変更後は `Ctrl+t` → `Ctrl+r` で再読み込み、プラグイン追加後は `Ctrl+t` → `I`
- **fish**: ja_JP ロケールが無い環境では自動で `C.UTF-8` にフォールバックする
