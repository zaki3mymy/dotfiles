-- Gitの設定
require("gitsigns").setup({
    -- 行番号に色を付ける
    numhl = true,
    -- カーソル行の変更を行末に表示する
    current_line_blame = true,
    current_line_blame_opts = {
        delay = 100
    },
    on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
            if vim.wo.diff then
                vim.cmd.normal({"]c", bang = true})
            else
                gitsigns.nav_hunk("next")
            end
        end)
        map("n", "[c", function()
            if vim.wo.diff then
                vim.cmd.normal({"[c", bang = true})
            else
                gitsigns.nav_hunk("prev")
            end
        end)

        -- Actions
        -- stage/unstage
        map('n', '<leader>hs', gitsigns.stage_hunk)
        map('v', '<leader>hs', function()
            gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end)
        map('n', '<leader>hS', gitsigns.stage_buffer)
        -- reset
        map('n', '<leader>hr', gitsigns.reset_hunk)
        map('v', '<leader>hr', function()
            gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end)
        map('n', '<leader>hR', gitsigns.reset_buffer)

        -- Preview
        map('n', '<leader>hp', gitsigns.preview_hunk)
        map('n', '<leader>hi', gitsigns.preview_hunk_inline)
    end
})

