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
local plugins = {}
local opts = {}
require("lazy").setup(plugins, opts)

