local toggle = function()
  local zen = require("zen-mode")
  local view = require("zen-mode.view")
  if view.is_open() then
    vim.keymap.set("n", "j", "j")
    vim.keymap.set("n", "k", "k")
    zen.close()
  else
    vim.keymap.set("n", "j", "jzz")
    vim.keymap.set("n", "k", "kzz")
    zen.open()
  end
end

return {
  "folke/zen-mode.nvim",
  opts = {
    window = {
      width = 60,
      options = {
        signcolumn = "no",
        number = false,
        relativenumber = false,
      },
    },
  },
  keys = {
    { "<leader>z", toggle, mode = "n" },
  },
}
