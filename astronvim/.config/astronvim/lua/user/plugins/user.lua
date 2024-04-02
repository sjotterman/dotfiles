
return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  {
    "cseickel/diagnostic-window.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    -- fixme
    lazy = false,
  },
  { "tpope/vim-fugitive", event = "User AstroGitFile" },
  { "tpope/vim-rhubarb", event = "User AstroGitFile" },
  {
    "dotsilas/darcubox-nvim",
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup {
        background_colour = "#000000",
      }
    end,
  },
  { "Shatur/neovim-ayu" },
  { "nvimdev/zephyr-nvim" },
  { "rileytwo/kiss", 
  },
  -- {
  --   "ThePrimeagen/harpoon",
  --   config = function()
  --     require("harpoon").setup {
  --       menu = {
  --         width = math.max(75, vim.api.nvim_win_get_width(0) - 4),
  --       },
  --     }
  --   end,
  -- },
  --
  -- {
  --   "pmizio/typescript-tools.nvim",
  --   -- init = function() astronvim.lsp.skip_setup = utils.list_insert_unique(astronvim.lsp.skip_setup, "tsserver") end,
  --   lazy = false,
  --   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  --   ft = {
  --     "typescript",
  --     "typescriptreact",
  --     "javascript",
  --     "javascriptreact",
  --   },
  --   -- opts = {},
  -- },
  -- { "dmmulroy/tsc.nvim", cmd = { "TSC" }, opts = {} },
}
