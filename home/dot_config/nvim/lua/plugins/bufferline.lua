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
}
