-- カラースキーマの設定
-- 起動に時間がかかってしまうので設定を遅延させる
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd.colorscheme("catppuccin")
  end,
})
