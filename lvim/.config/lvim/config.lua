
-- general
lvim.format_on_save = false
lvim.lint_on_save = true
lvim.colorscheme = "onedarkhc"
vim.opt.wrap = true
lvim.lsp.diagnostics.virtual_text = false
HOME = os.getenv("HOME")
vim.opt.spellfile= HOME.."/.vim/spell/en.utf-8.add"

vim.api.nvim_set_option('list', true)
vim.opt.listchars = { tab = ">-", trail = "x"}

local components = require("lvim.core.lualine.components")
-- Languages to syntax highlight inside of Markdown code blocks
vim.g.markdown_fenced_languages = { 'typescript',
  'javascript',
  'bash=sh',
  'go',
  'html',
  'sql'
}

lvim.builtin.lualine.sections.lualine_b = {
  components.filename
}

-- Hide lsp from default lualine config
lvim.builtin.lualine.sections.lualine_x = {
  components.treesitter,
  components.filetype
}
-- Add location to default
lvim.builtin.lualine.sections.lualine_z = {
  'location',
  components.scrollbar
}
-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = ""
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>lua require'telescope'.extensions.project.project{}<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  t = { "<cmd>TroubleToggle<cr>", "toggle" },
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  R = { "<cmd>TroubleRefresh<cr>", "Refresh" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
}

lvim.builtin.terminal.direction = "horizontal"
lvim.builtin.which_key.mappings["k"] = {
  name = "+Keybinds for commands",
  b = { "<cmd>TermExec cmd=\"build-component-typing\"<cr>", "Build NA Component Typing" },
  p = { "<cmd>TermExec cmd=\"publish-vNext\"<cr>", "Publish vNext" },
  i = { "<cmd>TermExec cmd=\"import-vNext\"<cr>", "Import vNext" },
  t = { "<cmd>TermExec cmd=\"pwd\"<cr>", "Test / pwd" },
  y = { "<cmd>TermExec cmd=\"yalc-push\"<cr>", "yalc-push" },
  Y = { "<cmd>e /Users/samuel.otterman/bin/yalc-push<cr>", "yalc-push (edit)" },
  g = { "<cmd>TermExec cmd=\"go run .\"<cr>", "go run ." },
}
lvim.builtin.which_key.mappings["G"] = {
  name = "+Go",
  c = { "<cmd>GoCoverageToggle<cr>", "Coverage Toggle" },
  C = { "<cmd>GoCoverageBrowser<cr>", "Coverage Browser" },
  l = { "<cmd>GoLint<cr>", "Lint" },
  r = { "<cmd>GoRun<cr>", "Run" },
  b = { "<cmd>GoBuild<cr>", "Build" },
  t = { "<cmd>GoTest<cr>", "Test" },
  T = { "<cmd>TermExec cmd=\"go test -v\"<cr>", "go test -v" },
  B = { "<cmd>TermExec cmd=\"go test -v --bench .\"<cr>", "go test benchmarks" },
  G = { "<cmd>TermExec cmd=\"go-test-cover\"<cr>", "go-test-cover" },
}

lvim.keys.normal_mode["]c"] = "<cmd>lua require 'gitsigns'.next_hunk()<cr>"
lvim.keys.normal_mode["[c"] = "<cmd>lua require 'gitsigns'.prev_hunk()<cr>"
lvim.keys.normal_mode["]g"] = "<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = lvim.lsp.popup_border}})<cr>"
lvim.keys.normal_mode["[g"] = "<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = lvim.lsp.popup_border}})<cr>"

lvim.builtin.which_key.mappings["sn"] = { "<cmd>:Telescope neoclip<CR>", "Neoclip" }

local Terminal  = require('toggleterm.terminal').Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  hidden = true,
 direction = "float"
}
)

function _Lazygit_toggle()
  lazygit:toggle()
end

