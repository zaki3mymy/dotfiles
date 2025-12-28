-- TODO: もう少し上手く設定できないか。。。
vim.lsp.config("lua_ls", {
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/lua-language-server" },
  filetypes = { "lua" },
  -- `vim`キーワードの警告対応
  settings = {
    Lua = {
      workspace = {
        library = {
          vim.env.VIMRUNTIME .. "/lua",
        },
      },
    },
  },
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    if vim.uv.fs_stat(vim.fn.getcwd() .. "/.venv/bin/ruff") then
      vim.lsp.config("ruff", {
        cmd = { "uv", "run", "ruff", "server" },
      })
      vim.lsp.enable("ruff")
    end
    if vim.uv.fs_stat(vim.fn.getcwd() .. "/.venv/bin/ty") then
      vim.lsp.config("ty", {
        cmd = { "uv", "run", "ty", "server" },
      })
      vim.lsp.enable("ty")
    end
  end,
})

-- 自動フォーマット
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})

-- 診断結果を表示する
vim.o.updatetime = 500
vim.diagnostic.config({ virtual_text = true })
vim.api.nvim_create_autocmd("CursorHold", {
  -- カーソルが概要箇所に来たらフロート表示する
  callback = function()
    vim.diagnostic.open_float(nil, {
      focus = false,
      scope = "cursor",
    })
  end,
})
