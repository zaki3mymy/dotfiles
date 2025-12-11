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

-- 自動補完の設定
vim.cmd[[set completeopt+=menuone,noselect,popup]]
vim.lsp.config("*", {
    on_attach = function(client, bufnr)
        vim.lsp.completion.enable(true, client.id, bufnr, {
            autotrigger = true,
            convert = function(item)
                return { abbr = item.label:gsub('%b()', '') }
            end,
        })
        vim.keymap.set('i', '<c-space>', function()
            vim.lsp.completion.get()
        end)
    end,
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

