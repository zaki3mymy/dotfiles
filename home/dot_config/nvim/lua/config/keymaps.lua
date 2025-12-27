vim.keymap.set("n", ";", ":", { noremap = true, desc = "Command mode" })

-- 画面分割
vim.keymap.set("n", "|", "<Cmd>vsplit<CR>", { noremap = true, desc = "Vertical split" })
vim.keymap.set("n", "_", "<Cmd>split<CR>", { noremap = true, desc = "Horizontal split" })

-- ページ移動
vim.keymap.set("i", "<C-f>", "<C-o><C-f>", { noremap = true, desc = "Page down" })
vim.keymap.set("i", "<C-b>", "<C-o><C-b>", { noremap = true, desc = "Page up" })

-- normalモードに移る
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, desc = "Change to normal mode" })
vim.keymap.set("t", "jj", [[<C-\><C-n>]], { noremap = true, desc = "Change to normal mode" })
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, desc = "Change to normal mode" })

-- Ctrl-S 保存
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<Cmd>w<CR>", { noremap = true, desc = "Save file" })

-- buffer
vim.keymap.set("n", "<C-l>", "<Cmd>bnext<CR>", { noremap = true, desc = "Move to next buffer" })
vim.keymap.set("n", "<C-h>", "<Cmd>bprev<CR>", { noremap = true, desc = "Move to prev buffer" })
vim.keymap.set("n", "<leader>w", "<Cmd>bw<CR>", { noremap = true, desc = "Close current buffer" })

-- 検索ハイライトの解除
vim.keymap.set("n", "<Esc><Esc>", "<Cmd>noh<CR>", { noremap = true, desc = "No search highlight" })

-- LSP
-- 表示
vim.keymap.set("n", "K", vim.lsp.buf.hover, { noremap = true, desc = "Hover info" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { noremap = true, desc = "Show references" })
-- ジャンプ
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { noremap = true, desc = "Go to definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { noremap = true, desc = "Go to definition" })
vim.keymap.set("n", "gt", "<C-t>", { noremap = true, desc = "Jump back" })
-- 編集
vim.keymap.set({ "n", "i" }, "<F2>", vim.lsp.buf.rename, { noremap = true, desc = "Rename symbol" })
vim.keymap.set("n", "gf", vim.lsp.buf.format, { noremap = true, desc = "Format buffer" })
vim.keymap.set({ "n", "i" }, "<A-S-f>", vim.lsp.buf.format, { noremap = true, desc = "Format buffer" })
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
