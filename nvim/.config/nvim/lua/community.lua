-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.lsp.ts-error-translator-nvim" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },
  { import = "astrocommunity.completion.copilot-lua" },
  { import = "astrocommunity.git.diffview-nvim" },
  { import = "astrocommunity.motion.mini-bracketed" },
  { import = "astrocommunity.motion.nvim-surround" },
  { import = "astrocommunity.motion.harpoon" },
  { import = "astrocommunity.colorscheme.cyberdream-nvim" },
  { import = "astrocommunity.colorscheme.github-nvim-theme" },
  { import = "astrocommunity.colorscheme.kanagawa-nvim" },
  -- import/override with your plugins folder
}
