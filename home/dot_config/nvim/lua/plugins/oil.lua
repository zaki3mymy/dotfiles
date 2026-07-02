-- 常に表示したい隠しファイル
-- luaではエスケープは`\`ではなく`%`
local always_show_files = {
  "%.claude",
  "%.github",
  "%.gitconfig",
  "%.gitignore",
  "%..+%.local%..+", -- globalの.gitignoreで除外しているファイル
}

return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  -- lazy = false,
  event = "VimEnter",
  config = function()
    require("oil").setup({
      view_options = {
        show_hidden = false,
        is_hidden_file = function(name, _)
          for _, regex in ipairs(always_show_files) do
            if name:match(regex) then
              return false
            end
          end
          local m = name:match("^%.")
          return m ~= nil
        end,
      },
    })
  end,
  keys = {
    { "<leader>-", "<Cmd>Oil<CR>", mode = "n" },
  },
}
