vim.g.copilot_no_tab_map = true

vim.api.nvim_set_keymap("i", "<M-Tab>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""

-- vim.keymap.set('i', '<M-.>', '<Plug>(copilot-next)')
-- vim.keymap.set('i', '<M-,>', '<Plug>(copilot-previous)')
