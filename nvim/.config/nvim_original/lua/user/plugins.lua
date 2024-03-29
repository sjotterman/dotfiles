local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Autocommand that reloads neovim whenever you save the plugins.lua file



-- Install your plugins here
require("lazy").setup({
  -- My plugins here
  "nvim-lua/popup.nvim", -- An implementation of the Popup API from vim in Neovim
  "nvim-lua/plenary.nvim", -- Useful lua functions used ny lots of plugins
  "windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
  { 'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end
  },
  "nathom/filetype.nvim", -- faster than the default filetype plugin
  "kyazdani42/nvim-web-devicons",
  "kyazdani42/nvim-tree.lua",
  "moll/vim-bbye",
  {
    "nvim-lualine/lualine.nvim",
    dependencies = "kyazdani42/nvim-web-devicons"
  },
  { "akinsho/toggleterm.nvim", version = "v2.*" },
  "ahmedkhalf/project.nvim",
  "lewis6991/impatient.nvim",
  "lukas-reineke/indent-blankline.nvim",
  "goolord/alpha-nvim",
  "antoinemadec/FixCursorHold.nvim", -- This is needed to fix lsp doc highlight
  "folke/which-key.nvim",
  "folke/neodev.nvim",
  { 'echasnovski/mini.nvim',   version = '*' },
  "tpope/vim-unimpaired",
  "gcmt/taboo.vim",
  "romainl/vim-qf",
  "editorconfig/editorconfig-vim",
  "vim-test/vim-test",
  {
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu"
  },
  {
    "AckslD/nvim-neoclip.lua",
    config = function()
      require("neoclip").setup({
        default_register = "+"
      })
    end,
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" }
    }
  },
  {
    "napmn/react-extract.nvim",
    config = function()
      require("react-extract").setup()
    end,
  },
  { "fatih/vim-go", build = ":GoInstallBinaries" },
  {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons"
  },
  "https://github.com/alok/notational-fzf-vim",
  { "junegunn/fzf", build = "fzf#install()" },
  "junegunn/fzf.vim",
  "christoomey/vim-tmux-navigator",
  'tpope/vim-commentary',

  -- Colorschemes
  "pacokwon/onedarkhc.vim",
  "olimorris/onedarkpro.nvim",
  "rebelot/kanagawa.nvim",
  "navarasu/onedark.nvim",
  "olimorris/onedarkpro.nvim",
  "humanoid-colors/vim-humanoid-colorscheme",
  "VDuchauffour/neodark.nvim",
  "sainnhe/sonokai",
  { "sjotterman/monokai-advanced",
    dependencies = "rktjmp/lush.nvim"
  },
  {
    "cpea2506/one_monokai.nvim",
    config = function()
      require("one_monokai").setup({
        Normal = { bg = "#aeae09" }
      })
    end
  },
  'tanvirtin/monokai.nvim',
  '/ray-x/starry.nvim',

  -- cmp plugins
  "hrsh7th/cmp-cmdline", -- cmdline completions
  { 'dmmulroy/tsc.nvim',
    dependencies = {
      "rcarriga/nvim-notify",
    },
    config = function()
      require("tsc").setup()
    end,
  },
  {
    "Bryley/neoai.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    cmd = {
      "NeoAI",
      "NeoAIOpen",
      "NeoAIClose",
      "NeoAIToggle",
      "NeoAIContext",
      "NeoAIContextOpen",
      "NeoAIContextClose",
      "NeoAIInject",
      "NeoAIInjectCode",
      "NeoAIInjectContext",
      "NeoAIInjectContextCode",
    },
    keys = {
      { "<leader>as", desc = "summarize text" },
      { "<leader>ag", desc = "generate git message" },
    },
    config = function()
      require("neoai").setup({
        -- Options go here
      })
    end,
  },


  -- LSP
  { "williamboman/mason.nvim" },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v1.x",
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      { -- Optional
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional
      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lua" },

      -- Snippets
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
    },
  },
  "tamago324/nlsp-settings.nvim", -- language server settings defined in json for
  "jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
  {
    "j-hui/fidget.nvim",
    -- TODO: update when the new version is released
    -- https://github.com/j-hui/fidget.nvim
    tag = "legacy",
    config = function()
      require("fidget").setup()
    end
  },
  "AndrewRadev/tagalong.vim",
  "jose-elias-alvarez/typescript.nvim",
  {
    "danymat/neogen",
    config = function()
      require("neogen").setup {}
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
    -- Uncomment next line if you want to follow only stable versions
    version = "*"
  },

  -- Telescope
  "nvim-telescope/telescope.nvim",
  {
    "princejoogie/dir-telescope.nvim",
    -- telescope.nvim is a required dependency
    dependencies = { { "nvim-telescope/telescope.nvim" } },
    config = function()
      require("dir-telescope").setup({
        -- these are the default options set
        hidden = true,
        no_ignore = false,
        show_preview = true,
      })
    end,
  },
  "renerocksai/telekasten.nvim",
  "renerocksai/calendar-vim",

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require 'nvim-treesitter.configs'.setup {
        ensure_installed = { "typescript", "vim", "json", "lua", "help", "python", "go", "javascript" }
      }
    end,
    build = ":TSUpdate",
  },
  "JoosepAlviste/nvim-ts-context-commentstring",

  -- Git
  "lewis6991/gitsigns.nvim",
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  -- todo: split out the setup function
  { "akinsho/git-conflict.nvim", version = "*",                         config = true },
  { "sindrets/diffview.nvim",    dependencies = "nvim-lua/plenary.nvim" },
  "github/copilot.vim"
})
