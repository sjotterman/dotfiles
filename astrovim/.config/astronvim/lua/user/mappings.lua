-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(function(bufnr) require("astronvim.utils.buffer").close(bufnr) end)
      end,
      desc = "Pick to close",
    },
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    ["<leader>b"] = { name = "Buffers" },

    ["<leader>gG"] = { "<cmd>:vertical Git<CR>", desc = "Fugitive Status"},
    ["<leader>gq"] = { "<cmd>:vertical Git log --decorate<CR>", desc = "git log (pretty)" },
    -- quick save
    -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
    --Custom tasks
    ["<leader>kc"] = { "<cmd>TermExec size=80 direction=vertical cmd=\"z django && make clean-run-backend && exit\"<cr>", desc = "make clean-run-backend"},
    ["<leader>kgw"] = { "<cmd>TermExec size=80 direction=vertical cmd=\"z web && yarn generate && exit\"<cr>", desc = "Generate Web Types"},
    ["<leader>kgm"] = { "<cmd>TermExec size=80 direction=vertical cmd=\"z frontend && npm run generate && exit\"<cr>", desc = "Generate Mobile Types"},
    ["<leader>k"] = { name = "Keybinds" },
    ["<leader>kg"] = { name = "Generate types" },

    ["<leader>lt"] = { name = "Typescript" },
      ["<leader>ltd"] = { "<cmd>TypescriptGoToSourceDefinition<cr>",  desc = "Go to Source Definition" },
      ["<leader>ltm"] = { "<cmd>TypescriptAddMissingImports<cr>",  desc = "Add Missing Imports" },
      ["<leader>lto"] = { "<cmd>TypescriptOrganizeImports<cr>",  desc = "Organize Imports" },
      ["<leader>ltr"] = { "<cmd>TypescriptRenameFile<cr>",  desc = "Rename File" },
      ["<leader>ltu"] = { "<cmd>TypescriptRemoveUnused<cr>",  desc = "Remove Unused Variables" },
      ["<leader>lte"] = { "<cmd>:EslintFixAll<cr>",  desc = "Eslint Fix All" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
