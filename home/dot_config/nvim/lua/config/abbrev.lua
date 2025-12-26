-- 置換の短縮入力
-- https://zenn.dev/vim_jp/articles/2023-06-30-vim-substitute-tips
vim.cmd(
  [[cnoreabbrev <expr> s getcmdtype() .. getcmdline() ==# ':s' ? [getchar(), ''][1] .. "%s///g<Left><Left>" : 's']]
)
