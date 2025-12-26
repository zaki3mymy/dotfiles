return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      -- ターミナルモードから抜けるための設定
      -- TODO: keymaps.luaに移動
      vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })
      vim.keymap.set("t", "jj", [[<C-\><C-n>]], { noremap = true })

      require("toggleterm").setup({
        -- 同じキーを入力するとターミナルを閉じることができる
        open_mapping = [[<leader>@]],
        direction = "float",
      })
    end,
  },
}
