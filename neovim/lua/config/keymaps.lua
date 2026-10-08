local map = vim.keymap.set

-- clipboard へコピー
map("x", "<Leader>y", '"+y', { desc = "Yank to clipboard" })
-- 直前のバッファと行き来
map("n", "<C-j>", "<C-^>", { desc = "Alternate buffer" })
-- ESC 2回でハイライト消去
map("n", "<Esc><Esc>", "<Cmd>nohlsearch<CR>", { silent = true, desc = "Clear search highlight" })

-- 診断ジャンプ (旧 ALE の <C-a><C-n>/<C-a><C-p>)
map("n", "<C-a><C-n>", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })
map("n", "<C-a><C-p>", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Prev diagnostic" })

-- ターミナル
map("n", "@t", "<Cmd>botright new | resize 13 | terminal<CR>", { silent = true, desc = "Terminal (split)" })
map("n", "@T", "<Cmd>tabnew | terminal<CR>", { silent = true, desc = "Terminal (tab)" })
map("t", "<Esc><Esc>", [[<C-\><C-n>]], { silent = true, desc = "Terminal normal mode" })
