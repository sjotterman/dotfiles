local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      -- should motions and text_objects be true?
      -- https://github.com/LunarVim/Neovim-from-scratch/commit/6169d6a10b60226a9fca5272b1acbdae5d2d6239
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>", -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
  ["o"] = { "<C-W>o", "Close other windows" },
  d = {
    name = "DiffView",
    c = { "<cmd>:DiffviewClose<cr>", "Close" },
    o = { "<cmd>:DiffviewOpen<cr>", "Open" },
    h = { "<cmd>:DiffviewFileHistory %<cr>", "History (this file)" },
    H = { "<cmd>:DiffviewFileHistory<cr>", "History" },
    t = { "<cmd>:DiffviewToggleFiles<cr>", "Toggle files" },
    r = { "<cmd>:DiffviewRefresh<cr>", "Refresh" },
  },
  ["b"] = {
    "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    "Buffers",
  },
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["C"] = { "<cmd>call DeleteHiddenBuffers()<CR>", "Close all hidden buffers" },
  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  -- ["f"] = {
  --   "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
  --   "Find files",
  -- },
  ["f"] = { "<cmd>Telescope find_files<CR>", "Find File" },
  ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
  ["p"] = { "<cmd>Telescope projects<cr>", "Projects" },
  P = {
    name = "Plugins",
    c = { "<cmd>Lazy clean<cr>", "Clean" },
    s = { "<cmd>Lazy sync<cr>", "Sync" },
    u = { "<cmd>Lazy update<cr>", "Update" },
  },
  g = {
    name = "Git",
    c = { "<cmd>:Git commit<cr>", "Commit" },
    N = { "<cmd>:Git commit --no-verify<cr>", "Commit --no-verify" },
    g = { "<cmd>:vertical Git<CR>", "Git Status" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    L = { "<cmd>:Git blame<CR>", "Git Blame (by line)" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    P = { "<cmd>lua _PRS_TOGGLE()<cr>", "gh prs" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    S = { "<cmd>Telescope git_stash<cr>", "Stash Apply" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    C = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
    D = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "DiffView Open",
    },
    v = { "<cmd>:vertical Gdiffsplit!<CR>", "Git Diff (vertical)" },
    q = { "<cmd>:vertical Git log --decorate<CR>", "git log (pretty)" },
  },
  G = {
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
  },
  k = {
    name = "+Keybinds for commands",
    D = { ":r !date +\"\\%Y-\\%m-\\%d - \\%A\"<cr>", "Insert Date and day" },
    d = { ":r !date +\"\\%Y-\\%m-\\%d\"<cr>", "Insert Date" },
    g = {
      name = "Generate Types",
      d = { "<cmd>TermExec cmd=\"z django && make generate-schema && exit\"<cr>", "Generate Django Schema" },
      w = { "<cmd>TermExec cmd=\"z web && yarn generate && exit\"<cr>", "Generate Web Types" },
      m = { "<cmd>TermExec cmd=\"z frontend && npm run generate && exit\"<cr>", "Generate Mobile Types" },
    },
    c = { "<cmd>TermExec cmd=\"z django && make clean-run-backend && exit\"<cr>", "make clean-run-backend" },
    f = { "<cmd>call FullScreenToggle()<CR>", "Toggle Neovide Full screen" },
    B = { ":IndentBlanklineToggle<cr>", "Show Blankline indentation" },
    t = { ":r !date +\"\\%I:\\%M \\%p\"<cr>", "Insert Time" },
    y = { "<cmd>TermExec cmd=\"yalc-push\"<cr>", "yalc-push" },
    G = { "<c-g>", "Ctrl-g (get file path)" },
  },
  l = {
    name = "LSP",
    A = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    a = { "<cmd>CodeActionMenu<cr>", "Regular Code Action" },
    d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to Definition" },
    D = {
      "<cmd>Telescope diagnostics bufnr=0<cr>",
      "Document Diagnostics",
    },
    e = {
      "<cmd>:EslintFixAll<cr>",
      "Eslint Fix All",
    },
    w = {
      "<cmd>Telescope diagnostics<cr>",
      "Workspace Diagnostics",
    },
    f = { "<cmd>:LspZeroFormat<cr>", "Format" },
    g = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature" },
    h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
    F = { "<cmd>lua vim.lsp.buf.range_formatting()<cr>", "Format selection" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = {
      "<cmd>lua vim.diagnostic.goto_next()<CR>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.diagnostic.goto_prev()<cr>",
      "Prev Diagnostic",
    },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    o = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Open Float" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    R = { "<cmd>syntax sync fromstart<cr>", "Refresh Syntax (sync fromstart)" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
    t = {
      name = "TypeScript",
      d = { "<cmd>TypescriptGoToSourceDefinition<cr>", "Go to Source Definition" },
      m = { "<cmd>TypescriptAddMissingImports<cr>", "Add Missing Imports" },
      o = { "<cmd>TypescriptOrganizeImports<cr>", "Organize Imports" },
      r = { "<cmd>TypescriptRenameFile<cr>", "Rename File" },
      u = { "<cmd>TypescriptRemoveUnused<cr>", "Remove Unused Variables" },
    },
  },
  ["m"] = { "<cmd>:make<cr>", "Make" },
  n = {
    name = "+Notes",
    D = { '<cmd>lua require("telekasten").find_daily_notes()<CR>', "Daily notes" },
    F = { '<cmd>lua require("telekasten").find_friends()<CR>', "Find Friends" },
    b = { '<cmd>lua require("telekasten").show_backlinks()<CR>', "show Backlinks" },
    c = { '<cmd>lua require("telekasten").show_calendar()<CR>', "show Calendar" },
    d = { '<cmd>lua require("telekasten").toggle_todo()<CR>', "toggle Done" },
    f = { '<cmd>lua require("telekasten").find_notes()<CR>', "Find Notes" },
    g = { '<cmd>lua require("telekasten").follow_link()<CR>', "Go to link" },
    i = { '<cmd>lua require("telekasten").insert_link()<CR>', "Insert link" },
    N = { '<cmd>lua require("telekasten").new_note()<CR>', "New note" },
    n = { ':Telekasten<cr>', "Telekasten Command" },
    S = { '<cmd>lua require("telekasten").search_notes()<CR>', "Search notes for word" },
    t = { '<cmd>lua require("telekasten").goto_today()<CR>', "Today" },
    T = { '<cmd>lua require("telekasten").show_tags()<CR>', "Today" },
    y = { '<cmd>lua require("telekasten").yank_notelink()<CR>', "Yank link to current note" },
    s = { '<cmd>NV<CR>', 'Search (Notational FZF)' },
  },
  R = {
    name = "Reach",
    b = { "<cmd>ReachOpen buffers<cr>", "Buffers" },
    m = { "<cmd>ReachOpen marks<cr>", "Marks" },
    t = { "<cmd>ReachOpen tabpages<cr>", "Tabpages" },
  },
  r = {
    name = "refactoring",
    i = { "<cmd>lua require('refactoring').refactor('Inline Variable')<CR><cr>", "Inline Variable" },
    b = { "<Cmd>lua require('refactoring').refactor('Extract Block')<CR>", "Extract block" },
    B = { "<Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>", "Extract block to file" },
  },
  s = {
    name = "Search",
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    d = { "<cmd>Telescope lsp_definitions<cr>", "Definitions" },
    i = { "<cmd>Telescope lsp_implementations<cr>", "Implementations" },
    D = { "<cmd>Telescope lsp_type_definitions<cr>", "Type Definitions" },
    g = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    H = { "<cmd>Telescope highlights<cr>", "Highlight groups" },
    m = { "<cmd>Telescope marks<cr>", "Man Pages" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    n = { "<cmd>:Telescope neoclip<CR>", "Neoclip" },
    F = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    r = { "<cmd>Telescope lsp_references<cr>", "References" },
    y = { "<cmd>Telescope treesitter<cr>", "treesitter symbols" },
    s = { "<cmd>Telescope resume<cr>", "Resume Search" },
    S = { "<cmd>Telescope spell_suggest<cr>", "Spell suggestions" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    t = { "<cmd>Telescope live_grep<cr>", "Text" },
    T = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find{}<cr>", "Text in buffer" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    v = { "<cmd>lua require('telescope.builtin').vim_options{}<cr>", "Vim Options" },
    p = {
      "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
      "Colorscheme with Preview",
    },
    q = { "<cmd>lua require('telescope.builtin').quickfix{}<cr>", "quickfix list" },
    Q = { "<cmd>lua require('telescope.builtin').quickfixhistory{}<cr>", "quickfix history" },
  },
  S = {
    name = "Sessions",
    r = { "<cmd>:ProjectRoot<CR>", "Change Project Root" },
    s = { "<cmd>:mksession! ~/.config/nvim/config/default-session.vim<CR>", "Save default session" },
    l = { "<cmd>:source ~/.config/nvim/config/default-session.vim<CR>", "Load default session" },
  },
  T = {
    name = "Terminal",
    n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
    u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
    t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
    p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python3" },
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  },
  t = {
    name = "Trouble",
    t = { "<cmd>TroubleToggle<cr>", "toggle" },
    r = { "<cmd>Trouble lsp_references<cr>", "References" },
    R = { "<cmd>TroubleRefresh<cr>", "Refresh" },
    f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
    d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
    q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
    l = { "<cmd>Trouble loclist<cr>", "LocationList" },
    n = { "<cmd>lua require(\"trouble\").next({skip_groups = true, jump = true})<cr>", "Next" },
    p = { "<cmd>lua require(\"trouble\").previous({skip_groups = true, jump = true})<cr>", "Prev" },
    w = { "<cmd>Trouble workspace_diagnostics<cr>", "Diagnostics" },
  },
  u = {
    name = "Unit Test",
    t = { "<cmd>:TestNearest<cr>", "TestNearest" },
    T = { "<cmd>:TestFile<cr>", "TestFile" },
    a = { "<cmd>:TestSuite<cr>", "TestSuite" },
    l = { "<cmd>:TestLast<cr>", "TestLast" },
    g = { "<cmd>:TestVisit<cr>", "TestVisit" },

  },
  w = {
    name = "Window",
    t = { "<cmd>:tabnew<cr>", "new Tab" },
    c = { "<cmd>:tabclose<cr>", "Close Tab" },
    n = { "<cmd>lua goto_neovim_config()<cr>", "Go to Neovim COnfig" },
  }
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register({
  ["]c"] = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next hunk" },
  ["[c"] = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev hunk" },
  ["]g"] = {
    "<cmd>lua vim.diagnostic.goto_next()<CR>",
    "Next Diagnostic",
  },
  ["[g"] = {
    "<cmd>lua vim.diagnostic.goto_prev()<CR>",
    "Prev Diagnostic",
  }
})

local visual_opts = {
  mode = "v", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local visual_mappings = {
  l = {
    name = "LSP",
    a = { "<cmd>CodeActionMenu<cr><esc>", "Advanced Code Action" },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    f = { "<cmd>lua vim.lsp.buf.range_formatting()<cr>", "Format selection" },
  },
  r = {
    name = "refactor",
    r = { "<Esc><Cmd>lua require('refactoring').select_refactor()<CR>", "Select Refactor" },
    e = { "<Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>", "Extract function" },
    f = { "<Esc><Cmd>lua require('refactoring').refactor('Extract Function to File')<CR>", "Extract function to file" },
    v = { "<Esc><Cmd>lua require('refactoring').refactor('Extract variable')<CR>", "Extract Variable" },
    i = { "<Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>", "Inline Variable" },
  },
}

which_key.register(visual_mappings, visual_opts)
