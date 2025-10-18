-- プラグインの設定
-- プラグインマネージャー(lazy.nvim)のインストール
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)
local plugins = {
    {
        -- 検索ツール(Telescope)
        "nvim-telescope/telescope.nvim", tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    {
        -- カラースキーマ(Catppuccin)
        "catppuccin/nvim", name = "catppuccin", priority = 1000
    },
    {
        -- 構文解析ツール(Tree-sitter)
        "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"
    },
    {
        -- ファイルエクスプローラー(Neo-Tree)
        "nvim-neo-tree/neo-tree.nvim", branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        }
    },
}
local opts = {}
require("lazy").setup(plugins, opts)

-- 検索ツール(Telescope)の設定
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<C-g>", builtin.live_grep, {})

-- カラースキーマ(Catppuccin)の設定
require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"

-- 構文解析ツール
local configs = require("nvim-treesitter.configs")
configs.setup({
    ensure_installed = {
        "bash",
        "lua",
        "javascript",
        "typescript",
        "json",
        "json5",
        "python",
        "haskell",
        "sql",
        "toml",
        "yaml",
    },
    sync_install = false,
    highlight = { enable = true },
    indent = { enable = true },
})

-- ファイルエクスプローラー(Neo-Tree)
vim.keymap.set("n", "<C-n>", ":Neotree toggle<CR>")
require("neo-tree").setup({
    close_if_last_window = true, -- エディタを閉じたらファイルエクスプローラーも閉じる
    filesystem = {
        window = {
            width = 24
        }
    }
})

-- 個人設定
-- タブ文字をスペースにする
vim.cmd("set expandtab")
-- タブ幅を半角スペース4文字にする
vim.cmd("set tabstop=4")
-- INSERTモードでのタブ幅を半角スペース４文字にする
vim.cmd("set softtabstop=4")
-- インデントを半角スペース４文字にする
vim.cmd("set shiftwidth=4")

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
-- カラースキーマの設定色を上書きする
vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#21223a" })

-- Ctrl-S で保存
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a")

-- h,lで行をまたぐ
vim.cmd("set whichwrap=<,>,h,l")

-- 上端と下端に余裕をもたせる
vim.cmd("set scrolloff=5")

