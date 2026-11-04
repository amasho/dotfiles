// tmux のコピーモード代わり: フォーカス中ターミナルの履歴を下に分割した nvim で開く
// ctrl-v で矩形選択、y でクリップボードへコピー、q で閉じる
import { View, div } from "gpui-kit";
import { run, props, focused, home, closeOverlay } from "herdr";

const LINES = 10000;
const NVIM = "/opt/homebrew/bin/nvim";

const quote = (s) => `'${String(s).replace(/'/g, `'\\''`)}'`;

export default class CopyMode extends View {
  init(_props, cx) {
    const f = focused();
    if (f?.terminal) {
      const hc = `${home()}/.local/bin/herdr-core`;
      const script = [
        `${quote(hc)} read ${quote(f.terminal)} --lines ${LINES}`,
        `| ${NVIM} -R -c 'set clipboard=unnamedplus' -c 'nnoremap <buffer> q <Cmd>qa!<CR>' -c 'normal! G' -`,
      ].join(" ");
      run("pane.split", { direction: "down", pane: f.pane, argv: ["/bin/sh", "-c", script] });
    }
    cx.timer.after(0, () => closeOverlay(props()?.overlay));
  }

  render() {
    return div();
  }
}
