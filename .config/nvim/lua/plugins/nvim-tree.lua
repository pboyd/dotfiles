vim.keymap.set('n', '<Leader>tt', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<Leader>t+', ':NvimTreeResize +20<CR>')
vim.keymap.set('n', '<Leader>t-', ':NvimTreeResize -20<CR>')

return {
    {
        "nvim-tree/nvim-tree.lua",
        opts = {},
    }
}
