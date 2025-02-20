return {
  {
    "goolord/alpha-nvim",
    opts = function(_, opts) -- override the options using lazy.nvim
      opts.section.header.val = { -- change the header section value
        "Neovim",
      }
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      opts.defaults.layout_config = {
        horizontal = { prompt_position = "top", preview_width = 0.55 },
        width = 0.95,
        height = 0.95,
        preview_cutoff = 120,
      }
    end,
  },
}
