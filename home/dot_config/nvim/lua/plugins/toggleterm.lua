return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        -- 同じキーを入力するとターミナルを閉じることができる
        open_mapping = [[<leader>@]],
        direction = "float",
      })
    end,
  },
}
