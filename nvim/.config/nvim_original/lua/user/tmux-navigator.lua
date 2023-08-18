vim.cmd [[
let g:tmux_navigator_no_mappings = 1

" these are just the default mappings
noremap <silent> <C-h> :<C-U>TmuxNavigateLeft<cr>
noremap <silent> <C-j> :<C-U>TmuxNavigateDown<cr>
noremap <silent> <C-k> :<C-U>TmuxNavigateUp<cr>
noremap <silent> <C-l> :<C-U>TmuxNavigateRight<cr>

" Disable this one, so I can ose <C-\> for other keybindings
" noremap <silent> <C-\> :<C-U>TmuxNavigatePrevious<cr>
]]
