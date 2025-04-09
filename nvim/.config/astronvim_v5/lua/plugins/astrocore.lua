-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics = { virtual_text = true, virtual_lines = false }, -- diagnostic settings on startup
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = false, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes", -- sets vim.opt.signcolumn to yes
        wrap = false, -- sets vim.opt.wrap
        wildmode = "full:longest",
        foldcolumn = "0",
        scrolloff = 8,
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

        -- mappings seen under group name "Buffer"
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },
        ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
        ["<leader>bh"] = { "<cmd>call DeleteHiddenBuffers()<cr>", desc = "Close Hidden buffers" },

        ["<leader>gG"] = { "<cmd>:vertical Git<CR>", desc = "Fugitive Status" },
        ["<leader>gq"] = { "<cmd>:vertical Git log --decorate<CR>", desc = "git log (pretty)" },
        ["<leader>gT"] = { "<cmd>:Gitsigns<CR>", desc = "Gitsigns commands" },
        -- I don't use the default gL, which opens a popup with blame info
        ["<leader>gL"] = { "<cmd>:Git blame<CR>", desc = "Git Blame (by line)" },
        --Custom tasks
        ["<leader>kc"] = {
          '<cmd>TermExec size=80 direction=vertical cmd="z django && make clean-run-backend && exit"<cr>',
          desc = "make clean-run-backend",
        },
        ["<leader>ks"] = {
          '<cmd>TermExec size=80 direction=vertical cmd="z django && make generate-schema && exit"<cr>',
          desc = "generate django schema",
        },
        ["<leader>kgw"] = {
          '<cmd>TermExec size=80 direction=vertical cmd="z web && yarn generate && exit"<cr>',
          desc = "Generate Web Types",
        },
        ["<leader>kt"] = {
          '<cmd>TermExec size=80 direction=vertical cmd="z capabuild && xc schema-update && exit"<cr>',
          desc = "generate all types",
        },
        ["<leader>kgm"] = {
          '<cmd>TermExec size=80 direction=vertical cmd="z frontend && npm run generate && exit"<cr>',
          desc = "Generate Mobile Types",
        },
        ["<leader>k"] = { name = "Keybinds" },
        ["<leader>kg"] = { name = "Generate types" },
        ["<leader>lt"] = { name = "Typescript" },
        ["<leader>ltd"] = { "<cmd>VtsExec goto_source_definition<cr>", desc = "Go to Source Definition" },
        ["<leader>ltm"] = { "<cmd>VtsExec add_missing_imports<cr>", desc = "Add Missing Imports" },
        ["<leader>lto"] = { "<cmd>VtsExec organize_imports<cr>", desc = "Organize Imports" },
        ["<leader>ltf"] = { "<cmd>VtsExec fix_all<cr>", desc = "TS Fix All" },
        ["<leader>ltr"] = { "<cmd>VtsExec rename_file<cr>", desc = "Rename File" },
        ["<leader>ltu"] = { "<cmd>VtsExec remove_unused<cr>", desc = "Remove Unused Variables" },
        ["<leader>ltU"] = { "<cmd>VtsExec remove_unused_imports<cr>", desc = "Remove Unused Imports" },
        ["<leader>ltR"] = { "<cmd>VtsExec file_references<cr>", desc = "File References" },
        ["<leader>lte"] = { "<cmd>:EslintFixAll<cr>", desc = "Eslint Fix All" },
        ["<leader>j"] = { name = "Notes" },
        ["<leader>jh"] = { "<cmd>:Telekasten new_note<cr>", desc = "new note" },
        ["<leader>jd"] = { "<cmd>:Telekasten goto_today<cr>", desc = "daily note" },
        ["<leader>js"] = { "<cmd>:Telekasten search_notes<cr>", desc = "search" },
        ["<leader>jp"] = { "<cmd>:Telekasten panel<cr>", desc = "panel" },
        ["<leader>jf"] = { "<cmd>:Telekasten find_notes<cr>", desc = "find" },
        ["<leader>jg"] = { "<cmd>:Telekasten follow_link<cr>", desc = "Go to link" },
        ["<leader>j<cr>"] = { "<cmd>:Telekasten toggle_todo<cr>", desc = "toggle_todo" },
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
      },
    },
  },
}
