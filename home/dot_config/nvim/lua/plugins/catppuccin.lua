-- カラースキーマ(Catppuccin)
return {
  "catppuccin/nvim",
  name = "catppuccin",
  event = "VimEnter",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      transparent_background = true,
      highlight_overrides = {
        all = function(palette)
          return {
            -- 行番号が見づらいので上書き
            LineNr = { fg = palette.overlay0 },
          }
        end,
      },
    })
  end,
}
