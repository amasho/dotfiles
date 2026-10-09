local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end
local autocmd = vim.api.nvim_create_autocmd

-- カーソル行ハイライトはカレントウィンドウのみ
local cl = augroup("cursorline")
autocmd({ "WinEnter", "BufWinEnter" }, {
  group = cl,
  callback = function()
    if vim.api.nvim_win_get_config(0).relative == "" then
      vim.wo.cursorline = true
    end
  end,
})
autocmd("WinLeave", {
  group = cl,
  callback = function()
    vim.wo.cursorline = false
  end,
})

-- ファイルタイプ別インデント (2スペース)
autocmd("FileType", {
  group = augroup("indent"),
  pattern = {
    "vim",
    "html",
    "xhtml",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "json",
    "jsonc",
    "yaml",
    "css",
    "sass",
    "scss",
    "pug",
    "ruby",
    "eruby",
    "scala",
    "lua",
  },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})
-- go は gofmt に合わせてハードタブ
autocmd("FileType", {
  group = augroup("indent_go"),
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 0
  end,
})

-- 行末スペースのハイライト
local ts = augroup("trailing_spaces")
local function set_trailing_hl()
  vim.api.nvim_set_hl(0, "TrailingSpaces", { bg = "#b58900", ctermbg = 136 })
end
set_trailing_hl()
autocmd("ColorScheme", { group = ts, callback = set_trailing_hl })

local function clear_trailing_match()
  if vim.w.trailing_match_id then
    pcall(vim.fn.matchdelete, vim.w.trailing_match_id)
    vim.w.trailing_match_id = nil
  end
end
autocmd({ "BufWinEnter", "WinEnter", "InsertLeave" }, {
  group = ts,
  callback = function()
    clear_trailing_match()
    if vim.bo.buftype == "" and vim.bo.modifiable then
      vim.w.trailing_match_id = vim.fn.matchadd("TrailingSpaces", [[\s\+$]])
    end
  end,
})
-- 入力中はハイライトしない
autocmd("InsertEnter", { group = ts, callback = clear_trailing_match })

-- ターミナル
local term = augroup("terminal")
autocmd("TermOpen", {
  group = term,
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.cmd.startinsert()
  end,
})
-- ヤンク範囲をハイライト
autocmd("TextYankPost", {
  group = augroup("yank_highlight"),
  callback = function()
    vim.hl.on_yank({ timeout = 200 })
  end,
})
