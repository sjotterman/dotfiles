-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  { "rebelot/heirline.nvim", opts = function(_, opts) opts.winbar = nil end },
  -- == Examples of Adding Plugins ==

  { "max397574/better-escape.nvim", enabled = false },
  { "tpope/vim-fugitive", event = "User AstroGitFile" },
  { "tpope/vim-rhubarb", event = "User AstroGitFile" },
  {
    "prochri/telescope-all-recent.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "kkharji/sqlite.lua",
      -- optional, if using telescope for vim.ui.select
      "stevearc/dressing.nvim",
    },
    opts = {
      -- your config goes here
    },
  },
  {
    "akinsho/toggleterm.nvim",
    opts = function(_, opts)
      opts.float_opts = {
        width = vim.o.columns,
        height = vim.o.lines - 4,
      }
    end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  -- {
  --   "goolord/alpha-nvim",
  --   opts = function(_, opts)
  --     -- customize the dashboard header
  --     opts.section.header.val = {
  --       " █████  ███████ ████████ ██████   ██████",
  --       "██   ██ ██         ██    ██   ██ ██    ██",
  --       "███████ ███████    ██    ██████  ██    ██",
  --       "██   ██      ██    ██    ██   ██ ██    ██",
  --       "██   ██ ███████    ██    ██   ██  ██████",
  --       " ",
  --       "    ███    ██ ██    ██ ██ ███    ███",
  --       "    ████   ██ ██    ██ ██ ████  ████",
  --       "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
  --       "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
  --       "    ██   ████   ████   ██ ██      ██",
  --     }
  --     return opts
  --   end,
  -- },

  -- You can disable default plugins as follows:

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call

  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = function(_, opts)
      opts.enable_git_status = true
      -- I think this is what fixes an issue with Fugitive (neo-tree auto opens
      -- on opening Fugitive status)
      opts.follow_current_file = false
      opts.open_files_do_not_replace_types = { "terminal", "trouble", "qf", "fugitive" }
      opts.hijack_netrw_behavior = "disabled"
    end,
  },
  {
    "renerocksai/telekasten.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("telekasten").setup {
        home = vim.fn.expand "~/Dropbox/notes",
      }
    end,
  },
  {
    "ThePrimeagen/harpoon",
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("harpoon").setup {
        settings = {
          save_on_toggle = true,
        },
      }
    end,
  },
}
