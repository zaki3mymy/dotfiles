local lsp_servers = {
    -- 3.16.0 ではうまく起動しない
    -- https://github.com/LuaLS/lua-language-server/issues/3301
    "lua_ls@3.15.0",
    "pyright",
}
local diagnostics = {
    "typos_lsp",
}
local ensure_installed = vim.iter({ lsp_servers, diagnostics }):flatten():totable()

require("mason").setup()
require("mason-lspconfig").setup({
    automatic_installation = true,
    ensure_installed = ensure_installed,
})

vim.lsp.config("lua_ls", {
    cmd = { vim.fn.stdpath("data") .. "/mason/bin/lua-language-server" },
    filetypes = { "lua" },
    -- `vim`キーワードの警告対応
    settings = {
        Lua = {
            workspace = {
                library = {
                    vim.env.VIMRUNTIME .. "/lua",
                }
            }
        }
    },
})
vim.lsp.enable(ensure_installed)

-- キーマップの設定
-- カーソル下の変数の情報
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
-- 定義ジャンプ
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
-- 定義ジャンプ後に下のファイルに戻る
vim.keymap.set("n", "gt", "<C-t>")
-- 改行やインデントなどのフォーマット
vim.keymap.set("n", "gf", "<cmd>lua vim.lsp.buf.formatting()<CR>")
-- カーソル下の変数をコード内で参照している箇所
vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
-- 変数名のリネーム
vim.keymap.set("n", "gn", "<cmd>lua vim.lsp.buf.rename()<CR>")

-- 自動補完の設定

-- lspの設定後に追加
vim.cmd[[set completeopt+=menu,menuone,noselect]]

local cmp = require("cmp")
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
    }, {
        { name = "buffer" },
    })
})

