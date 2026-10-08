-- Neovim config (Lua + lazy.nvim)
-- leader は lazy 読み込み前に設定する
vim.g.mapleader = ","
vim.g.maplocalleader = ","

require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.lazy")
