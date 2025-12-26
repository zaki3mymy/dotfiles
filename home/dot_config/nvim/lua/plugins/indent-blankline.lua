return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  ---@module "ibl"
  ---@type ibl.config
  opts = {},
  config = function()
    local highlight = {
      "RainbowRed",
      "RainbowYellow",
      "RainbowBlue",
      "RainbowOrange",
      "RainbowGreen",
      "RainbowViolet",
      "RainbowCyan",
    }

    local hooks = require("ibl.hooks")
    -- create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#612f33" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#615134" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#284761" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#61472f" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#4a613c" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#563461" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#2b5a61" })
    end)

    require("ibl").setup({
      indent = {
        highlight = highlight,
        char = "▏",
      },
    })
  end,
}
