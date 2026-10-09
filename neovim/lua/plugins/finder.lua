return {
  -- ファジーファインダ (旧 denite)
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    keys = {
      {
        "<C-k><C-p>",
        function()
          require("fzf-lua").files()
        end,
        desc = "Find files",
      },
      {
        "<C-k><C-b>",
        function()
          require("fzf-lua").buffers()
        end,
        desc = "Buffers",
      },
      {
        "<C-k><C-g>",
        function()
          require("fzf-lua").live_grep()
        end,
        desc = "Live grep",
      },
      {
        "<C-k><C-l>",
        function()
          require("fzf-lua").oldfiles()
        end,
        desc = "Recent files",
      },
    },
    opts = {},
  },

  -- ファイルエクスプローラ (旧 vaffle)
  {
    "stevearc/oil.nvim",
    lazy = false, -- `nvim .` でディレクトリを開けるよう即時ロード
    keys = {
      {
        "<Leader>v",
        function()
          require("oil").open(vim.fn.getcwd())
        end,
        desc = "Explorer (cwd)",
      },
    },
    opts = {
      default_file_explorer = true,
      view_options = { show_hidden = true },
    },
  },

  -- モーション (旧 easymotion)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
    },
  },
}
