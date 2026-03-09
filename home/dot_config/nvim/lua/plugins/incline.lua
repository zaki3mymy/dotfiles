local get_relative_path = function(props)
  local file_path = vim.api.nvim_buf_get_name(props.buf)
  local cwd = vim.fn.getcwd()
  -- Function to make path relative (simplified)
  local relative_path
  if file_path:find(cwd, 1, true) == 1 then
    -- If file path starts with cwd, get the relative part
    relative_path = file_path:sub(#cwd + 2) -- +2 to remove leading '/' or '\'
    if relative_path == "" then
      relative_path = "./"
    end
  else
    -- Fallback to absolute path or home-relative path if outside cwd
    relative_path = vim.fn.expand("%:~") or file_path
  end

  -- You can add icons and other components as desired
  local filename = vim.fn.fnamemodify(file_path, ":t") -- Get just the filename
  if relative_path == filename then
    -- File in current working directory, display just the name or './filename'
    relative_path = "./" .. filename
  end
  return relative_path
end

return {
  "b0o/incline.nvim",
  event = { "VeryLazy" },
  config = function()
    local helpers = require("incline.helpers")
    local devicons = require("nvim-web-devicons")
    require("incline").setup({
      -- highlight = {
      --   InclineNormalNC = { guibg = "none" }
      -- },
      window = {
        padding = 2,
        margin = { horizontal = 0, vertical = 2 },
        placement = {
          horizontal = "right",
          vertical = "top",
        },
      },
      render = function(props)
        local filename = get_relative_path(props)
        local ft_icon, ft_color = devicons.get_icon_color(filename)
        local modified = vim.bo[props.buf].modified
        return {
          ft_icon and { " ", ft_icon, " ", guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or "",
          " ",
          { filename, gui = modified and "bold,italic" or "bold" },
          " ",
          guibg = "#44406e",
        }
      end,
    })
  end,
}
