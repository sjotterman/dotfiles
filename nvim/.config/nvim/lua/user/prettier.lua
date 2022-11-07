local null_ls = require("null-ls")
local prettier = require("prettier")

null_ls.setup({
  on_attach = function(client, bufnr)
    if client.server_capabilities.document_formatting then
      -- format on save
      vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.format { async = true }")

    end
  end,
})

prettier.setup({
  bin = 'prettier', -- or `prettierd`
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    -- "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },

  -- prettier format options (you can use config files too. for example, `.prettierrc`)
})
