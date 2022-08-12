local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.setup()

require 'lspconfig'.eslint.setup {
  settings = {
    workingDirectory = { mode = 'location' },
    format = false,
  },
  root_dir = require 'lspconfig'.util.root_pattern(
    '.git',
    '.eslintrc.json',
    '.eslintrc.js'
  ),
}

require 'lspconfig'.tsserver.setup {
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end,
}

require 'lspconfig'.sumneko_lua.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim', 'lvim' }
      }
    }
  }
}
