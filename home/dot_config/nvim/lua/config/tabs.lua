vim.opt.termguicolors = true
require("bufferline").setup({
    options = {
    },
})
vim.keymap.set("n", "<C-l>", "<Cmd>bnext!<CR>")
vim.keymap.set("n", "<C-h>", "<Cmd>bprev!<CR>")
--vim.keymap.set("n", "<leader><C-w>", "<Cmd>BufferLinePickClose<CR>")

