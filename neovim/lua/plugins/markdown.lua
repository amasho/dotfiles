return {
  -- Markdown をバッファ内で整形表示 (見出し・表・コードブロック・チェックボックスなど)
  -- 挿入モードとカーソル行は生のテキストに戻る
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    keys = {
      { "<Leader>mp", "<Cmd>RenderMarkdown toggle<CR>", ft = "markdown", desc = "Toggle markdown render" },
    },
    opts = {
      -- 数式の表示には latex のパーサと utftex などが必要。使わないので切る
      latex = { enabled = false },
    },
  },
}
