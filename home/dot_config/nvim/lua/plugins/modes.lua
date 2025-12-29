return {
  "mvllow/modes.nvim",
  event = "VeryLazy",
  dependencies = {
    "catppuccin/nvim",
  },
  config = function()
    local palette = require("catppuccin.palettes").get_palette()

    require("modes").setup({
      colors = {
        bg = "",
        copy = palette.yellow,
        delete = palette.red,
        insert = palette.sky,
        visual = palette.mauve,
      },
      line_opacity = 0.25,
      set_cursor = true,
      set_cursorline = true,
      set_number = true,
      ignore_filetypes = { "oil", "lazy" },
    })
  end,
}
