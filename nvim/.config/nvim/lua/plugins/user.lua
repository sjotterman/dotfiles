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
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
      -- add any opts here
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
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
