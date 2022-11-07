local lsp = require('lsp-zero')

lsp.preset('recommended')
lsp.setup()

lsp.configure('eslint', {
  settings = {
    workingDirectory = { mode = 'location' },
    format = false,
  },
  root_dir = require 'lspconfig'.util.root_pattern(
    '.eslintrc.js',
    '.eslintrc.json'
  ),
})

-- https://github.com/typescript-language-server/typescript-language-server/issues/216#issuecomment-1005272952
-- Ignore react/index.d.ts when going to definition of components
local function filter(arr, fn)
  if type(arr) ~= "table" then
    return arr
  end

  local filtered = {}
  for k, v in pairs(arr) do
    if fn(v, k, arr) then
      table.insert(filtered, v)
    end
  end

  return filtered
end

local function filterReactDTS(value)
  -- depending on the version of typescript, we might need to look at uri or
  -- targetUri
  local targetVal = value.uri
  if targetVal == nil then
    targetVal = value.targetUri
  end
  return string.match(value.targetUri, 'react/index.d.ts') == nil
end

require 'lspconfig'.tsserver.setup {
  on_attach = function(client)
    client.server_capabilities.documentFormattingProvider = false
  end,
  handlers = {
    ['textDocument/definition'] = function(err, result, method, ...)
      if vim.tbl_islist(result) and #result > 1 then
        local filtered_result = filter(result, filterReactDTS)
        return vim.lsp.handlers['textDocument/definition'](err, filtered_result, method, ...)
      end

      vim.lsp.handlers['textDocument/definition'](err, result, method, ...)
    end
  }
}

lsp.configure('sumneko_lua', {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim', 'lvim' }
      }
    }
  }
})
