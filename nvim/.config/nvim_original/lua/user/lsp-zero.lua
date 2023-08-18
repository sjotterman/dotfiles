require("neodev").setup()
local lsp = require('lsp-zero').preset({
  name = 'recommended',
  set_lsp_keymaps = {
    omit = { '<C-k>', 'gd' },
    preserve_mappings = false
  }
})

vim.keymap.set("n", "gd", "<cmd>lua my_goto_definition()<cr>")

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()

lsp.ensure_installed({
  'tsserver',
  'eslint',
  "jsonls",
})

lsp.format_on_save({
  servers = {
    ['lua_ls'] = { 'lua' },
    ['null-ls'] = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' }
  }
})

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

-- https://github.com/folke/dot/commit/aef729a076970e770ed84d817419551e82951d2c
lsp.configure('tailwindcss', {
  root_dir = function(...)
    return require("lspconfig.util").root_pattern("package.json", ".git")(...)
  end,
})
-- integrate typescreipt.nvim with tsserver
-- https://github.com/VonHeikemen/lsp-zero.nvim/discussions/39#discussioncomment-3311521
require("typescript").setup({
  go_to_source_definition = {
    fallback = true, -- fall back to standard LSP definition on failure
  },
  server = lsp.build_options('tsserver', {
    root_dir = function(...)
      return require("lspconfig.util").root_pattern("package.json", ".git")(...)
    end,
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
  })
})

vim.diagnostic.config({
  virtual_text = true,
})
