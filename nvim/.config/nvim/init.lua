require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.colorscheme"
require "user.cmp"
require "user.comment"
require "user.lsp"
require "user.telescope"
require "user.treesitter"
require "user.autopairs"
require "user.gitsigns"
require "user.nvim-tree"
require "user.lualine"
require "user.toggleterm"
require "user.telekasten_plugin"
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
vim.diagnostic.set = (function(orig)
    return function(namespace, bufnr, diagnostics, opts)
        for _, v in ipairs(diagnostics) do
            v.col = v.col or 0
        end
        return orig(namespace, bufnr, diagnostics, opts)
    end
end)(vim.diagnostic.set)
