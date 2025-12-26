vim.opt.termguicolors = true
require("bufferline").setup({
  options = {},
})
vim.keymap.set("n", "<leader>l", "<Cmd>bnext!<CR>")
vim.keymap.set("n", "<leader>h", "<Cmd>bprev!<CR>")
vim.keymap.set("n", "<leader>w", "<Cmd>bd<CR>")
