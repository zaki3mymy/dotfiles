return {
  {
    "nvim-mini/mini.pairs",
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.pairs").setup()
    end,
  },
  {
    "nvim-mini/mini.surround",
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.surround").setup()
    end,
  },
  {
    "nvim-mini/mini.map",
    version = false,
    event = "BufReadPre",
    config = function()
      local map = require("mini.map")
      map.setup({
        integrations = {
          map.gen_integration.builtin_search(),
          map.gen_integration.diff(),
          map.gen_integration.diagnostic(),
          map.gen_integration.gitsigns(),
        },
        symbols = {
          scroll_line = "▶",
        },
      })
      vim.keymap.set("n", "<leader>mmf", map.toggle_focus, { desc = "MiniMap.toggle_focus" })
      vim.keymap.set("n", "<leader>mms", map.toggle_side, { desc = "MiniMap.toggle_side" })
      vim.keymap.set("n", "<leader>mmt", map.toggle, { desc = "MiniMap.toggle" })

      local ignore_ft = {
        [""] = true,
        ["gitcommit"] = true,
        ["markdown"] = true,
        ["oil"] = true,
      }
      vim.api.nvim_create_autocmd({ "BufEnter" }, {
        callback = function()
          local bt = vim.bo.buftype
          local ft = vim.bo.filetype

          if ignore_ft[ft] then
            map.close()
            return
          end

          if bt == "" then
            map.open()
          end
        end,
      })
    end,
  },
}
