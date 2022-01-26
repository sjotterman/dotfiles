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
  ["O"] = { "<C-W>o", "Close other windows"},
  ["b"] = {
    "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
    "Buffers",
  },
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
  -- ["w"] = { "<cmd>w!<CR>", "Save" },
  -- ["q"] = { "<cmd>q!<CR>", "Quit" },
  ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  -- ["f"] = {
  --   "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
  --   "Find files",
  -- },
  ["f"] = { "<cmd>Telescope find_files<CR>", "Find File" },
  ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
  ["P"] = { "<cmd>Telescope projects<cr>", "Projects" },

  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },

  g = {
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    G = { "<cmd>:vertical Git<CR>", "Git Status" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    L = { "<cmd>:Git blame<CR>", "Git Blame (by line)" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    P = { "<cmd>lua _PRS_TOGGLE()<cr>", "gh prs" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
    v = { "<cmd>:vertical Gdiffsplit!<CR>", "Git Diff (vertical)" },
    V = { "<cmd>:vertical Git log<CR>", "git log (Vertical)" },
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
    d = { "<cmd>lua _LAZYDOCKER_TOGGLE()<CR>", "Lazydocker" },
    n = { "<cmd>lua _LAZYNPM_TOGGLE()<CR>", "Lazynpm" },
    b = { "<cmd>TermExec cmd=\"build-component-typing\"<cr>", "Build NA Component Typing" },
    p = { "<cmd>TermExec cmd=\"publish-vNext\"<cr>", "Publish vNext" },
    i = { "<cmd>TermExec cmd=\"import-vNext\"<cr>", "Import vNext" },
    t = { "<cmd>TermExec cmd=\"pwd\"<cr>", "Test / pwd" },
    y = { "<cmd>TermExec cmd=\"yalc-push\"<cr>", "yalc-push" },
    Y = { "<cmd>e /Users/samuel.otterman/bin/yalc-push<cr>", "yalc-push (edit)" },
    g = { "<cmd>TermExec cmd=\"go run .\"<cr>", "go run ." },
  },
  l = {
    name = "LSP",
    A = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    a = { "<cmd>CodeActionMenu<cr>", "Regular Code Action" },
    d = {
      "<cmd>Telescope diagnostics bufnr=0<cr>",
      "Document Diagnostics",
    },
    w = {
      "<cmd>Telescope diagnostics<cr>",
      "Workspace Diagnostics",
    },
    f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
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
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
  },
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
    n = { '<cmd>lua require("telekasten").new_note()<CR>', "New note" },
    s = { '<cmd>lua require("telekasten").search_notes()<CR>', "Search notes for word" },
    t = { '<cmd>lua require("telekasten").goto_today()<CR>', "Today" },
    y = { '<cmd>lua require("telekasten").yank_notelink()<CR>', "Yank link to current note" }
  },
  N = {
    name = "NX",
    b = { "<cmd>TermExec dir=\"~/workspace/shipyard\" cmd=\"npx nx run create-api:build-prisma --configuration=clean\"<cr>", "Build Prisma" },
    C = { "<cmd>TermExec dir=\"~/workspace/shipyard\" cmd=\"npx nx run create-api:database --configuration=clean\"<cr>", "Clean Create DB" },
  },
  s = {
    name = "Search",
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    g = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    n = { "<cmd>:Telescope neoclip<CR>", "Neoclip" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    t = { "<cmd>Telescope live_grep<cr>", "Text" },
    T = { "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find{}<cr>", "Text in buffer" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    v = { "<cmd>lua require('telescope.builtin').vim_options{}<cr>", "Vim Options" },
    p = {
      "<cmd>lua require('telescope.builtin.internal').colorscheme({enable_preview = true})<cr>",
      "Colorscheme with Preview",
    },
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
    s = { "<cmd>lua _SHIPYARD_TOGGLE()<cr>", "Shipyard" },
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
    w = { "<cmd>Trouble workspace_diagnostics<cr>", "Diagnostics" },
  }
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register({
["]c"] = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next hunk"},
["[c"] = {"<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev hunk"},
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
}

which_key.register(visual_mappings, visual_opts)
