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
  "tpope/vim-surround",
  "tpope/vim-unimpaired",
  "gcmt/taboo.vim",
  "romainl/vim-qf",
  "editorconfig/editorconfig-vim",
  "toppair/reach.nvim",
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
  { "fatih/vim-go",            build = ":GoInstallBinaries" },
  {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons"
  },
  "https://github.com/alok/notational-fzf-vim",
  { "junegunn/fzf",           build = "fzf#install()" },
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
  "yonlu/omni.vim",
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
  'haishanh/night-owl.vim',

  -- cmp plugins
  "hrsh7th/nvim-cmp", -- The completion plugin
  "hrsh7th/cmp-buffer", -- buffer completions
  "hrsh7th/cmp-path", -- path completions
  "hrsh7th/cmp-cmdline", -- cmdline completions
  "saadparwaiz1/cmp_luasnip", -- snippet completions
  "hrsh7th/cmp-nvim-lsp",
  "MunifTanjim/prettier.nvim",

  -- snippets
  "L3MON4D3/LuaSnip", --snippet engine
  "rafamadriz/friendly-snippets", -- a bunch of snippets to use

  -- LSP
  "neovim/nvim-lspconfig", -- enable LSP
  { "williamboman/mason.nvim" },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v1.x",
    dependencies = {
      -- LSP Support
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },

      -- Snippets
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
    },
  },
  "tamago324/nlsp-settings.nvim", -- language server settings defined in json for
  "jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
  { "j-hui/fidget.nvim", config = function()
    require("fidget").setup()
  end },
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
  { "akinsho/git-conflict.nvim", version = "*", config = function()
    require("git-conflict").setup()
  end },
  { "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
  "github/copilot.vim"
})
