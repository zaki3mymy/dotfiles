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
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#8a4a52" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#8a7448" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#3f6b8f" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#8a6848" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#6b8a57" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#7a4a8a" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#3f7f8a" })
    end)

    require("ibl").setup({
      indent = {
        highlight = highlight,
        char = "▏",
        tab_char = "▏",
      },
      scope = {
        enabled = true,
        char = "▎",
      },
    })
  end,
}
