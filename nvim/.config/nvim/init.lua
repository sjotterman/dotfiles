require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.colorscheme"
require "user.cmp"
require "user.comment"
require "user.diffview"
require "user.lspconfig"
require "user.telescope"
require "user.treesitter"
require "user.autopairs"
require "user.gitsigns"
require "user.nvim-tree"
require "user.lualine"
require "user.reach"
require "user.toggleterm"
require "user.telekasten-plugin"
require "user.taboo"
require "user.project"
require "user.impatient"
require "user.indentline"
require "user.nvim-code-action-menu"
require "user.alpha"
require "user.whichkey"
require "user.vim-qf"
require "user.autocommands"
require "user.editorconfig"


-- temporary hack; neovim requires a column for diagnostics,
-- but the current version of eslint lsp doesn't send it
-- https://github.com/neovim/neovim/issues/16673
-- If this needs to stay here for a while, it might be moved to one of the
-- included LSP files
