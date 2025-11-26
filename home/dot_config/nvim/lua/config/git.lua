-- Gitの設定
require("gitsigns").setup({
    -- カーソル行の変更を行末に表示する
    current_line_blame = true,
    current_line_blame_opts = {
        delay = 100
    }
})

