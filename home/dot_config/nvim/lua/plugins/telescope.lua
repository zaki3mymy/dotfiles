-- 検索ツール(Telescope)
return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local ignore_patterns = {
      ".git/",
    }
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<C-p>", function()
      builtin.find_files({
        hidden = true,
        file_ignore_patterns = ignore_patterns,
      })
    end, {})
    vim.keymap.set("n", "<C-g>", function()
      builtin.live_grep({
        file_ignore_patterns = ignore_patterns,
        additional_args = {
          "--hidden",
        },
      })
    end, {})
  end,
}