-- TODO: figure out why this mapping won't work
lvim.builtin.which_key.mappings["gg"] = { "<cmd>lua _Lazygit_toggle()<CR>", "lazygit" }
lvim.builtin.which_key.mappings["gt"] = { "<cmd>lua _Lazygit_toggle()<CR>", "lazygit" }
lvim.builtin.which_key.mappings["gG"] = { "<cmd>:vertical Git<CR>", "Git Status" }
lvim.builtin.which_key.mappings["gV"] = { "<cmd>:vertical Git log<CR>", "git log (Vertical)" }
lvim.builtin.which_key.mappings["gL"] = { "<cmd>:Git blame<CR>", "Git Blame (by line)" }
lvim.builtin.which_key.mappings["gP"] = { "<cmd>lua _Prs_toggle()<cr>", "gh prs" }
lvim.builtin.which_key.mappings["gX"] = { "<cmd>:e ~/Library/Application Support/prs/sections.yml<CR>", "configure gh prs" }
lvim.builtin.which_key.mappings["gv"] = { "<cmd>:vertical Gdiffsplit!<CR>", "Git Diff (vertical)" }
lvim.builtin.which_key.mappings["bn"] = { "<cmd>:BufferNext<CR>", "Buffer Next" }
lvim.builtin.which_key.mappings["bp"] = { "<cmd>:BufferPrevious<CR>", "Buffer Prev" }
-- Doesn't work in visual mode? have to select then cancel selection
lvim.builtin.which_key.mappings["lF"] = { "<cmd>lua vim.lsp.buf.range_formatting()<cr>", "Format selection" }
lvim.builtin.which_key.mappings["j"] = { "<cmd>:BufferPick<CR>", "Buffer Jump" }
lvim.builtin.which_key.mappings["O"] = { "<C-W>o", "Close other windows" }
lvim.builtin.which_key.mappings["S"] = {
  name = "+Sessions",
  s = { "<cmd>:mksession! ~/.config/nvim/config/default-session.vim<CR>", "Save default session" },
  l = { "<cmd>:source ~/.config/nvim/config/default-session.vim<CR>", "Load default session" },
}
-- lvim.keys.normal_mode["<C-;>"] = "<cmd>lua vim.lsp.buf.signature_help()<CR>"
-- lvim.keys.insert_mode["<C-;>"] = "<cmd>lua vim.lsp.buf.signature_help()<CR>"

lvim.builtin.which_key.mappings["P"] = {
  name = "+Projects",
  r = { "<cmd>:ProjectRoot<CR>", "Change Project Root" },
}

lvim.builtin.which_key.mappings["n"] = {
  name = "+Notes",
  D = { '<cmd>lua require("telekasten").find_daily_notes()<CR>', "Daily notes" },
  F = { '<cmd>lua require("telekasten").find_friends()<CR>', "Find Friends" },
  b = { '<cmd>lua require("telekasten").show_backlinks()<CR>', "show Backlinks" },
  c = { '<cmd>lua require("telekasten").show_calendar()<CR>', "show Calendar" },
  d = { '<cmd>lua require("telekasten").toggle_todo()<CR>', "toggle Done" },
  f = { '<cmd>lua require("telekasten").find_notes()<CR>', "Find Notes" },
  g = { '<cmd>lua require("telekasten").follow_link()<CR>', "Go to link" },
  i = { '<cmd>lua require("telekasten").insert_link()<CR>', "Insert link" },
  n = { '<cmd>lua require("telekasten").new_note()<CR>', "New note" },
  s = { '<cmd>lua require("telekasten").search_notes()<CR>', "Search notes for word" },
  t = { '<cmd>lua require("telekasten").goto_today()<CR>', "Today" },
  y = { '<cmd>lua require("telekasten").yank_notelink()<CR>', "Yank link to current note" }
}

local prs_term = Terminal:new({
  cmd = "gh prs",
   hidden = true,
   direction = "float"
}
)

function _Prs_toggle()
  prs_term:toggle()
end



-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 1
lvim.builtin.bufferline.active = false

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings
-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- set a formatter if you want to override the default lsp one (if it exists)
-- lvim.lang.python.formatters = {
--   {
--     exe = "black",
--     args = {}
--   }
-- }
-- set an additional linter
-- lvim.lang.python.linters = {
--   {
--     exe = "flake8",
--     args = {}
--   }
-- }

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    exe = "prettier",
    filetypes = {
      "javascriptreact",
      "javascript",
      "typescriptreact",
      "typescript",
      "markdown",
    },
  },
  {
    exe= "gofmt",
    filetypes = {"go"}
  }
}

require("telescope").load_extension "neoclip"

