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
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      underline = true,
      update_in_insert = false,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = false, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "yes:1",
        wrap = true, -- sets vim.opt.wrap
        -- winbar="%f %m ",
        wildmode = "full:longest",
        foldcolumn = "0",
        scrolloff = 8,
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
        cmp_enabled = true, -- enable completion at start
        autopairs_enabled = true, -- enable autopairs at start
        diagnostics_mode = 3, -- set the visibility of diagnostics in the UI (0=off, 1=only show in status line, 2=virtual text off, 3=all on)
      },
    },
    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = {
      -- first key is the mode
      n = {
        -- second key is the lefthand side of the map

        -- navigate buffer tabs with `H` and `L`
        -- L = {
        --   function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
        --   desc = "Next buffer",
        -- },
        -- H = {
        --   function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
        --   desc = "Previous buffer",
        -- },

        -- mappings seen under group name "Buffer"
        ["<Leader>bD"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<Leader>b"] = { desc = "Buffers" },
        -- quick save
        -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
        ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
        ["<leader>bh"] = { "<cmd>call DeleteHiddenBuffers()<cr>", desc = "Close Hidden buffers" },
        ["<leader>bD"] = {
          function()
            require("astronvim.utils.status").heirline.buffer_picker(
              function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
            )
          end,
          desc = "Pick to close",
        },
        -- tables with the `name` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        ["<leader>b"] = { name = "Buffers" },

        ["<leader>F"] = { "<cmd>Telescope flutter commands<cr>", desc = "Flutter" },
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
        -- ["<leader>kx"] = {
        --   '<cmd>TermExec size=80 direction=vertical cmd="z capabuild && xc_help.sh && exit"<cr>',
        --   desc = "xc help",
        -- },
        ["<leader>kgm"] = {
          '<cmd>TermExec size=80 direction=vertical cmd="z frontend && npm run generate && exit"<cr>',
          desc = "Generate Mobile Types",
        },
        ["<leader>k"] = { name = "Keybinds" },
        ["<leader>kg"] = { name = "Generate types" },
        ["<leader>lt"] = { name = "Typescript" },
        ["<leader>ltd"] = { "<cmd>TSToolsGoToSourceDefinition<cr>", desc = "Go to Source Definition" },
        ["<leader>ltm"] = { "<cmd>TSToolsAddMissingImports<cr>", desc = "Add Missing Imports" },
        ["<leader>lto"] = { "<cmd>TSToolsOrganizeImports<cr>", desc = "Organize Imports" },
        ["<leader>ltf"] = { "<cmd>TSToolsFixAll<cr>", desc = "TS Fix All" },
        ["<leader>ltr"] = { "<cmd>TSToolsRenameFile<cr>", desc = "Rename File" },
        ["<leader>ltu"] = { "<cmd>TSToolsRemoveUnused<cr>", desc = "Remove Unused Variables" },
        ["<leader>ltU"] = { "<cmd>TSToolsRemoveUnusedImports<cr>", desc = "Remove Unused Imports" },
        ["<leader>ltR"] = { "<cmd>TSToolsFileReferences<cr>", desc = "File References" },
        ["<leader>lte"] = { "<cmd>:EslintFixAll<cr>", desc = "Eslint Fix All" },
        ["<leader>ltw"] = {
          "<cmd>:DiagWindowShow<cr>",
          desc = "Show diagnostic window",
        },
      },
      t = {
        -- setting a mapping to false will disable it
        -- ["<esc>"] = false,
      },
    },
  },
}
