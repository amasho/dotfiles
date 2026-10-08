-- mason で自動インストールするサーバ
-- ruby_lsp は Ruby >= 2.7 が必要で system ruby (2.6) では mason install が失敗するため対象外。
-- (asdf 等の ruby で `gem install ruby-lsp` 済みなら下の config で有効化する)
local servers = { "ts_ls", "eslint", "lua_ls", "gopls", "jsonls", "cssls", "html" }

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "mason-org/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUpdate", "MasonLog" },
        opts = {},
      },
      "mason-org/mason-lspconfig.nvim",
    },
    init = function()
      vim.diagnostic.config({
        severity_sort = true,
        virtual_text = { spacing = 2, source = "if_many" },
        float = { border = "rounded", source = true },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = ">>",
            [vim.diagnostic.severity.WARN] = "--",
            [vim.diagnostic.severity.INFO] = "--",
            [vim.diagnostic.severity.HINT] = "--",
          },
        },
      })

      -- 0.11+ の既定キーマップ (grn/gra/grr/gri/K/gO/<C-s>) に加えて gd を定義
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
        callback = function(ev)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go to definition" })
        end,
      })
    end,
    config = function()
      -- blink.cmp の補完 capabilities を全サーバへ
      local ok, blink = pcall(require, "blink.cmp")
      if ok then
        vim.lsp.config("*", { capabilities = blink.get_lsp_capabilities() })
      end

      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME },
            },
            telemetry = { enable = false },
          },
        },
      })

      require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_enable = true,
      })

      if vim.fn.executable("ruby-lsp") == 1 then
        vim.lsp.enable("ruby_lsp")
      end
    end,
  },
}
