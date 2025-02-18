return {

	{
		"goolord/alpha-nvim",
		opts = function(_, opts)
			opts.section.header.val = {
				-- change the header section value
				"Neovim",
			}
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		opts = function(_, opts)
			opts.defaults.layout_config = {
				horizontal = { prompt_position = "top", preview_width = 0.55 },
				-- vertical = { mirror = false },
				width = 0.95,
				height = 0.95,
				preview_cutoff = 120,
			}
			-- opts.defaults.layout_config.vertical.width = 1
			-- opts.defaults.layout_config.horizontal.width = 1
			-- opts.pickers.find_files.theme = "ivy"
			-- opts.pickers.find_files.layout_config.vertical.width = 0.9
			-- opts.pickers.find_files.layout_config.vertical.height = 0.8
			-- print(vim.inspect(opts))
			-- require("telescope").setup(opts)
		end,
	},
}
