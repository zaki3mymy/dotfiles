return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  lazy = false,
  config = function()
    vim.opt.termguicolors = true -- TODO: options.luaに移動
    vim.opt.hidden = true -- TODO: options.luaに移動

    require("bufferline").setup({
      options = {},
    })
  end,
  keys = {
    { "<leader>l", "<Cmd>bnext<CR>", mode = { "n", "i" } },
    { "<leader>h", "<Cmd>bprev<CR>", mode = { "n", "i" } },
    { "<leader>w", "<Cmd>bw<CR>", mode = { "n", "i" } },
  },
}
