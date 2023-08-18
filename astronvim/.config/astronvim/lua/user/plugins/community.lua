return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- example of imporing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.colorscheme.sonokai" },
  { import = "astrocommunity.colorscheme.kanagawa-nvim" },
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  { import = "astrocommunity.completion.copilot-lua" },
  { import = "astrocommunity.git.diffview-nvim" },
  { import = "astrocommunity.motion.mini-bracketed" },
  { import = "astrocommunity.editing-support.neogen" },
  { import = "astrocommunity.editing-support.refactoring-nvim" },
}
