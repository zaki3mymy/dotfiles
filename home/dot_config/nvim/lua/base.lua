-- タブ・インデント設定
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.smartindent = true

-- クリップボード
vim.opt.clipboard:append("unnamedplus")

-- 行番号
vim.opt.number = true
vim.opt.relativenumber = true

-- カーソル強調
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#21223a" })

-- h,l で行跨ぎ
vim.opt.whichwrap = { ["<"] = true, [">"] = true, h = true, l = true }

-- 上下オフセット
vim.opt.scrolloff = 5

-- 前回位置復元
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- showcmd（右下のコマンド表示）
vim.opt.showcmd = true

-- leader キー
vim.g.mapleader = " "

-- 自動読み込み設定
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  -- Neovimにフォーカスが戻ったときとバッファに入ったときに
  -- `checktime`で再読み込みを行う
  command = "if mode() != 'c' | checktime | endif",
  pattern = "*",
})
