local lsp_servers = {
    -- 3.16.0 ではうまく起動しない
    -- https://github.com/LuaLS/lua-language-server/issues/3301
    "lua_ls@3.15.0",
}
local diagnostics = {
    "typos_lsp",
}
local ensure_installed = vim.tbl_flatten({ lsp_servers, diagnostics })

require("mason").setup()
require("mason-lspconfig").setup({
    automatic_installation = true,
    ensure_installed = ensure_installed,
})

-- 自動補完の設定
vim.cmd[[set completeopt+=menuone,noselect,popup]]
vim.lsp.config("lua_ls", {
    cmd = { vim.fn.stdpath("data") .. "/mason/bin/lua-language-server" },
    filetypes = { "lua" },
    on_attach = function(client, bufnr)
        vim.lsp.completion.enable(true, client.id, bufnr, {
            autotrigger = true,
            convert = function(item)
                return { abbr = item.label:gsub('%b()', '') }
            end,
        })
    end,
})
vim.lsp.enable(ensure_installed)
vim.keymap.set('i', '<c-space>', function()
    vim.lsp.completion.get()
end)

