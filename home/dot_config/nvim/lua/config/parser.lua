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

