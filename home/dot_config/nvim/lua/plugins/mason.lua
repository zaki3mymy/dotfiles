-- LSPプラグイン
-- https://wagomu.me/blog/2023-05-17-vim-ekiden
return {
    {
        "mason-org/mason.nvim",
        build = ":MasonUpdate",
        opts = {},
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            { "mason-org/mason.nvim" },
            { "neovim/nvim-lspconfig" },
            { "nvim-mini/mini.completion" },
        },
    },
}

