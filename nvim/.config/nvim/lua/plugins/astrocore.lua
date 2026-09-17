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
        wrap = true, -- sets vim.opt.wrap
        wildmenu = true,
        wildmode = "list:longest",
        foldcolumn = "0",
        scrolloff = 8,
        winbar = "%f %m ",
        showtabline = 2,
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
        ["<leader>fP"] = {
          function()
            require("snacks").picker.files {
              cwd = vim.fn.expand "~/.cursor/plans",
              matcher = { sort_empty = true },
              transform = function(item)
                local path = require("snacks.picker.util").path(item)
                local stat = path and vim.uv.fs_stat(path)
                item.mtime = stat and stat.mtime.sec or 0
              end,
              sort = { fields = { "score:desc", "mtime:desc" } },
            }
          end,
          desc = "Find Cursor Plans",
        },
        ["<leader>gr"] = { name = "LSP" },
        ["<leader>a"] = { name = "AI" },
        ["<leader>aa"] = {
          function() require("agentic").add_selection_or_file_to_context() end,
          desc = "Add to Agentic to Context",
        },
        ["<leader>ad"] = {
          function() require("agentic").add_current_line_diagnostics() end,
          desc = "Add Diagnostics for current line",
        },
        ["<leader>aD"] = {
          function() require("agentic").add_current_line_diagnostics() end,
          desc = "Add Diagnostics for current buffer",
        },
        ["<leader>an"] = {
          function() require("agentic").new_session() end,
          desc = "New Session",
        },
        ["<leader>as"] = {
          function() require("agentic").stop_generation() end,
          desc = "Stop generation",
        },
        ["<leader>ar"] = {
          function() require("agentic").restore_session() end,
          desc = "Restore session",
        },
        ["<leader>ap"] = {
          function() require("agentic").switch_provider() end,
          desc = "Switch ACP provider",
        },
        ["<leader>al"] = {
          function() require("agentic").rotate_layout() end,
          desc = "Layout rotate",
        },
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
        ["<leader>bh"] = { "<cmd>call DeleteHiddenBuffers()<cr>", desc = "Close Hidden buffers" },

        ["<leader>gG"] = { "<cmd>:vertical Git<CR>", desc = "Fugitive Status" },
        ["<leader>gm"] = { "<cmd>:Git mergetool<CR>", desc = "Fugitive Mergetool" },
        ["<leader>gD"] = { "<cmd>:Gdiffsplit!<CR>", desc = "Fugitive Diff" },
        ["<leader>gq"] = { "<cmd>:vertical Git log --decorate<CR>", desc = "git log (pretty)" },
        ["<leader>gT"] = { "<cmd>:Gitsigns<CR>", desc = "Gitsigns commands" },
        -- I don't use the default gL, which opens a popup with blame info
        ["<leader>gL"] = { "<cmd>:Git blame<CR>", desc = "Git Blame (by line)" },
        --Custom tasks
        ["<leader>ta"] = {
          '<cmd>TermExec size=80 direction=vertical cmd="cursor-agent"<cr>',
          desc = "Cursor in terminal",
        },
        ["<leader>tt"] = {
          "<cmd>ToggleTerm<cr>",
          desc = "Toggle",
        },
        ["<leader>T"] = { name = "Tabs" },
        ["<leader>Tr"] = {
          ":TabooRename<Space>",
          desc = "Rename",
        },
        ["<leader>TR"] = {
          ":TabooReset<Space>",
          desc = "Reset name",
        },
        ["<leader>To"] = {
          ":TabooOpen<Space>",
          desc = "Open with name",
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
        -- tables with just a `desc` key will be registered with which-key if it's installed
        -- this is useful for naming menus
        -- ["<Leader>b"] = { desc = "Buffers" },

        -- setting a mapping to false will disable it
        -- ["<C-S>"] = false,
      },
      v = {
        ["<leader>a"] = { name = "AI" },
        ["<leader>aa"] = {
          function() require("agentic").add_selection_or_file_to_context() end,
          desc = "Add to Agentic to Context",
        },
        ["<leader>ad"] = {
          function() require("agentic").add_current_line_diagnostics() end,
          desc = "Add Diagnostics for current line",
        },
      },
    },
  },
}
