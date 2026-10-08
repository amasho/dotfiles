local parsers = {
  "lua",
  "vim",
  "vimdoc",
  "query",
  "javascript",
  "typescript",
  "tsx",
  "json",
  "yaml",
  "toml",
  "html",
  "css",
  "scss",
  "markdown",
  "markdown_inline",
  "ruby",
  "go",
  "fish",
  "bash",
  "diff",
  "gitcommit",
}

return {
  -- nvim-treesitter (main ブランチ: nvim 0.12 向けの新 API)
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false, -- main ブランチは lazy-load 非対応
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")
      ts.setup({})

      -- パーサのビルドには tree-sitter CLI が必要。無い場合はインストールをスキップする
      if vim.fn.executable("tree-sitter") == 1 then
        ts.install(parsers)
      end

      -- ハイライト有効化 (パーサが無い filetype は従来の syntax のまま)
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
        callback = function(ev)
          pcall(vim.treesitter.start, ev.buf)
        end,
      })
    end,
  },
}
