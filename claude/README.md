# Claude Code Settings

Claude Code のカスタム設定。

## ファイル

- `statusline.sh` — statusline にアカウント情報・組織名・cwd・git ブランチ・モデル名をカラフルに表示するスクリプト

## 他PCへのセットアップ

### 1. 前提

- `jq` がインストールされていること（macOS: `brew install jq`）
- このリポジトリが ghq 経由で `~/ghq/github.com/amasho/dotfiles` にクローン済みであること
  ```bash
  ghq get git@github.com:amasho/dotfiles.git
  ```

### 2. シンボリックリンク作成

```bash
ln -s ~/ghq/github.com/amasho/dotfiles/claude/statusline.sh ~/.claude/statusline.sh
```

> ghq の管理パスが既定 (`~/ghq`) と異なる場合は `git config --global ghq.root` の値に合わせてパスを置き換えてください。

### 3. `~/.claude/settings.json` に下記キーを追記

```json
"statusLine": {
  "type": "command",
  "command": "~/.claude/statusline.sh"
}
```

### 4. Claude Code を再起動

statusline に `email @ org  cwd  branch  model` がカラフルに表示されれば OK。

## 配色のカスタマイズ

`statusline.sh` 上部の `PINK` / `CYAN` / `YELLOW` / `GREEN` / `MAGENTA` / `GRAY` 変数の `38;5;XXX` の数値を変えると色が変わる（256色パレット）。
