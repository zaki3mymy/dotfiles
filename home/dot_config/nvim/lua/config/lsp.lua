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

-- キーマップの設定
-- カーソル下の変数の情報
vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
-- 定義ジャンプ
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
-- 定義ジャンプ後に下のファイルに戻る
vim.keymap.set("n", "gt", "<C-t>")
-- 改行やインデントなどのフォーマット
vim.keymap.set("n", "gf", "<cmd>lua vim.lsp.buf.formatting()<CR>")
-- カーソル下の変数をコード内で参照している箇所
vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
-- 変数名のリネーム
vim.keymap.set("n", "gn", "<cmd>lua vim.lsp.buf.rename()<CR>")

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
