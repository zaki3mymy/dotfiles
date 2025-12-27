-- leader キー
vim.g.mapleader = " "

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

-- 自動読み込み設定
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  -- Neovimにフォーカスが戻ったときとバッファに入ったときに
  -- `checktime`で再読み込みを行う
  command = "if mode() != 'c' | checktime | endif",
  pattern = "*",
})
