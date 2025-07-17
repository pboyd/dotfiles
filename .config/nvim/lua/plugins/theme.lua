return {
    { "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[
                set background=dark
                colorscheme gruvbox
            ]])
        end,
    },
}
