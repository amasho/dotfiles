local web = { "prettierd", "prettier", stop_after_first = true }

return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    keys = {
      {
        "<Leader>f",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = { "n", "x" },
        desc = "Format",
      },
    },
    opts = {
      notify_no_formatters = false,
      formatters_by_ft = {
        javascript = web,
        javascriptreact = web,
        typescript = web,
        typescriptreact = web,
        css = web,
        scss = web,
        html = web,
        json = web,
        jsonc = web,
        yaml = web,
        markdown = web,
        go = { "goimports", "gofmt" },
        lua = { "stylua" },
      },
      -- prettier / stylua はプロジェクトに設定ファイルがある場合のみ実行する
      formatters = {
        prettierd = { require_cwd = true },
        prettier = { require_cwd = true },
        stylua = { require_cwd = true },
      },
      format_on_save = {
        timeout_ms = 1000,
        lsp_format = "never",
      },
    },
  },
}
