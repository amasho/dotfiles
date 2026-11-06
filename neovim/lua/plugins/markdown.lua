-- 見出しの色 (Dracula の各色を背景 #282A36 に 2 割ほど混ぜたもの)
local heading_colors = {
  { fg = "#BD93F9", bg = "#463F5D" }, -- purple
  { fg = "#FF79C6", bg = "#533A53" }, -- pink
  { fg = "#8BE9FD", bg = "#3C505E" }, -- cyan
  { fg = "#50FA7B", bg = "#305444" }, -- green
  { fg = "#FFB86C", bg = "#534641" }, -- orange
  { fg = "#F1FA8C", bg = "#505447" }, -- yellow
}

local function set_heading_hl()
  for i, c in ipairs(heading_colors) do
    vim.api.nvim_set_hl(0, "RenderMarkdownH" .. i, { fg = c.fg, bold = true })
    vim.api.nvim_set_hl(0, "RenderMarkdownH" .. i .. "Bg", { fg = c.fg, bg = c.bg, bold = true })
  end
end

-- 開いているファイルを Herdr の右のペインに出す (herdr/mods/markdown-browser)
-- Herdr.app の操作なので、Herdr.app と同じ Mac で動いているときだけ使える
local function open_in_herdr()
  if vim.fn.executable("herdr-app") == 0 then
    vim.notify("herdr-app がありません (Herdr.app のある Mac でだけ使えます)", vim.log.levels.WARN)
    return
  end
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    return
  end
  local args = vim.json.encode({ direction = "right", mod = "markdown-browser", props = { file = file } })
  vim.system({ "herdr-app", "do", "pane.split", args }, { text = true }, function(r)
    if r.code ~= 0 then
      vim.schedule(function()
        vim.notify("Herdr のペインを開けませんでした: " .. (r.stderr ~= "" and r.stderr or r.stdout), vim.log.levels.ERROR)
      end)
    end
  end)
end

return {
  -- Markdown をバッファ内で整形表示 (見出し・表・コードブロック・チェックボックスなど)
  -- 挿入モードとカーソル行は生のテキストに戻る
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    init = function()
      -- Markdown は文章として読むので、単語の切れ目で折り返し、行番号とサイン列を消す
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("user_markdown_window", { clear = true }),
        pattern = "markdown",
        callback = function()
          vim.opt_local.wrap = true
          vim.opt_local.linebreak = true
          vim.opt_local.breakindent = true
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
          vim.opt_local.signcolumn = "no"
        end,
      })
    end,
    keys = {
      { "<Leader>mp", "<Cmd>RenderMarkdown toggle<CR>", ft = "markdown", desc = "Toggle markdown render" },
      { "<Leader>mo", open_in_herdr, ft = "markdown", desc = "Open markdown in Herdr pane" },
    },
    opts = {
      heading = {
        sign = false,
        icons = { "▍ " },
        width = "block",
        left_pad = 1,
        right_pad = 4,
        -- H1 / H2 は上下に帯を足して大きく見せる
        border = { true, true, false },
        border_virtual = true,
      },
      code = {
        sign = false,
        width = "block",
        left_pad = 2,
        right_pad = 4,
        min_width = 60,
        -- 上の帯に言語名を出す
        border = "thin",
      },
      bullet = {
        icons = { "•", "◦", "▪", "▫" },
      },
      -- 数式の表示には latex のパーサと utftex などが必要。使わないので切る
      latex = { enabled = false },
    },
    config = function(_, opts)
      set_heading_hl()
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = vim.api.nvim_create_augroup("user_render_markdown", { clear = true }),
        callback = set_heading_hl,
      })
      require("render-markdown").setup(opts)
    end,
  },

  -- 画像と Mermaid の図をバッファ内に表示 (Kitty graphics 対応の端末のみ)
  -- Herdr.app 0.1.13 の中では画像が出ない (場所だけ空く)。Ghostty などの端末で直接使うとき向け
  -- 画像の変換に ImageMagick、Mermaid に mmdc (@mermaid-js/mermaid-cli) が必要 (mmdc は入れていない)
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      image = {
        -- Herdr の中 (HC_TERMINAL_ID がある) では空白が空くだけなので切る
        enabled = vim.env.HC_TERMINAL_ID == nil,
        doc = {
          max_width = 80,
          max_height = 40,
        },
      },
    },
  },
}
