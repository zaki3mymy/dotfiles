-- タブ文字をスペースにする
vim.cmd("set expandtab")
-- タブ幅を半角スペース4文字にする
vim.cmd("set tabstop=4")
-- INSERTモードでのタブ幅を半角スペース４文字にする
vim.cmd("set softtabstop=4")
-- インデントを半角スペース４文字にする
vim.cmd("set shiftwidth=4")

-- mode切り替えのショートカット
vim.api.nvim_set_keymap('i', 'jj', '<ESC>', {noremap = true, silent = true})
-- クリップボードの使用
vim.opt.clipboard:append({"unnamedplus"})

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
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        -- カラースキーマ(Catppuccin)
        'catppuccin/nvim', name = 'catppuccin', priority = 1000
    },
    {
        -- 構文解析ツール(Tree-sitter)
        "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"
    },
}
local opts = {}
require("lazy").setup(plugins, opts)

-- 検索ツール(Telescope)の設定
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<C-g>', builtin.live_grep, {})

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

