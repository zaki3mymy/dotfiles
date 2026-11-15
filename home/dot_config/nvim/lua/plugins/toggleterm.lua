return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("toggleterm").setup({
        -- 同じキーを入力するとターミナルを閉じることができる
        open_mapping = [[<leader>@]],
        direction = "float",
        -- INSERTモードで誤爆を防ぐ
        insert_mappings = false,
      })
    end,
  },
}
