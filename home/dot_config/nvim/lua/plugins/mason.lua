return {
  "williamboman/mason.nvim",
  version = "*",
  event = "VeryLazy",
  config = function()
    require("mason").setup()
  end,
}