-- Additional Plugins
lvim.plugins = {
    {"lunarvim/colorschemes"},
    {"jacoborus/tender.vim"},
    {"rebelot/kanagawa.nvim"},
    {"danilo-augusto/vim-afterglow"},
    {"aonemd/kuroi.vim"},
    {"rebelot/kanagawa.nvim" },
    {"wuelnerdotexe/vim-enfocado"},
    {"pacokwon/onedarkhc.vim"},
    { "bluz71/vim-moonfly-colors" },
    {"tpope/vim-rhubarb"},
    {"pantharshit00/vim-prisma"},
    {'renerocksai/telekasten.nvim'},
  -- {'renerocksai/calendar-vim'},
    {"gcmt/taboo.vim"},
    {"tpope/vim-fugitive"},
    {"tpope/vim-surround"},
    {"romainl/vim-qf"},
    {'navarasu/onedark.nvim'},
    {
      "AckslD/nvim-neoclip.lua",
      config = function()
        require('neoclip').setup({
        default_register = '+'
        })
      end,
    },
    {"fatih/vim-go", run=":GoInstallBinaries"}, -- run :GoInstallBinaries after installing package
    {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      end
    }
    -- Don't automatically display function signature while typing
    -- {
    --     "ray-x/lsp_signature.nvim",
    --     config = function() require"lsp_signature".on_attach() end,
    --     event = "InsertEnter"
    -- }
}

-- Don't automatically change directories when opening a file
lvim.builtin.project.manual_mode = true

-- Taboo  tab name defaults to tabNum - working directory
vim.g.taboo_tab_format = " %N-%P "

-- Use this option to enable/disable the default mapping of CTRL-],
-- <C-LeftMouse>, g<C-LeftMouse> and (`gd`) for GoDef and CTRL-t for :GoDefPop.
vim.g.go_def_mapping_enabled = 0

-- Display short file paths in quickfix window
vim.g.qf_shorten_path = 1
-- Always display quickfix window below all windows
vim.g.qf_window_bottom = 1


lvim.builtin.telescope.defaults.path_display.shorten = 10

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
lvim.autocommands.custom_groups = {
  -- Don't show tabs / trailing spaces in go
  { "BufWinEnter", "*.go", "setlocal nolist" },
}


-- Telekasten setup
local home = vim.fn.expand("~/Dropbox/notes")
require('telekasten').setup({
    home         = home,
    dailies      = home,
    -- dailies      = home .. '/' .. 'daily',
    -- weeklies     = home .. '/' .. 'weekly',
    -- templates    = home .. '/' .. 'templates',

    -- image subdir for pasting
    -- subdir name
    -- or nil if pasted images shouldn't go into a special subdir
	-- image_subdir = "img",

    -- markdown file extension
    extension    = ".md",

    -- following a link to a non-existing note will create it
    follow_creates_nonexisting = true,
    dailies_create_nonexisting = true,
    weeklies_create_nonexisting = true,

    -- template for new notes (new_note, follow_link)
    -- set to `nil` or do not specify if you do not want a template
    -- template_new_note = home .. '/' .. 'templates/new_note.md',

    -- template for newly created daily notes (goto_today)
    -- set to `nil` or do not specify if you do not want a template
    -- template_new_daily = home .. '/' .. 'templates/daily.md',

    -- template for newly created weekly notes (goto_thisweek)
    -- set to `nil` or do not specify if you do not want a template
    -- template_new_weekly= home .. '/' .. 'templates/weekly.md',

	-- image link style
	-- wiki:     ![[image name]]
	-- markdown: ![](image_subdir/xxxxx.png)
	image_link_style = "markdown",

    -- integrate with calendar-vim
    plug_into_calendar = true,
    calendar_opts = {
        -- calendar week display mode: 1 .. 'WK01', 2 .. 'WK 1', 3 .. 'KW01', 4 .. 'KW 1', 5 .. '1'
        weeknm = 4,
        -- use monday as first day of week: 1 .. true, 0 .. false
        calendar_monday = 0,
        -- calendar mark: where to put mark for marked days: 'left', 'right', 'left-fit'
        calendar_mark = 'left-fit',
    }
})

vim.g.calendar_monday = 0
  -- let g:calendar_monday = 1
