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
  { "tpope/vim-fugitive", event = "User AstroGitFile" },
  { "tpope/vim-rhubarb", event = "User AstroGitFile" },
  {
    "dotsilas/darcubox-nvim",
  },
  {
    "ThePrimeagen/harpoon",
    config = function()
      require("harpoon").setup {
        menu = {
          width = math.max(75, vim.api.nvim_win_get_width(0) - 4),
        },
      }
    end,
  },
}
