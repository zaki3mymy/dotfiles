-- タブ設定
vim.cmd("set expandtab")     -- タブ文字をスペースにする
vim.cmd("set tabstop=4")     -- タブ幅を半角スペース4文字にする
vim.cmd("set softtabstop=4") -- INSERTモードでのタブ幅を半角スペース４文字にする
vim.cmd("set shiftwidth=4")  -- インデントを半角スペース４文字にする
vim.cmd("set autoindent")    -- 改行時に前の行のインデントを継続
vim.cmd("set smartindent")   -- 改行時にインデントを調整

-- mode切り替えのショートカット
vim.api.nvim_set_keymap("i", "jj", "<ESC>", {noremap = true, silent = true})
-- クリップボードの使用
vim.opt.clipboard:append({"unnamedplus"})

-- 現在行は絶対行番号でその他は相対行番号
vim.opt.number = true
vim.opt.relativenumber = true
-- 現在行と列を目立たせる
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
-- 現在列の色の設定
vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#21223a" })

-- Ctrl-S で保存
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a")


-- h,lで行をまたぐ
vim.cmd("set whichwrap=<,>,h,l")

-- 上端と下端に余裕をもたせる
vim.cmd("set scrolloff=5")

-- 前回終了時の位置にカーソルを移動する
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

-- コマンドを右下に表示
vim.cmd("set showcmd")

-- <leader>キーをスペースを割り当てる
vim.g.mapleader = " "

