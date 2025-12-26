-- ファイルエクスプローラー(Neo-Tree)
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      -- bufferline.nvimと相性が悪いので設定しない
      --close_if_last_window = true, -- エディタを閉じたらファイルエクスプローラーも閉じる
      filesystem = {
        window = {
          width = 30,
        },
      },
      window = {
        mappings = {
          -- ウィンドウを増減させるためにデフォルトの割当を削除する
          ["l"] = "",
        },
      },
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
  end,
}
