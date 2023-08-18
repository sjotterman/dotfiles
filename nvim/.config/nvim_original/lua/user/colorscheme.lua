vim.cmd [[
"   set background=dark
try
  colorscheme sonokai
  let g:sonokai_style = 'atlantis'
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
endtry
]]

-- require("one_monokai").setup({
--   transparent = false,
--   themes = function(colors)
--     return {
--       TabLineFill = { reverse = false, fg = colors.bg, bg = colors.bg },
--       Normal = { bg = colors.black },
--     }
--   end,
-- })
