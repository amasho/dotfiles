local opt = vim.opt

-- 表示
opt.number = true
opt.ruler = true
opt.title = true
opt.showcmd = true
opt.wrap = false
opt.synmaxcol = 300
opt.cursorline = true -- カレントウィンドウのみ (autocmds.lua で制御)
opt.signcolumn = "yes"
opt.termguicolors = true
opt.showtabline = 1
opt.laststatus = 3
opt.cmdheight = 1
opt.list = false
opt.listchars = { eol = "<", tab = "|>", extends = "<" }
-- アイコン(Nerd Font)や floating window の罫線が崩れるため double ではなく single
opt.ambiwidth = "single"

-- 検索
opt.hlsearch = true
opt.wrapscan = true
opt.ignorecase = true
opt.smartcase = true

-- 補完 (挿入モード補完は blink.cmp。ここは cmdline / 組み込み補完用)
opt.wildmode = "longest,list"
opt.completeopt = { "menu", "menuone", "noselect" }

-- 文字コード / 改行コード
opt.fileencodings = { "ucs-bom", "utf-8", "euc-jp", "iso-2022-jp", "sjis", "cp932", "utf-16", "latin1" }
opt.fileformats = { "unix", "dos", "mac" }

-- ファイル
opt.autoread = true
opt.backup = false
opt.swapfile = false

-- インデント
opt.autoindent = true
opt.smartindent = true
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4

-- その他
opt.mouse = "a"
opt.clipboard = "unnamedplus"
