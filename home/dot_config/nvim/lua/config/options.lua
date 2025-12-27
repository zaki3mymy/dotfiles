-- タブ・インデント設定
local tabwidth = 2
vim.opt.expandtab = true
vim.opt.tabstop = tabwidth
vim.opt.softtabstop = tabwidth
vim.opt.shiftwidth = tabwidth
vim.opt.autoindent = true
vim.opt.smartindent = true

-- 行番号
vim.opt.number = true
vim.opt.relativenumber = true
vim.o.numberwidth = 4

-- 画面分割の方向
vim.opt.splitright = true
vim.opt.splitbelow = true

-- クリップボード有効化
vim.opt.clipboard = "unnamedplus"

-- 検索
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.wrapscan = true

-- 上下オフセット
vim.opt.scrolloff = 4

-- showcmd（右下のコマンド表示）
vim.opt.showcmd = true

-- 自動読み込み設定
vim.opt.autoread = true

-- ステータスラインは表示しない
vim.opt.laststatus = 0

-- 保存してなくてもbuffer移動できるようにする
vim.opt.hidden = true

-- 不可視文字の表示
vim.opt.list = true
vim.opt.listchars = {
  tab = "->",
  trail = "␣",
  nbsp = "␣",
  extends = "❯",
  precedes = "❮",
}

-- UI
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes" -- Gitsignsが使う記号列を常に表示
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#21223a" })

-- h,l で行跨ぎ
vim.opt.whichwrap = { ["<"] = true, [">"] = true, h = true, l = true }
