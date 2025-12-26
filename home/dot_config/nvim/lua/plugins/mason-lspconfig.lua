return {
  "williamboman/mason-lspconfig.nvim",
  version = "*",
  lazy = false,
  config = function()
    local lsp_servers = {
      -- 3.16.0 ではうまく起動しない
      -- https://github.com/LuaLS/lua-language-server/issues/3301
      "lua_ls@3.15.0",
    }
    local diagnostics = {
      "typos_lsp",
    }
    local ensure_installed = vim.iter({ lsp_servers, diagnostics }):flatten():totable()

    require("mason-lspconfig").setup({
      automatic_installation = true,
      ensure_installed = ensure_installed,
    })
    vim.lsp.enable(ensure_installed)
  end,
}
