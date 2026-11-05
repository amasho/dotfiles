// tmux のコピーモード代わり: フォーカス中ターミナルの履歴を下に分割した nvim で開く
// ctrl-v で矩形選択、y でクリップボードへコピー、q で閉じる
// 別マシン(Lima の VM など)の space では、分割したペインもそのマシンで動く
import { View, div } from "gpui-kit";
import { run, props, focused, spaces, closeOverlay } from "herdr";

const LINES = 10000;

const quote = (s) => `'${String(s).replace(/'/g, `'\\''`)}'`;

// 別マシンにはクリップボードがないので、OSC 52 で Herdr 経由で Mac のクリップボードへ書く
// (Herdr は OSC 52 の読み取りを許さないので、貼り付けは nvim の無名レジスタから返す)
const OSC52 = [
  "local o = require('vim.ui.clipboard.osc52')",
  "local p = function() return { vim.fn.split(vim.fn.getreg(''), '\\n'), vim.fn.getregtype('') } end",
  "vim.g.clipboard = { name = 'OSC 52', copy = { ['+'] = o.copy('+'), ['*'] = o.copy('*') }, paste = { ['+'] = p, ['*'] = p } }",
].join("; ");

export default class CopyMode extends View {
  init(_props, cx) {
    const f = focused();
    if (f?.terminal) {
      const machine = spaces().find((s) => s.id === f.space)?.machine ?? null;
      // アプリから見た別マシンの ID は "<machine>/t3" なので、そのマシンの中では接頭辞を外す
      const prefix = machine ? `${machine}/` : "";
      const terminal = f.terminal.startsWith(prefix) ? f.terminal.slice(prefix.length) : f.terminal;
      const nvimArgs = [
        "-R",
        ...(machine ? ["-c", `lua ${OSC52}`] : []),
        "-c", "set clipboard=unnamedplus",
        "-c", "nnoremap <buffer> q <Cmd>qa!<CR>",
        "-c", "normal! G",
        "-",
      ];
      // パスはペインを動かすマシンで解決する(Mac の非ログインシェルには Homebrew が PATH にない)
      const script = [
        `PATH="/opt/homebrew/bin:$PATH";`,
        `"$HOME/.local/bin/herdr-core" read ${quote(terminal)} --lines ${LINES}`,
        `| nvim ${nvimArgs.map(quote).join(" ")}`,
      ].join(" ");
      run("pane.split", { direction: "down", pane: f.pane, argv: ["/bin/sh", "-c", script] });
    }
    cx.timer.after(0, () => closeOverlay(props()?.overlay));
  }

  render() {
    return div();
  }
}
