# Windows (WSL2) 用の追加設定

WSL2 + Windows Terminal で使うための、Windows 側に置く設定。
WSL 側の fish / tmux / Neovim はリポジトリ直下の設定をそのまま使う。

| ファイル | 内容 | 配置先 (`install.sh` がコピー) |
| --- | --- | --- |
| `windows-terminal/dracula.json` | Windows Terminal の Ubuntu プロファイルに Dracula 配色・HackGen Console NF・不透明度 93% を適用する fragment | `%LOCALAPPDATA%\Microsoft\Windows Terminal\Fragments\dotfiles\` |
| `autohotkey/ime-toggle.ahk` | Ctrl+Shift+E で IME をオン/オフする AutoHotkey v2 スクリプト | `%APPDATA%\dotfiles\` |

WSL から `./install.sh` を実行すると、上記に加えて次も導入される。

- `win32yank.exe` を `~/.local/bin` に配置する。tmux のコピーモード `y` と Neovim の `"+y` が Windows のクリップボードに入る
- HackGen Console NF フォントを Windows のユーザーフォントとして登録する

## Windows Terminal

fragment は settings.json を書き換えずに設定を上書きする仕組み。反映には Windows Terminal の再起動が必要。
対象の Ubuntu プロファイル GUID `{61e06194-b991-5d08-89d4-f8e93580a11f}` は WSL のディストリ名 "Ubuntu" から決まるため、他の PC でも同じ。
フォントが反映されない場合は Windows に再サインインする。

## IME 切替 (AutoHotkey)

Jump Desktop で Mac から接続していると、Ctrl+Space は Mac の入力ソース切替に取られて Windows に届かない。
PowerToys Keyboard Manager でのショートカット置換は、リモート越しだと Ctrl が押しっぱなし扱いになって使えなかった。
そのためキー入力を合成せず、IME ウィンドウに `WM_IME_CONTROL` を直接送って切り替えている。

セットアップ手順:

1. AutoHotkey v2 を入れる

   ```
   winget install --id AutoHotkey.AutoHotkey --scope user
   ```

2. WSL で `./install.sh` を実行し、スクリプトを `%APPDATA%\dotfiles\ime-toggle.ahk` にコピーする
3. ログイン時に起動するよう、`Win+R` → `shell:startup` で開いたフォルダに `%APPDATA%\dotfiles\ime-toggle.ahk` のショートカットを置く。Alt を押しながらドラッグするとショートカットになる

WSL 側のリポジトリのファイルへショートカットを張らないこと。ログイン直後は WSL が起動しておらず読めないことがある。
