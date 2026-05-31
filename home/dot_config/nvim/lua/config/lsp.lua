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
    local function set_py_lsp(name, command)
      vim.lsp.config(name, {
        cmd = command,
      })
      vim.lsp.enable(name)
      -- pyproject.toml保存時に設定を再読込する
      vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "pyproject.toml",
        callback = function()
          vim.cmd("LspRestart " .. name)
        end,
      })
    end

    if vim.uv.fs_stat(vim.fn.getcwd() .. "/.venv/bin/ruff") then
      set_py_lsp("ruff", { "uv", "run", "ruff", "server" })
    end
    if vim.uv.fs_stat(vim.fn.getcwd() .. "/.venv/bin/ty") then
      set_py_lsp("ty", { "uv", "run", "ty", "server" })
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.lsp.config("gopls", {
      cmd = { "gopls", "serve" },
    })
    vim.lsp.enable("gopls")
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
vim.diagnostic.config({
  virtual_text = true,
  float = {
    border = "rounded",
  },
})
