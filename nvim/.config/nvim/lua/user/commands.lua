  vim.cmd [[
  function! DeleteHiddenBuffers()
  let tpbl=[]
  let closed = 0
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    if getbufvar(buf, '&mod') == 0
      silent execute 'bwipeout' buf
      let closed += 1
    endif
  endfor
  echo "Closed ".closed." hidden buffers"
endfunction
  ]]

vim.cmd[[
function! FullScreenToggle()
    if g:neovide_fullscreen
        let g:neovide_fullscreen = 0
    else
        let g:neovide_fullscreen = 1
    endif
endfunction
]]

vim.cmd[[
command! W write
]]

vim.cmd[[
command! Wq wq
]]

vim.cmd[[
command! Wqall wqall
]]

vim.cmd[[
command! Vsp vsplit
]]

function _G.goto_neovim_config()
  vim.api.nvim_command("tcd ~/dotfiles/nvim/.config/nvim")
  require('telescope.builtin').find_files()
end

-- If in a typescript file, use the typescript.nvim plugin to go to definition,
-- otherwise use the LSP
function _G.my_goto_definition()
  if vim.bo.filetype == "typescriptreact" or vim.bo.filetype == 'typescript' then
    vim.api.nvim_command("TypescriptGoToSourceDefinition")
  else
    vim.lsp.buf.definition()
  end
end
