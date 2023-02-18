

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


require 'lspconfig'.lua_ls.setup {
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim', 'lvim' }
      }
    }
  }
}
vim.diagnostic.config({
  virtual_text = true,
})
