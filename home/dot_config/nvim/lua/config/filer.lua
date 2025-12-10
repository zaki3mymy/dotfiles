-- ファイルエクスプローラー(Neo-Tree)
require("neo-tree").setup({
    -- bufferline.nvimと相性が悪いので設定しない
    --close_if_last_window = true, -- エディタを閉じたらファイルエクスプローラーも閉じる
    filesystem = {
        window = {
            width = 30
        }
    },
    window = {
        mappings = {
            -- ウィンドウを増減させるためにデフォルトの割当を削除する
            ["l"] = "",
        }
    },
})
-- 起動時にファイルエクスプローラーも開く
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        -- Gitから開かれたときはスキップする
        local fname = vim.fn.expand("%:t")
        if os.getenv("GIT_INDEX_FILE")
            or fname == "COMMIT_EDITMSG"
            or fname == "MERGE_MSG"
            or fname == "TAG_EDITMSG" then
                return
        end

        vim.cmd("Neotree filesystem reveal left")
        -- ファイルが指定されていたらそちらにフォーカスする
        if vim.fn.argc() > 0 then
            vim.cmd("wincmd l")
        end
    end,
})
-- Ctrl-N でトグル
vim.keymap.set("n", "<C-n>", ":Neotree toggle<CR>")

-- Neo-treeのウィンドウの幅を増減させる
vim.api.nvim_create_autocmd("FileType", {
    pattern = "neo-tree",
    callback = function()
        local opts = { buffer = true, silent = true, noremap = true }
        vim.keymap.set("n", "h", "<C-w><", opts)
        vim.keymap.set("n", "l", "<C-w>>", opts)
    end,
})

