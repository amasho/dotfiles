local emmet_filetypes = { "html", "css", "javascriptreact", "typescriptreact", "eruby" }

return {
  -- 括弧の自動補完 (旧 inoremap { / ( と auto-pairs)
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- ruby / lua / vim / bash / fish の end 自動挿入 (treesitter ベース。パーサがある言語のみ有効)
  {
    "RRethy/nvim-treesitter-endwise",
    event = { "BufReadPre", "BufNewFile" }, -- FileType autocmd で attach するため FileType より前にロード
  },

  -- emmet
  {
    "mattn/emmet-vim",
    ft = emmet_filetypes,
    init = function()
      vim.g.user_emmet_install_global = 0
      vim.g.user_emmet_mode = "a"
      vim.g.user_emmet_leader_key = "<C-y>"
      vim.g.user_emmet_settings = {
        lang = "ja",
        html = { filters = "html", indentation = "  " },
        css = { filters = "fc" },
        javascriptreact = { extends = "jsx" },
        typescriptreact = { extends = "jsx" },
        eruby = { extends = "html" },
      }
    end,
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("user_emmet", { clear = true }),
        pattern = emmet_filetypes,
        command = "EmmetInstall",
      })
      -- ロードのきっかけになったバッファにも適用
      if vim.tbl_contains(emmet_filetypes, vim.bo.filetype) then
        vim.cmd("EmmetInstall")
      end
    end,
  },
}
