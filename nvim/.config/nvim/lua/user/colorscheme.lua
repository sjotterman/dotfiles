vim.cmd [[
"   set background=dark
" try
"   " colorscheme humanoid
"   colorscheme omni
"   " colorscheme base16-ayu-dark
" catch /^Vim\%((\a\+)\)\=:E185/
"   colorscheme default
" endtry
colorscheme kanagawa
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
