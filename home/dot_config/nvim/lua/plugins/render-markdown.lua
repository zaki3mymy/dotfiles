-- tree-sitter-cli がインストール済みであること
return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
    "folke/snacks.nvim",
  },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {},
  config = function()
    require("render-markdown").setup({
      -- https://eiji.page/blog/neovim-render-markdown-nvim/
      render_mode = true,
      heading = {
        width = "block",
        left_pad = 0,
        right_pad = 0,
        icons = {},
      },
      code = {
        conceal_delimiters = false,
        border = "none",
        width = "block",
        highlight = "RenderMarkdownCodeX", -- 自分で定義した背景色に変えたい
      },
      latex = {
        enabled = true,
        converter = { "latex2text" },
        inline = true,
        block = true,
        position = "center",
      },
    })
    -- コードブロックの背景色を変える
    vim.api.nvim_set_hl(0, "RenderMarkdownCodeX", { bg = "#282824" })

    -- markdown のコードブロックのハイライト
    vim.g.markdown_fenced_languages = { "python", "go", "bash", "lua", "json" }
    require("nvim-treesitter.config").setup({
      ensure_inatalled = {
        "markdown",
        "markdown_inline",
        "python",
        "go",
        "lua",
        "json",
      },
      highlight = {
        enable = true,
      },
    })
    -- markdown のときのみtreesitterを有効にする
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",
      callback = function(args)
        if vim.bo[args.buf].filetype == "markdown" then
          pcall(vim.treesitter.start, args.buf)
        else
          vim.treesitter.stop(args.buf)
          vim.wo.foldmethod = "manual"
          vim.wo.foldexpr = "0"
        end
      end,
    })

    -- mermaid 用設定
    require("snacks").setup({
      image = {
        doc = {
          enabled = true,
          inline = true,
          max_width = 256,
        },
      },
    })
  end,
}
